//
//  PhotoSelectorViewController.swift
//  sprios_ios
//
//  Created by 이정동 on 2022/12/07.
//

import UIKit

struct CVCell {
    static let spacingWidth: CGFloat = 1
    static let cellColumns: CGFloat = 4
    private init() {}
}

class PhotoSelectorViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    // 컬렉션 뷰의 레이아웃을 담당하는 객체
    let flowLayout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupCollectionView()
        setupNavigationBar()
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setupFlowLayout()
        collectionView.collectionViewLayout = flowLayout
    }
    
    func setupFlowLayout() {
        
        let collectionCellWidth = (UIScreen.main.bounds.width - CVCell.spacingWidth * (CVCell.cellColumns - 1)) / CVCell.cellColumns
        
        flowLayout.scrollDirection = .vertical  // 스크롤 방향
        flowLayout.itemSize = CGSize(width: collectionCellWidth, height: collectionCellWidth)
        
        flowLayout.minimumInteritemSpacing = CVCell.spacingWidth // 아이템 사이 간격
        flowLayout.minimumLineSpacing = CVCell.spacingWidth
    }
    
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(stopButtonTapped))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonTapped))
    }

    @objc func stopButtonTapped() {
        navigationController?.popViewController(animated: false)
    }
    
    @objc func nextButtonTapped() {
        let newPostVC = storyboard?.instantiateViewController(withIdentifier: "NewPostVC") as! NewPostViewController
        
        navigationController?.pushViewController(newPostVC, animated: true)
    }
}

extension PhotoSelectorViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        cell.photo.image = UIImage(named: "Instagram_logo_2022")
        
        return cell
    }
    
    
}
