//
//  SearchVM.swift
//  Spotify
//
//  Created by Wahyu Herdianto on 08/12/24.
//

import Foundation

class SearchVM {
    var playlistName: String = ""
    var listOfTracks: Observable<[TrackModel]> = Observable([])
    var listOfRecentSearches: Observable<[Track]> = Observable([])
    var searchInput: String = "" {
        didSet {
            searchTracksFromAPI()
        }
    }
    var listMode: ListMode = .RECENT
    
    enum ListMode {
        case RECENT
        case SEARCH
    }
    
    func searchTracksFromAPI() {
        APICall().fetch(url: APIEndpoint().searchAPI(query: searchInput), dataExpected: BaseResponse<[TrackModel]>.self, method: .GET) { [weak self] data in
            self?.listOfTracks.value = data?.results ?? []
        }
    }
    
    func addTrackToPlaylist(track: TrackModel, completion: @escaping(Bool) -> ()) {
        if CoreDataManager.shared.isTrackDuplicated(playlistName: playlistName, track: track) {
            completion(false)
        } else {
            do {
                try CoreDataManager.shared.addTrackToPlaylist(playlistName: playlistName, musicModel: track)
                UserPreference.shared.addTrackToUserDefault(trackId: track.trackId ?? 0)
                completion(true)
            } catch {
                completion(false)
            }
        }
    }
    
    func isRecentSearchesAvailable() -> Bool {
        return !UserPreference.shared.recentSearchesTrackId.isEmpty
    }
    
    func fetchTracksFromCoreData() {
        do {
            
            let tracks: [Track] = try CoreDataManager.shared.fetch(Track.self)
            
            let filteredTrack = tracks.filter{ UserPreference.shared.recentSearchesTrackId.contains(Int($0.trackId))}
            
            if !tracks.isEmpty {
                self.listOfRecentSearches.value = filteredTrack.reversed()
            }
        } catch {
            print("Failed to fetch playlist: \(error)")
        }
    }
}
