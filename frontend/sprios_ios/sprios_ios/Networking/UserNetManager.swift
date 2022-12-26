//
//  UserNetManager.swift
//  sprios_ios
//
//  Created by 이정동 on 2022/12/19.
//

import Foundation
import UIKit
import Alamofire

class UserNetManager {
    static let shared = UserNetManager()
    private init() {}
    
    func loginUser(account: String, password: String, completion: @escaping (Int) -> ()){
        let param = ["account" : account, "password" : password]
        
        guard let url = URL(string: "http://3.35.24.16:8080/api/members/login") else {
            print("Error: cannot create URL")
            return
        }
        
        // 모델을 JSON data 형태로 변환
        guard let jsonData = try? JSONEncoder().encode(param) else {
            print("Error: Trying to convert model to JSON data")
            return
        }
        
        // URL요청 생성
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // 요청타입 JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept") // 응답타입 JSON
        request.httpBody = jsonData
        
        // 요청을 가지고 세션 작업시작
        URLSession.shared.dataTask(with: request) { data, response, error in
            // 에러가 없어야 넘어감
            guard error == nil else {
                print("Error: error calling POST")
                print(error!)
                return
            }
            // 옵셔널 바인딩
            guard let safeData = data else {
                print("Error: Did not receive data")
                return
            }
            
            // 원하는 모델이 있다면, JSONDecoder로 decode코드로 구현 ⭐️
            print(String(decoding: safeData, as: UTF8.self))
            
            guard let response = response as? HTTPURLResponse else { return }
            
            completion(response.statusCode)
        }.resume()
    }
    
    func logoutUser(completion: @escaping ()->()) {
        guard let url = URL(string: "http://3.35.24.16:8080/api/members/logout") else {
            print("Error: cannot create URL")
            return
        }
        
        // URL요청 생성
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // 요청을 가지고 세션 작업시작
        URLSession.shared.dataTask(with: request) { data, response, error in
            // 에러가 없어야 넘어감
            guard error == nil else {
                print("Error: error calling POST")
                print(error!)
                return
            }
            // 옵셔널 바인딩
            guard let safeData = data else {
                print("Error: Did not receive data")
                return
            }
            
            // 원하는 모델이 있다면, JSONDecoder로 decode코드로 구현 ⭐️
            print(String(decoding: safeData, as: UTF8.self))
            
            guard response is HTTPURLResponse else { return }
            
            completion()
        }.resume()
    }

    func getUserData(completion: @escaping (Int, User) -> Void) {
        
        guard let url = URL(string: "http://3.35.24.16:8080/api/members/info") else {
            print("Error: cannot create URL")
            return
        }
        
        // URL요청 생성
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // 요청을 가지고 세션 작업시작
        URLSession.shared.dataTask(with: request) { data, response, error in
            // 에러가 없어야 넘어감
            guard error == nil else {
                print("Error: error calling POST")
                print(error!)
                return
            }
            // 옵셔널 바인딩
            guard let safeData = data else {
                print("Error: Did not receive data")
                return
            }
            
            // 원하는 모델이 있다면, JSONDecoder로 decode코드로 구현 ⭐️
            print(String(decoding: safeData, as: UTF8.self))
            
            guard let response = response as? HTTPURLResponse else { return }
            
            do {
                let decoder = JSONDecoder()
                
                let decodedData = try decoder.decode(User.self, from: safeData)
                completion(response.statusCode, decodedData)
            } catch {
                print("Error")
            }
            
        }.resume()
    }
    
    func checkingUser(account: String, completion: @escaping (String)->()) {
        
        guard let url = URL(string: "http://3.35.24.16:8080/api/members/duplicated/\(account)") else {
            print("Error: cannot create URL")
            return
        }
        
        // URL요청 생성
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // 요청을 가지고 세션 작업시작
        URLSession.shared.dataTask(with: request) { data, response, error in
            // 에러가 없어야 넘어감
            guard error == nil else {
                print("Error: error calling POST")
                print(error!)
                return
            }
            
            guard response is HTTPURLResponse else { return }
            
            // 옵셔널 바인딩
            guard let safeData = data else {
                print("Error: Did not receive data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(ResMessage.self, from: safeData)
                print(decodedData.message)
                
                completion(decodedData.message)
                
            } catch {
                print("Err")
            }
            
        }.resume()
    }
    
    func updateUserProfile(profile: NewProfile, completion: @escaping ()->()) {
        let parameters = [
            "account" : profile.account,
            "name" : profile.name,
            "introduce" : profile.introduce
        ]

        let headers: HTTPHeaders = ["Content-Type" : "multipart/form-data"]

        AF.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: .utf8)!,
                                         withName: key, mimeType: "multipart/form-data;charset=UTF-8")
            }
            
            multipartFormData.append(profile.image!,
                                     withName: "image",
                                     fileName: "\(profile.image!).jpg",
                                     mimeType: "image/jpeg")

        }, to: "http://3.35.24.16:8080/api/members/update", method: .post, headers: headers).responseJSON { (response) in

            guard let statusCode = response.response?.statusCode else { return }
            print(statusCode)
            completion()
        }
    }

}

