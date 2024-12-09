//
//  UserPreference.swift
//  Spotify
//
//  Created by Wahyu Herdianto on 09/12/24.
//

import Foundation

class UserPreference {
    static let shared = UserPreference()
    var defaults = UserDefaults.standard
    
    var recentSearchesTrackId: [Int] = []
    
    public func initializeRecentSearchesUserDefault() {
        if let savedArray = defaults.array(forKey: "RecentSearches") as? [Int] {
            self.recentSearchesTrackId = savedArray
        } else {
            defaults.set([], forKey: "RecentSearches")
        }
    }
    
    public func addTrackToUserDefault(trackId: Int) {
        self.recentSearchesTrackId.append(trackId)
        defaults.set(recentSearchesTrackId, forKey: "RecentSearches")
    }
}
