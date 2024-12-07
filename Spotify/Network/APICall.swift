//
//  APICall.swift
//  Spotify
//
//  Created by Wahyu Herdianto on 06/12/24.
//

import Foundation

public class APICall {
    public enum HTTPMethod: String {
        case GET = "GET"
        case POST = "POST"
    }
    
    public func fetch<T: Decodable>(url: String, dataExpected: T.Type, method: HTTPMethod, completion: @escaping (T?) -> ()) {
        let url = URL(string: url)!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error while fetching data:", error)
                completion(nil)
            }

            guard let data = data else {
                print("failed at getting data")
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(decodedData)
            } catch let jsonError {
                print("Failed to decode json", jsonError)
                completion(nil)
            }
        } .resume()
    }
}
