//
//  UserManager.swift
//  sprios_ios
//
//  Created by 이정동 on 2022/12/11.
//

import Foundation
import UIKit

// LoginManager로 변경?
class UserManager {
    
    static let shared = UserManager()
    private init() {}
    
    let userDefaultKey = "user"
    
    func setLoginUser(user: User) {
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(user) {
            UserDefaults.standard.setValue(encoded, forKey: userDefaultKey)
        }
    }
    
    func getLoginUser() -> User? {
        
        guard let savedData = UserDefaults.standard.object(forKey: userDefaultKey) as? Data else { return nil }
        
        let decoder = JSONDecoder()
        
        guard let savedObject = try? decoder.decode(User.self, from: savedData) else { return nil }
        
        return savedObject
    }
    
    func unsetLoginUser() {
        UserDefaults.standard.removeObject(forKey: userDefaultKey)
    }
    
}
