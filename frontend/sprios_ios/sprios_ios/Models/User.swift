//
//  User.swift
//  sprios_ios
//
//  Created by 이정동 on 2022/12/05.
//

import Foundation
import UIKit

struct User: Codable {
    var id: String
    var password: String
    var email: String
    var phone: String
    var name: String
    var gender: String
    var introduction: String?
    
    // 이미지 저장할 변수 추가
}
