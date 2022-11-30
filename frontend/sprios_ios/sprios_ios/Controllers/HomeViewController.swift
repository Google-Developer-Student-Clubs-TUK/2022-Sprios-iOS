//
//  HomeViewController.swift
//  sprios_ios
//
//  Created by 이정동 on 2022/11/28.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var feedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupTableView()
    }
    
    func setupTableView() {
        feedTableView.delegate = self
        feedTableView.dataSource = self
        
        feedTableView.rowHeight = UITableView.automaticDimension
        feedTableView.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: "FeedCell")
        
    }

}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
        
        return cell
    }
    
    
}

extension HomeViewController: UITableViewDelegate {
    
}
