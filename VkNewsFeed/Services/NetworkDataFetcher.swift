//
//  NetworkDataFetcher.swift
//  VkNewsFeed
//
//  Created by urichese on 17.10.2022.
//

import Foundation

protocol DataFetcher {
    func getFeed(responce:@escaping (FeedResponse?) -> Void)
}

struct NetworkDataFetcher:DataFetcher {
    let networking: Networking
    
    func getFeed(responce: @escaping (FeedResponse?) -> Void) {
        let params = ["filters": "post, photo"]
        networking.request(path: API.newsFeed, params: params) { data, error in
            if let error = error {
                print("Error request \(error.localizedDescription)")
                responce(nil)
            }
            guard let data = data else {
                return
            }
            let decoded = self.decodeJSON(type: FeedResponseWrapped.self, from: data)
            responce(decoded?.response)
        }
    }
    
    private func decodeJSON<T: Decodable> (type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else {return nil}
        return response
        
    }
}
