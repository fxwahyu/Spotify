//
//  Track.swift
//  Spotify
//
//  Created by Wahyu Herdianto on 06/12/24.
//

import Foundation

// MARK: - Result
struct TrackModel: Codable {
    let wrapperType: String?
    let kind: String?
    let artistID, collectionID, trackID: Int?
    let artistName: String
    let collectionName, trackName, collectionCensoredName, trackCensoredName: String?
    let artistViewURL, collectionViewURL, trackViewURL: String?
    let previewURL: String?
    let artworkUrl30: String?
    let artworkUrl60, artworkUrl100: String
    let releaseDate: String?
    let collectionExplicitness: String?
    let trackExplicitness: String?
    let discCount, discNumber, trackCount, trackNumber: Int?
    let trackTimeMillis: Int?
    let country: String?
    let currency: String?
    let primaryGenreName: String
    let contentAdvisoryRating: String?
    let isStreamable: Bool?
    let collectionPrice, trackPrice: Double?
    let copyright, description: String?
    let collectionArtistID: Int?
    let collectionArtistName: String?
    let collectionArtistViewURL: String?
    let trackRentalPrice, collectionHDPrice, trackHDPrice, trackHDRentalPrice: Double?
    let shortDescription, longDescription: String?
    let hasITunesExtras: Bool?
    let feedURL: String?
    let artworkUrl600: String?
    let genreIDS, genres: [String]?

    enum CodingKeys: String, CodingKey {
        case wrapperType, kind
        case artistID = "artistId"
        case collectionID = "collectionId"
        case trackID = "trackId"
        case artistName, collectionName, trackName, collectionCensoredName, trackCensoredName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100, releaseDate, collectionExplicitness, trackExplicitness, discCount, discNumber, trackCount, trackNumber, trackTimeMillis, country, currency, primaryGenreName, contentAdvisoryRating, isStreamable, collectionPrice, trackPrice, copyright, description
        case collectionArtistID = "collectionArtistId"
        case collectionArtistName
        case collectionArtistViewURL = "collectionArtistViewUrl"
        case trackRentalPrice
        case collectionHDPrice = "collectionHdPrice"
        case trackHDPrice = "trackHdPrice"
        case trackHDRentalPrice = "trackHdRentalPrice"
        case shortDescription, longDescription, hasITunesExtras
        case feedURL = "feedUrl"
        case artworkUrl600
        case genreIDS = "genreIds"
        case genres
    }
    
    
}
