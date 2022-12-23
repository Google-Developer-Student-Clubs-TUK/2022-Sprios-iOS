//
//  PostNetManager.swift
//  sprios_ios
//
//  Created by 이정동 on 2022/12/19.
//

import Foundation
import UIKit

class PostNetManager {
    static let shared = PostNetManager()
    private init() {}
    
    func createPost(post: Post, completion: @escaping (Int)->()) {
        
    }
    
    func getLoginUserPosts(completion: @escaping (PostData)->()) {
        guard let user = UserDefaultsManager.shared.getLoginUser() else { return }
        
        guard let url = URL(string: "http://3.35.24.16:8080/api/posts/writer?id=\(user.id!)") else {
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
                
                let decodedData = try decoder.decode(PostData.self, from: safeData)
                completion(decodedData)
            } catch {
                print("decodeError")
            }

        }.resume()
    }
    
    func getPosts(completion: @escaping (PostData)->()) {
        
        // 전체 게시물 중 사이즈를 3씩 쪼개서 0번 페이지를 조회
        guard let url = URL(string: "http://3.35.24.16:8080/api/posts/page/0?size=3") else {
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
                
                let decodedData = try decoder.decode(PostData.self, from: safeData)
                completion(decodedData)
            } catch {
                print("decodeError")
            }

        }.resume()
    }
}
