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
        PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: contentMode, options: options) { image, _ in
            guard let image = image else { return }
            self.contentMode = .scaleAspectFit
            self.image = image
        }
    }
}
