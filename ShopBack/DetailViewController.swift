//
//  DetailViewController.swift
//  ShopBack
//
//  Created by Nguyen Tuan on 9/5/17.
//  Copyright © 2017 Nguyen Tuan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var synopsisConstraintHeight: NSLayoutConstraint!
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    fileprivate var tableDataSource: [DetailMovieViewModel.Object] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var movie: MovieOverviewModel!
    var data: DetailMovieViewModel?
    var provider: NetworkProvider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        
        clean()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = movie.title
        loadDetail()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDetail() ->  (){
        MBProgressHUD.showAdded(to: view, animated: true)
//        let movieId = "\(movie.id)" //this alway fail
        let movieId = "328111" //testing purpose
        
        provider.loadMovieDetail(movieId: movieId, config: RequestConfig()) { [weak self] (detail, error) in
            guard let `self` = self else { return }
            MBProgressHUD.hide(for: self.view, animated: true)
            if error == nil, let detail = detail {
                self.data = DetailMovieViewModel(detail: detail)
                self.updateContent()
            }
        }
    }
    
    func clean() {
        self.synopsisLabel.text = ""
        self.tableDataSource = []
        self.imageView.image = nil
    }
    
    func updateContent() {
        guard let data = data else {
            clean()
            return
        }
        let expectedSynopsisTextHeight = Helper.sizeForText(data.synopsisText, font: synopsisLabel.font, maxWidth: view.bounds.width).height + 4 //4 inset
        synopsisConstraintHeight.constant = expectedSynopsisTextHeight
        synopsisLabel.text = data.synopsisText
        view.layoutIfNeeded()
        tableDataSource = data.tableSource
        imageView.loadImage(fromURL: data.overViewURL, defaultImage: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func book(_ sender: Any) {
        let url = URL(string: "http://www.cathaycineplexes.com.sg/")! //for testing
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "detailCellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: cellId)
        }
        
        let data = tableDataSource[indexPath.row]
        cell?.textLabel?.text = data.0
        cell?.detailTextLabel?.text = data.1
        
        return cell!
    }
}
