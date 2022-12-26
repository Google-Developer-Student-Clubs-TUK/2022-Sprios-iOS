//
//  AlamofireMultipart.swift
//  sprios_ios
//
//  Created by 이정동 on 2022/12/26.
//

import Foundation
import Alamofire

struct NewPost {
    let content: String?
    let images: [Data]?
}


func uploadNewPost(with model: NewPost,
                         completion: @escaping ((Bool) -> Void)){
    print(#function)
    let content = model.content ?? ""

    let uuid = UUID().uuidString
    let headers: HTTPHeaders = ["Content-Type" : "multipart/form-data"]

    AF.upload(multipartFormData: { (multipartFormData) in

        multipartFormData.append(content.data(using: .utf8)!,
                                 withName: "content", mimeType: "multipart/form-data;charset=UTF-8")

        if let imageArray = model.images {
            for image in imageArray {
                multipartFormData.append(image,
                                         withName: "images",
                                         fileName: "\(image).jpg",
                                         mimeType: "image/jpeg")
            }
        }

    }, to: "http://3.35.24.16:8080/api/posts", method: .post, headers: headers).responseJSON { (response) in

        guard let statusCode = response.response?.statusCode else { return }
        print(statusCode)
        switch statusCode {
        case 200:
            completion(true)
        default:
            completion(false)
        }
    }
}

struct NewProfile {
    let account: String
    let name: String
    let introduce: String
    let image: Data?
}

func uploadNewProfile(with model: NewProfile,
                      completion: @escaping ((Bool) -> Void)){
    print(#function)
    
    let uuid = UUID().uuidString
    let headers: Alamofire.HTTPHeaders = [
        "Content-Type" : "multipart/form-data",
        "Connection" : "keep-alive"
    ]
    
    AF.upload(multipartFormData: { (multipartFormData) in
        
        multipartFormData.append(model.account.data(using: .utf8)!,
                                 withName: "account")
        multipartFormData.append(model.name.data(using: .utf8)!,
                                 withName: "name")
        multipartFormData.append(model.introduce.data(using: .utf8)!,
                                 withName: "introduce")
        
        if let image = model.image {
            
            
            multipartFormData.append(image,
                                     withName: "images",
                                     fileName: "\(image).jpg",
                                     mimeType: "image/jpeg")
            
        }
        
    }, to: "http://3.35.24.16:8080/api/posts")
}
