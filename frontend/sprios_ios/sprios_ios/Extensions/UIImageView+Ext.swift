//
//  UIImageView+Ext.swift
//  sprios_ios
//
//  Created by 이정동 on 2022/12/08.
//

import Foundation
import UIKit
import Photos

extension UIImageView {
    func fetchImage(asset: PHAsset, contentMode: PHImageContentMode, targetSize: CGSize) {
        let options = PHImageRequestOptions()
        options.version = .original
        options.deliveryMode = .highQualityFormat
        PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: contentMode, options: options) { image, _ in
            guard let image = image else { return }
            self.contentMode = .scaleAspectFit
            self.image = image
        }
    }
    
    func loadImage(imageUrl: String?) {
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
                self.image = UIImage(data: data)
            }
        }
    }
}
