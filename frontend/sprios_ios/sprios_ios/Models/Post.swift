//
//  Post.swift
//  sprios_ios
//
//  Created by 이정동 on 2022/12/11.
//

import Foundation
import UIKit

struct Post: Codable {
    var postImage: Data
    var content: String?
    
    // 유저 프로필 사진 + 유저 아이디
}
