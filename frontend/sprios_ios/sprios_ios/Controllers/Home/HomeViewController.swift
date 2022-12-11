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
        setupNavigationBar()
    }
    
    func setupTableView() {
        feedTableView.delegate = self
        feedTableView.dataSource = self
        
        feedTableView.rowHeight = UITableView.automaticDimension
        feedTableView.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: "FeedCell")
        
    }
    
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "instagram", style: .plain, target: self, action: #selector(instaLabelButtonTapped))
        let barButtonTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(named: "DefaultLabelColor"),
            .font: UIFont(name: "Billabong", size: 35)!
        ]
        let leftButton = self.navigationItem.leftBarButtonItem
        leftButton?.setTitleTextAttributes(barButtonTextAttributes, for: .normal)
        
        let dmButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        dmButton.setImage(UIImage(systemName: "plus.app"), for: .normal)
        dmButton.tintColor = UIColor(named: "DefaultLabelColor")
        dmButton.addTarget(self, action: #selector(addFeedButtonTapped), for: .touchUpInside)
        
        let notiButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        notiButton.setImage(UIImage(systemName: "heart"), for: .normal)
        notiButton.tintColor = UIColor(named: "DefaultLabelColor")
        notiButton.addTarget(self, action: #selector(notificationButtonTapped), for: .touchUpInside)
        
        let addFeedButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        addFeedButton.setImage(UIImage(systemName: "paperplane"), for: .normal)
        addFeedButton.tintColor = UIColor(named: "DefaultLabelColor")
        addFeedButton.addTarget(self, action: #selector(dmButtonTapped), for: .touchUpInside)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: addFeedButton),
            UIBarButtonItem(customView: notiButton),
            UIBarButtonItem(customView: dmButton)
        ]
    }
    
    @objc func instaLabelButtonTapped() {
        print("instagram")
    }
    
    @objc func addFeedButtonTapped() {
//        let newPostVC = storyboard?.instantiateViewController(withIdentifier: "NewPostVC") as! NewPostViewController
//        newPostVC.hidesBottomBarWhenPushed = true
//        navigationController?.pushViewController(newPostVC, animated: true)
        
        let photoSelectorVC = storyboard?.instantiateViewController(withIdentifier: "PhotoSelectorVC") as! PhotoSelectorViewController
        photoSelectorVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(photoSelectorVC, animated: false)
    }
    
    @objc func notificationButtonTapped() {
        print("Notification")
    }
    
    @objc func dmButtonTapped() {
        print("plane")
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

