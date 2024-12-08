//
//  PlaylistDetailVM.swift
//  Spotify
//
//  Created by Wahyu Herdianto on 08/12/24.
//

import Foundation

class PlaylistDetailVM {
    var playlistName: String = ""
    var playlist: Observable<[Playlist]> = Observable([])
    
    func fetchPlaylistsFromCoreData() {
        do {
            let playlists: [Playlist] = try CoreDataManager.shared.fetch(Playlist.self, predicate: NSPredicate(format: "name == %@", "\(playlistName)"))
            
            if !playlists.isEmpty {
                playlist.value = playlists
            }
        } catch {
            print("Failed to fetch playlist: \(error)")
        }
    }
    
    func getArrayOfTracks() -> [Track] {
        var tracksArray: [Track] = []
        if let tracks = playlist.value.first?.tracks as? Set<Track> {
                tracksArray = tracks.sorted { $0.trackName ?? "" < $1.trackName ?? "" }
            return tracksArray
        }
        return []
    }
}
