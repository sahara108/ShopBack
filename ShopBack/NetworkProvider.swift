//
//  NetworkProvider.swift
//  ShopBack
//
//  Created by Nguyen Tuan on 9/5/17.
//  Copyright © 2017 Nguyen Tuan. All rights reserved.
//
import UIKit
import SwiftyJSON

class NetworkProvider: NSObject {
    private(set) var builder = NetworkRequestBuilder()
    
    func loadMovieOviews(config: RequestConfig, completion: ((MovieOverviewPagination?, [MovieOverviewModel], Error?) -> ())?) {
        let request = builder.getMovieOverviewRequest(config: config)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if error == nil, let data = data {
                do {
                    let json = try JSON(data: data)
                    var movies = [MovieOverviewModel]()
                    if let results = json["results"].array {
                        for item in results {
                            if let model = MovieOverviewModel(json: item) {
                                movies.append(model)
                            }
                        }
                    }
                    let pagination = MovieOverviewPagination(json: json)
                    DispatchQueue.main.async {
                        completion?(pagination, movies, nil)
                    }
                }catch {
                    DispatchQueue.main.async {
                        completion?(nil, [], error)
                    }
                }
            }else {
                DispatchQueue.main.async {
                    completion?(nil, [], error)
                }
            }
        }.resume()
    }
    
    func loadMovieDetail(movieId: String, config: RequestConfig, completion:((MovieDetailModel?, Error?) -> ())?) {
        let request = builder.getMovieDetailRequest(movieId: movieId, config: config)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if error == nil, let data = data {
                do {
                    let json = try JSON(data: data)
                    let movieDetail = MovieDetailModel(json: json)
                    
                    DispatchQueue.main.async {
                        completion?(movieDetail, nil)
                    }
                }catch {
                    DispatchQueue.main.async {
                        completion?(nil, error)
                    }
                }
            }else {
                DispatchQueue.main.async {
                    completion?(nil, error)
                }
            }
        }.resume()
    }
}
