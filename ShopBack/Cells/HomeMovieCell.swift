//
//  HomeMovieCell.swift
//  ShopBack
//
//  Created by Nguyen Tuan on 9/7/17.
//  Copyright © 2017 Nguyen Tuan. All rights reserved.
//

import Utility

class HomeMovieCell: UITableViewCell, BECellRenderImpl {
    typealias CellData = HomeMovieViewModel
    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func renderCell(data: HomeMovieViewModel) {
        backdropImageView.loadImage(fromURL: data.backdropURL, defaultImage: nil)
        popularityLabel.text = data.popurlarity
        movieTitleLabel.text = data.title
    }
}
