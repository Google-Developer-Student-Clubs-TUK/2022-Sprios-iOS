//
//  MyPageViewController.swift
//  sprios_ios
//
//  Created by 이정동 on 2022/12/01.
//

import UIKit

struct CVCell1 {
    static let spacingWidth: CGFloat = 1
    static let cellColumns: CGFloat = 3
    private init() {}
}

class MyPageViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var introduction: UILabel!
    
    @IBOutlet weak var editProfileButton: UIButton!
    
    var user: User!
    var postData: PostData?
    
    // 컬렉션 뷰의 레이아웃을 담당하는 객체
    let flowLayout = UICollectionViewFlowLayout()
    var isUpdated = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = UserDefaultsManager.shared.getLoginUser()
        
        setupCollectionView()
        setupNavigationBar()
        setupProfile()
        setupEditProfileButton()
        setupLoginUserPost()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isUpdated {
            user = UserDefaultsManager.shared.getLoginUser()
            setupProfile()
            isUpdated = false
        }
    }
    
    func setupProfile() {
        print(#function)
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        
        let imageUrl = user.image?.imgUrl
        
        self.profileImage.loadImage(imageUrl: imageUrl)
        self.username.text = self.user.name
        self.introduction.text = self.user.introduce

    }
    
    func setupLoginUserPost() {
        PostNetManager.shared.getLoginUserPosts { posts in
            self.postData = posts
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func setupEditProfileButton() {
        editProfileButton.layer.cornerRadius = 5
        editProfileButton.backgroundColor = .systemGray3
    }
    
    // 컬렉션 뷰 세팅
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setupFlowLayout()
        collectionView.collectionViewLayout = flowLayout
        
        collectionView.bounces = false
    }
    
    func setupFlowLayout() {
        
        let collectionCellWidth = (UIScreen.main.bounds.width - CVCell1.spacingWidth * (CVCell1.cellColumns - 1)) / CVCell1.cellColumns
        
        flowLayout.scrollDirection = .vertical  // 스크롤 방향
        flowLayout.itemSize = CGSize(width: collectionCellWidth, height: collectionCellWidth)
        
        flowLayout.minimumInteritemSpacing = CVCell1.spacingWidth // 아이템 사이 간격
        flowLayout.minimumLineSpacing = CVCell1.spacingWidth
    }
    
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: user.account, style: .plain, target: self, action: nil)
        
        let barButtonTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(named: "DefaultLabelColor"),
            .font: UIFont.systemFont(ofSize: 25, weight: .medium),
        ]
        let leftButton = self.navigationItem.leftBarButtonItem
        leftButton?.setTitleTextAttributes(barButtonTextAttributes, for: .normal)
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        
        let moreButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        moreButton.setImage(UIImage(systemName: "line.3.horizontal", withConfiguration: largeConfig), for: .normal)
        moreButton.tintColor = UIColor(named: "DefaultLabelColor")
        moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        
        let addFeedButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        addFeedButton.setImage(UIImage(systemName: "plus.app", withConfiguration: largeConfig), for: .normal)
        addFeedButton.tintColor = UIColor(named: "DefaultLabelColor")
        addFeedButton.addTarget(self, action: #selector(addFeedButtonTapped), for: .touchUpInside)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: moreButton),
            UIBarButtonItem(customView: addFeedButton)
        ]
    }
    
    @objc func moreButtonTapped() {
        let logoutVC = storyboard?.instantiateViewController(withIdentifier: "LogoutVC") as! LogoutViewController
        self.present(logoutVC, animated: true)
    }
    
    @objc func addFeedButtonTapped() {
        let photoSelectorVC = storyboard?.instantiateViewController(withIdentifier: "PhotoSelectorVC") as! PhotoSelectorViewController
        photoSelectorVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(photoSelectorVC, animated: false)
    }
    
    
    @IBAction func editProfileButtonTapped(_ sender: UIButton) {
        
        let profileEditVC = storyboard?.instantiateViewController(withIdentifier: "ProfileEditVC") as! ProfileEditViewController
        
        profileEditVC.image = profileImage.image
        profileEditVC.name = user.name
        profileEditVC.username = user.account
        profileEditVC.introduce = user.introduce
        
        navigationController?.pushViewController(profileEditVC, animated: true)
    }
}

// MARK: - CollectionView Delegate, DataSource
extension MyPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postData?.posts.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        cell.photo.loadImage(imageUrl: postData?.posts[indexPath.row].imageUrls?[0])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailPostVC = storyboard?.instantiateViewController(withIdentifier: "DetailPostVC") as! DetailPostViewController
        detailPostVC.indexPath = indexPath
        detailPostVC.user = user
        detailPostVC.postData = postData
        self.navigationController?.pushViewController(detailPostVC, animated: true)
    }
    
}
