//
//  User.swift
//  sprios_ios
//
//  Created by 이정동 on 2022/12/05.
//

import Foundation

struct User: Codable {
    var id: Int?                    // 고유 식별자
    var account: String?            // 아이디
    var password: String?           // 비밀번호
    var name: String?               // 이름
    var email: String?              // 이메일
    var phone: String?              // 핸드폰
    var gender: String?             // 성별
    var introduce: String?          // 소개글
    var image: ProfileImage?               // 이미지데이터
}

struct ProfileImage: Codable {
    var imgUrl: String?
    var imgType: String?
    var imgName: String?
    var imgUUID: String?
}
