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
    
    // 컬렉션 뷰의 레이아웃을 담당하는 객체
    let flowLayout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = UserManager.shared.getLoginUser()
        
        setupCollectionView()
        setupNavigationBar()
        setupProfileImage()
        setupEditProfileButton()
        
    }
    
    func setupProfileImage() {
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        
        // MARK: - 수정해야하는 부분 (리펙토링)
        //var imageUrl = UserDefaults.standard.object(forKey: "imageUrl") as? String
        let imageUrl = UserManager.shared.getLoginUser()?.profileImageUrl
        
        guard let urlString = imageUrl, let url = URL(string: urlString) else {
            return
        }
        
        // 오래걸리는 작업을 동시성 처리 (다른 쓰레드에서 일시킴)
        DispatchQueue.global().async {
            // url을 가지고 (이미지)데이터를 가져옴
            // 동기적으로 처리됨(오래 걸림) -> 2번쓰레드에서 실행하도록 설정
            guard let data = try? Data(contentsOf: url) else { return }
            
            // 오래 걸리는 작업이 일어나는 동안에 url이 바뀔 가능성 제거
            // 빠른 스크롤 시 1번 url 요청 후 사진을 받아오려는 중에 cell이 재사용되어 2번 url 요청했는데 1번 url 요청 작업이 끝나 2번 사진이 아닌 1번 사진을 보여줄 수도 있기 때문에 url 비교하는 과정
            guard urlString == url.absoluteString else { return }
            
            DispatchQueue.main.async {
                self.profileImage.image = UIImage(data: data)
            }
        }
        

        //let user = UserManager.shared.getLoginUser()
        
        username.text = user.name
        introduction.text = user.introduce
        
        // MARK: - ---------------------------
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
        // MARK: - 수정 (리펙토링)
        //var account = UserManager.shared.getLoginUser()?.account
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: user.account, style: .plain, target: self, action: nil)
        // MARK: - --------------------
        
        let barButtonTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(named: "DefaultLabelColor"),
            .font: UIFont.systemFont(ofSize: 25, weight: .medium),
        ]
        let leftButton = self.navigationItem.leftBarButtonItem
        leftButton?.setTitleTextAttributes(barButtonTextAttributes, for: .normal)
        
        let moreButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        moreButton.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        moreButton.tintColor = UIColor(named: "DefaultLabelColor")
        moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        
        let addFeedButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        addFeedButton.setImage(UIImage(systemName: "plus.app"), for: .normal)
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        cell.photo.image = UIImage(named: "Instagram_logo_2022")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailPostVC = storyboard?.instantiateViewController(withIdentifier: "DetailPostVC") as! DetailPostViewController
        detailPostVC.indexPath = indexPath
        self.navigationController?.pushViewController(detailPostVC, animated: true)
    }
    
}
