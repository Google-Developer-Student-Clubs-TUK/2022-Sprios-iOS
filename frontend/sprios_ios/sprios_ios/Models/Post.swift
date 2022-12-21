//
//  Post.swift
//  sprios_ios
//
//  Created by 이정동 on 2022/12/11.
//

import Foundation
import UIKit



// MARK: - Datum
struct Post: Codable {
    let content: String
    let memberPostInfoResponse: MemberPostInfoResponse
    let imageUrls: [String]
    let likeCount: Int
    let createdAt: [Int]
}

// MARK: - MemberPostInfoResponse
struct MemberPostInfoResponse: Codable {
    let id: Int
    let account: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case id, account
        case imageURL = "imageUrl"
    }
}
