//
//  CreatePwdController.swift
//  sprios_ios
//
//  Created by 지윤 on 2022/12/10.
//

import UIKit
class CreatePwdController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        var param = ["account": "rlawldbs0911", "password": "Wldbs0911!", "name": "dpdwldbs"]
        
        //let jsonData = try? JSONEncoder().encode(param)
        
        func postMethod() {
            
            guard let url = URL(string: "http://localhost:8080/api/members") else {
                print("Error: cannot create URL")
                return
            }
            
            guard let jsonData = try? JSONEncoder().encode(param) else {
                print("Error: Trying to convert model to JSON data")
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type") // 요청타입 JSON
            request.setValue("application/json", forHTTPHeaderField: "Accept") // 응답타입 JSON
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                
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
                // HTTP 200번대 정상코드인 경우만 다음 코드로 넘어감
                guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                    print("Error: HTTP request failed")
                    return
                }
                print(String(decoding: safeData, as: UTF8.self))
                
            }.resume()
            
        }
    }
}
