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
        
        // Call the throwing configuration closure
        try configuration(object)
        
        do {
            try context.save()
        } catch {
            context.rollback()
            throw error
        }
    }
}

extension CoreDataManager {
    func fetch<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) throws -> [T] {
        let entityName = String(describing: objectType)
        let request = NSFetchRequest<T>(entityName: entityName)
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        
        do {
            return try context.fetch(request)
        } catch {
            throw error
        }
    }
}

extension CoreDataManager {
    
    // Save a new Playlist with an array of musics
    
    func saveNewPlaylist(name: String) throws {
        try save(Playlist.self) { playlist in
            playlist.name = name
        }
    }
    
    func updatePlaylist(playlist: Playlist, musics: [TrackModel]) throws {
        // Add musics to the playlist
        for musicData in musics {
            try save(Track.self) { music in
                music.wrapperType = musicData.wrapperType
                music.kind = musicData.kind
                music.artistId = Int64(musicData.artistID ?? 0)
                music.collectionId = Int64(musicData.collectionID ?? 0)
                music.trackId = Int64(musicData.trackID ?? 0)
                music.artistName = musicData.artistName
                music.collectionName = musicData.collectionName
                music.trackName = musicData.trackName
                music.collectionCensoredName = musicData.collectionCensoredName
                music.trackCensoredName = musicData.trackCensoredName
                music.artistViewUrl = musicData.artistViewURL
                music.collectionViewUrl = musicData.collectionViewURL
                music.trackViewUrl = musicData.trackViewURL
                music.previewUrl = musicData.previewURL
                music.artworkUrl30 = musicData.artworkUrl30
                music.artworkUrl60 = musicData.artworkUrl60
                music.artworkUrl100 = musicData.artworkUrl100
                music.releaseDate = musicData.releaseDate
                music.collectionExplicitness = musicData.collectionExplicitness
                music.trackExplicitness = musicData.trackExplicitness
                music.discCount = Int16(musicData.discCount ?? 0)
                music.discNumber = Int16(musicData.discNumber ?? 0)
                music.trackCount = Int16(musicData.trackCount ?? 0)
                music.trackNumber = Int16(musicData.trackNumber ?? 0)
                music.trackTimeMillis = Int64(musicData.trackTimeMillis ?? 0)
                music.country = musicData.country
                music.currency = musicData.currency
                music.primaryGenreName = musicData.primaryGenreName
                music.contentAdvisoryRating = musicData.contentAdvisoryRating
                music.isStreamable = musicData.isStreamable ?? true
                music.playlist = playlist
            }
        }
    }
}
