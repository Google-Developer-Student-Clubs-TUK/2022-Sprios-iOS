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
    
    // 컬렉션 뷰의 레이아웃을 담당하는 객체
    let flowLayout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImage.image = UIImage(named: "Instagram_logo_2022")
        
        setupCollectionView()
        setupNavigationBar()
        setupProfileImage()
        setupEditProfileButton()
    }
    
    func setupProfileImage() {
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "id", style: .plain, target: self, action: nil)
        let barButtonTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(named: "DefaultLabelColor"),
            .font: UIFont.systemFont(ofSize: 30, weight: .medium),
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
        
    }
    
    @objc func addFeedButtonTapped() {
        let photoSelectorVC = storyboard?.instantiateViewController(withIdentifier: "PhotoSelectorVC") as! PhotoSelectorViewController
        photoSelectorVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(photoSelectorVC, animated: false)
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
    
    
}
