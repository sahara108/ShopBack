//
//  DetailMovieViewModel.swift
//  ShopBack
//
//  Created by Nguyen Tuan on 9/7/17.
//  Copyright © 2017 Nguyen Tuan. All rights reserved.
//

import UIKit

class DetailMovieViewModel: NSObject {

    
    private(set) var detail: MovieDetailModel
    init(detail model: MovieDetailModel) {
        detail = model
    }
    
    var synopsisText:String {
        get {
            return detail.overview
        }
    }
    
    var overViewURL: URL? {
        get {
            if let uri = detail.backdropPath {
                let requestBuilder = NetworkRequestBuilder()
                return requestBuilder.getImageURL(path: uri)
            }else if let uri = detail.posterPath {
                let requestBuilder = NetworkRequestBuilder()
                return requestBuilder.getImageURL(path: uri)
            }
            
            return nil
        }
    }
    
    typealias Object = (String, String)
    var tableSource: [Object] {
        get {
            var result = [Object]()
            
            //add genres
            result.append(("Genres",detail.genres.map({$0.name}).joined(separator: ",")))
            
            //add langs
            result.append(("Languages", detail.spokenLangs.map({$0.name}).joined(separator: ",")))
            
            //add duration
            result.append(("Duration", "\(detail.runtime)"))
            return result
        }
    }
}
