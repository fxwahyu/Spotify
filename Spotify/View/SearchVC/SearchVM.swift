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
    
    var searchInput: String = "" {
        didSet {
            searchTracksFromAPI()
        }
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
                completion(true)
            } catch {
                completion(false)
            }
        }
    }
}
