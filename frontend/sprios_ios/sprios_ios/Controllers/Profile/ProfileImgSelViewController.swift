//
//  ProfileImgSelViewController.swift
//  sprios_ios
//
//  Created by 이정동 on 2022/12/26.
//

import UIKit

class ProfileImgSelViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let flowLayout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupCollectionView()
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProfileImgSelViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
        let selectCell = collectionView.cellForItem(at: indexPath) as! PhotoCell
        
        let index = navigationController!.viewControllers.count - 2
        let vc = navigationController?.viewControllers[index] as! ProfileEditViewController
        vc.image = selectCell.photo.image
        
        navigationController?.popViewController(animated: true)
    }
}
