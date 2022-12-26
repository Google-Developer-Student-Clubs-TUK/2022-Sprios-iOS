////
////  AlamofireMultipart.swift
////  sprios_ios
////
////  Created by 이정동 on 2022/12/26.
////
//
//import Foundation
//
//
//struct NewProfile {
//    let account: String
//    let name: String
//    let introduce: String
//    let image: Data?
//}
//
//func uploadNewProfile(with model: NewProfile,
//                      completion: @escaping ((Bool) -> Void)){
//    print(#function)
//
//    let uuid = UUID().uuidString
//    let headers: Alamofire.HTTPHeaders = [
//        "Content-Type" : "multipart/form-data"
//    ]
//
//    AF.upload(multipartFormData: { (multipartFormData) in
//
//        multipartFormData.append(model.account.data(using: .utf8)!,
//                                 withName: "account")
//        multipartFormData.append(model.name.data(using: .utf8)!,
//                                 withName: "name")
//        multipartFormData.append(model.introduce.data(using: .utf8)!,
//                                 withName: "introduce")
//
//        if let image = model.image {
//
//
//            multipartFormData.append(image,
//                                     withName: "images",
//                                     fileName: "\(image).jpg",
//                                     mimeType: "image/jpeg")
//
//        }
//
//    }, to: "http://3.35.24.16:8080/api/posts")
//}
