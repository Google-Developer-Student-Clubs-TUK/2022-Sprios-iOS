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
    @IBOutlet weak var selectImage: UIImageView!
    
    // 사진 선택 여부
    var photoSelected = [Bool](repeating: false, count: photoCount)
    var previewSelectedIndex = 0
    
    // 컬렉션 뷰의 레이아웃을 담당하는 객체
    let flowLayout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupCollectionView()
        setupNavigationBar()
    }
    
    // 컬렉션 뷰 세팅
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
    
    // 네비게이션 바 설정
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(stopButtonTapped))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonTapped))
    }

    @objc func stopButtonTapped() {
        navigationController?.popViewController(animated: false)
    }
    
    @objc func nextButtonTapped() {
        let newPostVC = storyboard?.instantiateViewController(withIdentifier: "NewPostVC") as! NewPostViewController
        
        newPostVC.image = selectImage.image
        
        navigationController?.pushViewController(newPostVC, animated: true)
    }
}


// MARK: - Delegate, Datasource
extension PhotoSelectorViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        let asset = allPhotos?.object(at: indexPath.row)
        
        cell.photo.fetchImage(asset: asset!, contentMode: .aspectFit, targetSize: cell.photo.frame.size)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 이전에 선택된 사진의 border 설정 제거
//        let previewCell = collectionView.cellForItem(at: [0, previewSelectedIndex]) as! PhotoCell
//        previewCell.contentView.layer.borderWidth = 0
//        previewCell.contentView.layer.borderColor = UIColor.systemBackground.cgColor
        
        // 새로 선택된 사진의 border 설정
        let selectCell = collectionView.cellForItem(at: indexPath) as! PhotoCell
//        selectCell.contentView.layer.borderWidth = 5
//        selectCell.contentView.layer.borderColor = UIColor.systemYellow.cgColor
        
        selectImage.image = selectCell.photo.image
        
//        previewSelectedIndex = indexPath.item
        
    }
    
    // cell이 나타날 때 (나타난 셀의 개수만큼 호출)
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(#function)
    }
    
    // cell이 나타날 때 (사라진 셀의 개수만큼 호출)
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(#function)
    }
    
}
