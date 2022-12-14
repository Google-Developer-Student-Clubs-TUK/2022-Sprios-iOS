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

        setupCollectionView()
    }
    
    // 컬렉션 뷰 세팅
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setupFlowLayout()
        collectionView.collectionViewLayout = flowLayout
    }

    func setupFlowLayout() {
        
        let collectionCellWidth = (UIScreen.main.bounds.width - CVCell1.spacingWidth * (CVCell1.cellColumns - 1)) / CVCell1.cellColumns
        
        flowLayout.scrollDirection = .vertical  // 스크롤 방향
        flowLayout.itemSize = CGSize(width: collectionCellWidth, height: collectionCellWidth)
        
        flowLayout.minimumInteritemSpacing = CVCell1.spacingWidth // 아이템 사이 간격
        flowLayout.minimumLineSpacing = CVCell1.spacingWidth
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
