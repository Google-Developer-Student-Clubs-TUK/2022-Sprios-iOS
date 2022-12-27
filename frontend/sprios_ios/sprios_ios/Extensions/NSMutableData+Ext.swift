//
//  NSMutableData+Ext.swift
//  sprios_ios
//
//  Created by 이정동 on 2022/12/22.
//

import Foundation

extension NSMutableData {
  func append(_ string: String) {
    if let data = string.data(using: .utf8) {
      self.append(data)
    }
  }
}
