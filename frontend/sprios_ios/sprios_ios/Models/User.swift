//
//  User.swift
//  sprios_ios
//
//  Created by 이정동 on 2022/12/05.
//

import Foundation
import UIKit

struct User: Codable {
    var account: String?            // 아이디
    var password: String?           // 비밀번호
    var name: String?               // 이름
    var email: String?              // 이메일
    var phone: String?              // 핸드폰
    var gender: String?             // 성별
    var introduce: String?          // 소개글
    var profileImage: Data?         // 프로필 사진
    var profileImageUrl: String?    // 프로필 사진 URL
}
