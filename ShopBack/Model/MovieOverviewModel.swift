//
//  MovieOverviewModel.swift
//  ShopBack
//
//  Created by Nguyen Tuan on 9/6/17.
//  Copyright © 2017 Nguyen Tuan. All rights reserved.
//

import UIKit
import SwiftyJSON

class MovieOverviewPagination: NSObject{
    let totalPage: Int
    let currentPage: Int
    let totalResults: Int
    
    init?(json: JSON) {
        guard let pages = json["total_pages"].int,
            let results = json["total_results"].int,
            let current = json["page"].int
            else { return nil }
        
        totalPage = pages
        currentPage =  current
        totalResults = results
        super.init()
    }
}

//{"vote_count":0,"id":439468,"video":false,"vote_average":0,"title":"Puccini Gianni Schicchi","popularity":1.012058,"poster_path":"\/cWWCWbsJa2t0FbQwsdQR27MRP3k.jpg","original_language":"en","original_title":"Puccini Gianni Schicchi","genre_ids":[],"backdrop_path":null,"adult":false,"overview":"","release_date":"2015-02-04"}
class MovieOverviewModel: NSObject {
    let voteCount: Int
    let id: Int
    let video: Bool
    let voteAverage: Double
    let title: String
    let popularity: Double
    let originalLang: String
    let originalTitle: String
    let genres: [GenreModel]
    let adult: Bool
    let overview: String
    let releaseDate: Date
    
    //optional parametter
    private(set) var posterPath: String?
    private(set) var backdropPath: String?
    
    init?(json: JSON) {
        guard let vote_count = json["vote_count"].int,
              let id_valule = json["id"].int,
              let isVideo = json["video"].bool,
              let vote_average = json["vote_average"].double,
              let title_value = json["title"].string,
              let popularity_value = json["popularity"].double,
              let orLang = json["original_language"].string,
              let orTitle = json["original_title"].string,
              let genre_ids = json["genre_ids"].array,
              let isAdult = json["adult"].bool,
              let overview_value = json["overview"].string,
              let dateString = json["release_date"].string,
              let dateValue = dateString.toDate()
            else { return nil }
        
        voteCount = vote_count
        id = id_valule
        video = isVideo
        voteAverage = vote_average
        title = title_value
        popularity = popularity_value
        originalLang = orLang
        originalTitle = orTitle
        genres = genre_ids.reduce([], { (old, item) -> [GenreModel] in
            if let value = GenreModel(json: item) {
                var list = old
                list.append(value)
                return list
            }
            
            return old
        })
        adult = isAdult
        overview = overview_value
        releaseDate = dateValue
        
        super.init()
        
        backdropPath = json["backdrop_path"].string
        posterPath = json["poster_path"].string
    }
}
