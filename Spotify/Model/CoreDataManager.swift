//
//  CoreDataManager.swift
//  Spotify
//
//  Created by Wahyu Herdianto on 07/12/24.
//

import Foundation
import UIKit
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Spotify")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}

extension CoreDataManager {
    func save<T: NSManagedObject>(_ objectType: T.Type, configuration: (T) throws -> Void) throws {
        let entityName = String(describing: objectType)
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            throw NSError(domain: "CoreDataError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Entity not found"])
        }
        
        let object = T(entity: entity, insertInto: context)
        
        try configuration(object)
        
        do {
            try context.save()
            print("save success")
        } catch {
            context.rollback()
            print("save failed")
            throw error
        }
    }
}

extension CoreDataManager {
    func fetch<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate? = nil) throws -> [T] {
        let entityName = String(describing: objectType)
        let request = NSFetchRequest<T>(entityName: entityName)
        request.predicate = predicate
        
        do {
            return try context.fetch(request)
        } catch {
            throw error
        }
    }
}

extension CoreDataManager {
    func saveNewPlaylist(name: String) throws {
        try save(Playlist.self) { playlist in
            playlist.name = name
        }
    }
    
    func addTrackToPlaylist(playlistName: String, musicModel: TrackModel) throws {
        do {
            let playlists: [Playlist] = try fetch(Playlist.self, predicate: NSPredicate(format: "name == %@", "\(playlistName)"))
            
            try save(Track.self) { music in
                music.artistId = Int64(musicModel.artistId ?? 0)
                music.trackId = Int64(musicModel.trackId ?? 0)
                music.artistName = musicModel.artistName ?? ""
                music.trackName = musicModel.trackName ?? ""
                music.artworkUrl100 = musicModel.artworkUrl100 ?? ""
                music.releaseDate = musicModel.releaseDate ?? ""
                music.country = musicModel.country ?? ""
                playlists.first?.addToTracks(music)
            }
        } catch {
            print("Failed to fetch or add musics: \(error)")
        }
    }
    
    func isPlaylistDuplicated(name: String) -> Bool {
        do {
            let playlists: [Playlist] = try CoreDataManager.shared.fetch(Playlist.self, predicate: NSPredicate(format: "name == %@", "\(name)"))
            if playlists.isEmpty { return false }
            return true
        } catch {
            return true
        }
    }
    
    func isTrackDuplicated(playlistName: String, track: TrackModel) -> Bool {
        do {
            let playlists: [Playlist] = try fetch(Playlist.self, predicate: NSPredicate(format: "name == %@", "\(playlistName)"))
            
            var tracksArray: [Track] = []
            if let tracks = playlists.first?.tracks as? Set<Track> {
                tracksArray = tracks.sorted { $0.trackName ?? "" < $1.trackName ?? "" }
            }
            
            if tracksArray.isEmpty { return false }
            else {
                for t in tracksArray {
                    if t.trackId == track.trackId! { return true }
                }
                return false
            }
        } catch {
            return false
        }
    }
}

extension CoreDataManager {
    func deleteAllData(for entity: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.includesPropertyValues = false
        
        do {
            let objects = try context.fetch(fetchRequest)
            for case let object as NSManagedObject in objects {
                context.delete(object)
            }
            try context.save()
            print("All data deleted successfully from \(entity).")
        } catch let error {
            print("Failed to delete all data from \(entity): \(error.localizedDescription)")
        }
    }
}
