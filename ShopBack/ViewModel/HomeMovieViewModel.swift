//
//  HomeViewModel.swift
//  ShopBack
//
//  Created by Nguyen Tuan on 9/7/17.
//  Copyright © 2017 Nguyen Tuan. All rights reserved.
//

import Utility

class HomeMovieViewModel: BECellDataSource {
    static let cellID = "HomeViewCell"
    
    func cellIdentifier() -> String {
        return HomeMovieViewModel.cellID
    }
    
    static func register(tableView: UITableView) {
        tableView.register(UINib(nibName: "HomeMovieCell", bundle: nil), forCellReuseIdentifier: cellID)
    }
    
    func cellHeight() -> CGFloat {
        //calculate expected cell height
        let width = UIScreen.main.bounds.width
        let imageHeight = width * 9 / 16
        
        return imageHeight + 5 + 21 + 5 //this value is get from xib for showing label below image view
    }
    
    private(set) var movie: MovieOverviewModel
    init(movie model: MovieOverviewModel) {
        movie = model
    }
    
    var title: String {
        get {
            return movie.title
        }
    }
    
    var popurlarity:String {
        get {
            return "\(movie.popularity)"
        }
    }
    
    var backdropURL: URL? {
        get {
            if let uri = movie.backdropPath {
                let requestBuilder = NetworkRequestBuilder()
                return requestBuilder.getImageURL(path: uri)
            }else if let uri = movie.posterPath {
                let requestBuilder = NetworkRequestBuilder()
                return requestBuilder.getImageURL(path: uri)
            }

            return nil
        }
    }
    
}
