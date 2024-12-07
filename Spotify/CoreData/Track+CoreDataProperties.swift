//
//  Track+CoreDataProperties.swift
//  Spotify
//
//  Created by Wahyu Herdianto on 06/12/24.
//
//

import Foundation
import CoreData


extension Track {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Track> {
        return NSFetchRequest<Track>(entityName: "Track")
    }

    @NSManaged public var wrapperType: String?
    @NSManaged public var kind: String?
    @NSManaged public var artistId: Int64
    @NSManaged public var collectionId: Int64
    @NSManaged public var trackId: Int64
    @NSManaged public var artistName: String?
    @NSManaged public var collectionName: String?
    @NSManaged public var trackName: String?
    @NSManaged public var collectionCensoredName: String?
    @NSManaged public var trackCensoredName: String?
    @NSManaged public var artistViewUrl: String?
    @NSManaged public var collectionViewUrl: String?
    @NSManaged public var trackViewUrl: String?
    @NSManaged public var previewUrl: String?
    @NSManaged public var artworkUrl30: String?
    @NSManaged public var artworkUrl60: String?
    @NSManaged public var artworkUrl100: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var collectionExplicitness: String?
    @NSManaged public var trackExplicitness: String?
    @NSManaged public var discCount: Int16
    @NSManaged public var discNumber: Int16
    @NSManaged public var trackCount: Int16
    @NSManaged public var trackNumber: Int16
    @NSManaged public var trackTimeMillis: Int64
    @NSManaged public var country: String?
    @NSManaged public var currency: String?
    @NSManaged public var primaryGenreName: String?
    @NSManaged public var contentAdvisoryRating: String?
    @NSManaged public var isStreamable: Bool
    @NSManaged public var playlist: Playlist?

}

extension Track : Identifiable {

}
