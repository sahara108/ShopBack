//
//  ViewController.swift
//  ShopBack
//
//  Created by Nguyen Tuan on 9/5/17.
//  Copyright © 2017 Nguyen Tuan. All rights reserved.
//

import UIKit
import Utility

class HomeViewController: UIViewController {
    
    var dataSource: [HomeMovieViewModel] = []
    @IBOutlet weak var tableView: UITableView!
    var pagination: MovieOverviewPagination?
    
    var provider = NetworkProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.tableFooterView = UIView()
        HomeMovieViewModel.register(tableView: tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomeViewController.refresh(control:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        //load data first time
        refresh(control: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.title = "Movies"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func refresh(control: UIRefreshControl?) {
        //reset pagination
        pagination = nil
        
        let config = RequestConfig()
        config.setValue(value: "2016-12-31", forKey: NetworRequestKeys.primary_release_date(.lte))
        config.setValue(value: NetworkRequestValues.release_date(.desc).string, forKey: NetworRequestKeys.sort_by)
        config.setValue(value: "1", forKey: NetworRequestKeys.page)
        
        provider.loadMovieOviews(config: config) { [weak self] (pagination, list, error) in
            guard let `self` = self else { return }
            control?.endRefreshing()
            if error == nil {
                self.pagination = pagination
                self.dataSource = list.map({HomeMovieViewModel(movie: $0)})
                self.tableView.reloadData()
                
                self.tableView.addBotomActivityView(loadMore: { [weak self]  in
                    guard let `self` = self else { return }
                    self.loadMore()
                })
            }
        }
    }
    
    func loadMore() {
        let requestPage = (pagination?.currentPage ?? 0) + 1
        
        let config = RequestConfig()
        config.setValue(value: "2016-12-31", forKey: NetworRequestKeys.primary_release_date(.lte))
        config.setValue(value: NetworkRequestValues.release_date(.desc).string, forKey: NetworRequestKeys.sort_by)
        config.setValue(value: "\(requestPage)", forKey: NetworRequestKeys.page)
        
        provider.loadMovieOviews(config: config) { [weak self] (pagination, list, error) in
            guard let `self` = self else { return }
            if error == nil {
                self.pagination = pagination
                if pagination?.currentPage == pagination?.totalPage {
                    self.tableView.removeBottomActivityView()
                }else {
                    self.tableView.endBottomActivity()
                }
                
                let newData = list.map({HomeMovieViewModel(movie: $0)})
                self.dataSource.append(contentsOf: newData)
                self.tableView.reloadData()
            }
        }
    }
    
    deinit {
        tableView.removeBottomActivityView()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: data.cellIdentifier())
        if let movieCell = cell as? BECellRender {
            movieCell.renderCell(data: data)
        }
    
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = dataSource[indexPath.row]
        return data.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = dataSource[indexPath.row]
        
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailMovieController") as! DetailViewController
        detailVC.movie = data.movie
        detailVC.provider = provider
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

