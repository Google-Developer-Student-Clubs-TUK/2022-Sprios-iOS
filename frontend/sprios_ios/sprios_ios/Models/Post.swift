//
//  Post.swift
//  sprios_ios
//
//  Created by 이정동 on 2022/12/11.
//

import Foundation
import UIKit


struct PostData: Codable {
    let posts: [Post]
    
    enum CodingKeys: String, CodingKey {
        case posts = "data"
    }
}

// 서버로부터 받는 Post 데이터 형식
struct Post: Codable {
    let content: String?
    let user: User?
    let imageUrls: [String]?
    let likeCount: Int?
    let createdAt: [Int]?
    
    enum CodingKeys: String, CodingKey {
        case content, imageUrls, likeCount, createdAt
        case user = "memberPostInfoResponse"
    }
}
