//
//  BaseResponse.swift
//  Spotify
//
//  Created by Wahyu Herdianto on 06/12/24.
//

import Foundation

struct BaseResponse<T: Codable>: Codable {
    let resultCount: Int
    let results: T?
}
