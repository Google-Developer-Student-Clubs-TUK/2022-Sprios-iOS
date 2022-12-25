//
//  ResMessage.swift
//  sprios_ios
//
//  Created by 이정동 on 2022/12/26.
//

import Foundation

struct ResMessage: Codable {
    var code: String
    var message: String
    var data: Bool
}
