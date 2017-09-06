//
//  NetworkRequestBuilder.swift
//  ShopBack
//
//  Created by Nguyen Tuan on 9/6/17.
//  Copyright © 2017 Nguyen Tuan. All rights reserved.
//

import UIKit

let apiKey = "328c283cd27bd1877d9080ccb1604c91"
let host = "http://api.themoviedb.org/3"
let imgHost = "https://image.tmdb.org/t/p/w500"


class RequestConfig {
    init() {
        //usually all req will require api_key, so we should create it by default.
        parametters[NetworRequestKeys.api_key.string] = apiKey
    }
    
    private var parametters: [String: String] = [:]
    func setValue(value: String, forKey key: String) {
        parametters[key] = value
    }
    
    func setValue(value: String, forKey key: NetworRequestKeys) {
        parametters[key.string] = value
    }
    
    func toURIString() -> String? {
        let des = parametters.map({$0.key + "=" + $0.value}).joined(separator: "&")
        if des.characters.count > 0 {
            return des
        }else {
            return nil
        }
    }
}

class NetworkRequestBuilder: NSObject {
    private func buildURL(baseURL: String, config: RequestConfig) -> URL {
        var urlString = baseURL
        
        if let uri = config.toURIString() {
            urlString = urlString + "?" + uri
        }
        
        return URL(string: urlString)!
    }
    
    func getMovieOverviewRequest(config: RequestConfig) -> URLRequest {
        let baseURL = "\(host)/discover/movie"
        
        let finalURL = buildURL(baseURL: baseURL, config: config)
        
        let request = URLRequest(url: finalURL)
        
        return request
    }
    
    func getMovieDetailRequest(movieId: String, config: RequestConfig) -> URLRequest {
        let baseURL = "\(host)/movie/\(movieId)"
        let finalURL = buildURL(baseURL: baseURL, config: config)
        
        let request = URLRequest(url: finalURL)
        
        return request
    }
    
    func getImageURL(path: String) -> URL {
        let baseURL = imgHost + path
        return URL(string: baseURL)!
    }
}
