//
//  DetailPostViewController.swift
//  sprios_ios
//
//  Created by 이정동 on 2022/12/20.
//

import UIKit

class DetailPostViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var indexPath: IndexPath!
    var user: User!
    var postData: PostData!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTableView()
        tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: "FeedCell")
        
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailPostViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
        
        let post = postData?.posts[indexPath.row]

        cell.profileImage.loadImage(imageUrl: post?.user?.imageUrl!)
        cell.postImage.loadImage(imageUrl: post?.imageUrls![0])
        cell.account.text = post?.user?.account
        cell.accountBotLabel.text = post?.user?.account
        cell.content.text = post?.content
        cell.dateCreated = post?.createdAt
        cell.like.text = "좋아요 \((post?.likeCount)!)개"
        
        return cell
    }
    
    
}
