//
//  HomeViewController.swift
//  sprios_ios
//
//  Created by 이정동 on 2022/11/28.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var feedTableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    let spinner = UIActivityIndicatorView(style: .medium)
    var postData: PostData?
    var pageCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupTableView()
        setupNavigationBar()
        setupPosts()
        
    }
    
    func setupTableView() {
        feedTableView.dataSource = self
        
        feedTableView.rowHeight = UITableView.automaticDimension
        feedTableView.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: "FeedCell")
        feedTableView.separatorStyle = .none
        
        //refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        feedTableView.addSubview(refreshControl) // not required when using UITableViewController
        
        spinner.color = UIColor.darkGray
        spinner.hidesWhenStopped = true
        feedTableView.tableFooterView = spinner
        
    }
    
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "instagram", style: .plain, target: self, action: #selector(instaLabelButtonTapped))
        let barButtonTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(named: "DefaultLabelColor"),
            .font: UIFont(name: "Billabong", size: 35)!
        ]
        let leftButton = self.navigationItem.leftBarButtonItem
        leftButton?.setTitleTextAttributes(barButtonTextAttributes, for: .normal)
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        
        let addFeedButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        
        addFeedButton.setImage(UIImage(systemName: "plus.app", withConfiguration: largeConfig), for: .normal)
        addFeedButton.tintColor = UIColor(named: "DefaultLabelColor")
        addFeedButton.addTarget(self, action: #selector(addFeedButtonTapped), for: .touchUpInside)
        
        let notiButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        notiButton.setImage(UIImage(systemName: "heart", withConfiguration: largeConfig), for: .normal)
        notiButton.tintColor = UIColor(named: "DefaultLabelColor")
        notiButton.addTarget(self, action: #selector(notificationButtonTapped), for: .touchUpInside)
        
        let dmButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        dmButton.setImage(UIImage(systemName: "paperplane", withConfiguration: largeConfig), for: .normal)
        dmButton.tintColor = UIColor(named: "DefaultLabelColor")
        dmButton.addTarget(self, action: #selector(dmButtonTapped), for: .touchUpInside)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: dmButton),
            UIBarButtonItem(customView: notiButton),
            UIBarButtonItem(customView: addFeedButton)
        ]
    }
    
    func setupPosts() {
        PostNetManager.shared.getPosts(page: 0) { postData in
            self.postData = postData
            DispatchQueue.main.async {
                self.feedTableView.reloadData()
            }
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        // MARK: - 모든 사용자의 게시글을 가져오는 요청으로 수정
        PostNetManager.shared.getPosts(page: 0) { postData in
            self.postData = postData
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.feedTableView.reloadData()
            }
        }
        
    }
    
    @objc func instaLabelButtonTapped() {
        print("instagram")
    }
    
    @objc func addFeedButtonTapped() {
        
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
        return postData?.posts.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
        
        var post = postData?.posts[indexPath.row]
        
        cell.profileImage.loadImage(imageUrl: post?.user?.imageUrl!)
        cell.postImage.loadImage(imageUrl: post?.imageUrls![0])
        cell.account.text = post?.user?.account
        cell.accountBotLabel.text = post?.user?.account
        cell.content.text = post?.content
        cell.dateCreated = post?.createdAt
        
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) {
            spinner.startAnimating()
        }

    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) {
           
            pageCount += 1
            PostNetManager.shared.getPosts(page: pageCount) { postData in
                for post in postData.posts {
                    self.postData?.posts.append(post)
                }

                DispatchQueue.main.async {
                    self.feedTableView.reloadData()
                    self.spinner.stopAnimating()
                }
            }
        }
    }
    
}

