//
//  EndPoint.swift
//  Spotify
//
//  Created by Wahyu Herdianto on 06/12/24.
//

import Foundation

public class APIEndpoint {
    let SEARCH_MUSIC: String = "https://itunes.apple.com/search?term="
    
    func searchAPI(query: String) -> String {
        let new_url = "\(SEARCH_MUSIC)\(query)"
        let escapedString = new_url.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        return escapedString ?? ""
    }
}
