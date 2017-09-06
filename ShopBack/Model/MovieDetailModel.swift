//
//  MovieDetailModel.swift
//  ShopBack
//
//  Created by Nguyen Tuan on 9/6/17.
//  Copyright © 2017 Nguyen Tuan. All rights reserved.
//

import UIKit
import SwiftyJSON
//{"adult":false,"backdrop_path":"/lubzBMQLLmG88CLQ4F3TxZr2Q7N.jpg","belongs_to_collection":{"id":427084,"name":"The Secret Life of Pets Collection","poster_path":"/aDNbXvuRiuYxk8qCwXNQQ7UEHau.jpg","backdrop_path":null},"budget":75000000,"genres":[{"id":16,"name":"Animation"},{"id":10751,"name":"Family"}],"homepage":"http://www.thesecretlifeofpets.com/","id":328111,"imdb_id":"tt2709768","original_language":"en","original_title":"The Secret Life of Pets","overview":"The quiet life of a terrier named Max is upended when his owner takes in Duke, a stray whom Max instantly dislikes.","popularity":10.709826,"poster_path":"/WLQN5aiQG8wc9SeKwixW7pAR8K.jpg","production_companies":[{"name":"Universal Pictures","id":33},{"name":"Fuji Television Network","id":3341},{"name":"Dentsu","id":6452},{"name":"Illumination Entertainment","id":6704}],"production_countries":[{"iso_3166_1":"US","name":"United States of America"}],"release_date":"2016-06-18","revenue":875958308,"runtime":87,"spoken_languages":[{"iso_639_1":"en","name":"English"}],"status":"Released","tagline":"Think this is what they do all day?","title":"The Secret Life of Pets","video":false,"vote_average":5.9,"vote_count":3412}
class MovieDetailModel: NSObject {
    let adult: Bool
    let belongToCollection : CollectionModel
    let budget: Double
    let homePage: URL
    let id: Int
    let imdbId: String
    let originalLang: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let releaseDate: Date
    let genres: [GenreModel]
    let productionCompanies: [CompanyModel]
    let productionCountries: [CountryModel]
    let revenue: Double
    let runtime: Int
    let spokenLangs: [LanguageModel]
    let status: String
    let tagline: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
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
            let genre_ids = json["genres"].array,
            let isAdult = json["adult"].bool,
            let overview_value = json["overview"].string,
            let dateString = json["release_date"].string,
            let dateValue = dateString.toDate(),
            let collectionValue = json["belongs_to_collection"].dictionary,
            let collectionModel = CollectionModel(json: JSON(jsonObject: collectionValue)),
            let budgetValue = json["budget"].double,
            let hompageURL = URL(string: json["homepage"].stringValue),
            let imdb_id = json["imdb_id"].string,
            let companies = json["production_companies"].array,
            let countries = json["production_countries"].array,
            let languages = json["spoken_languages"].array,
            let revenueValue = json["revenue"].double,
            let runtimeValue = json["runtime"].int,
            let taglineValue = json["tagline"].string,
            let statusValue = json["status"].string
            else { return nil }
        
        status = statusValue
        budget = budgetValue
        homePage = hompageURL
        imdbId = imdb_id
        revenue = revenueValue
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
        belongToCollection = collectionModel
        
        productionCompanies = companies.reduce([], { (old, item) -> [CompanyModel] in
            if let value = CompanyModel(json: item) {
                var list = old
                list.append(value)
                return list
            }
            
            return old
        })
        productionCountries = countries.reduce([], { (old, item) -> [CountryModel] in
            if let value = CountryModel(json: item) {
                var list = old
                list.append(value)
                return list
            }
            
            return old
        })
        spokenLangs = languages.reduce([], { (old, item) -> [LanguageModel] in
            if let value = LanguageModel(json: item) {
                var list = old
                list.append(value)
                return list
            }
            
            return old
        })
        runtime = runtimeValue
        tagline = taglineValue
        adult = isAdult
        overview = overview_value
        releaseDate = dateValue
        
        super.init()
        
        backdropPath = json["backdrop_path"].string
        posterPath = json["poster_path"].string
    }
}
