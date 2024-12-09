//
//  Track+CoreDataProperties.swift
//  Spotify
//
//  Created by Wahyu Herdianto on 09/12/24.
//
//

import Foundation
import CoreData


extension Track {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Track> {
        return NSFetchRequest<Track>(entityName: "Track")
    }

    @NSManaged public var artistId: Int64
    @NSManaged public var artistName: String?
    @NSManaged public var artworkUrl100: String?
    @NSManaged public var country: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var trackId: Int64
    @NSManaged public var trackName: String?
    @NSManaged public var kind: String?
    @NSManaged public var playlists: NSSet?

}

// MARK: Generated accessors for playlists
extension Track {

    @objc(addPlaylistsObject:)
    @NSManaged public func addToPlaylists(_ value: Playlist)

    @objc(removePlaylistsObject:)
    @NSManaged public func removeFromPlaylists(_ value: Playlist)

    @objc(addPlaylists:)
    @NSManaged public func addToPlaylists(_ values: NSSet)

    @objc(removePlaylists:)
    @NSManaged public func removeFromPlaylists(_ values: NSSet)

}

extension Track : Identifiable {

}
