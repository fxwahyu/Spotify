//
//  LibraryVM.swift
//  Spotify
//
//  Created by Wahyu Herdianto on 08/12/24.
//

import Foundation

class LibraryVM {
    var playlist: Observable<[Playlist]> = Observable([])
    var listType: Observable<ListType> = Observable(.LIST)
    
    func fetchPlaylistsFromCoreData() {
        do {
            let playlists: [Playlist] = try CoreDataManager.shared.fetch(Playlist.self)
            
            if !playlists.isEmpty {
                playlist.value = playlists
            }
        } catch {
            print("Failed to fetch playlist: \(error)")
        }
    }

}

enum ListType {
    case GRID
    case LIST
}
