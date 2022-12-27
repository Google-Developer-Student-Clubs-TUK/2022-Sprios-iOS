//
//  CreatePwdController.swift
//  sprios_ios
//
//  Created by 지윤 on 2022/12/10.
//

import UIKit
class CreatePwdController: UIViewController {
    
    @IBOutlet weak var passwdField: UITextField!
    var user: User!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        user.password = passwdField.text
        
        postMethod(user) { statusCode in
            if statusCode == 200 {
                DispatchQueue.main.async {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            } else {
                print("회원가입 실패")
            }
        }
        
    }
    func postMethod(_ param: User, completion: @escaping (Int) -> Void) {
        
        guard let url = URL(string: "http://3.35.24.16:8080/api/members") else {
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
                print("Error: HTTP request failed - \(response)")
                return
            }
            print(String(decoding: safeData, as: UTF8.self))
            
            completion(response.statusCode)
        }.resume()
        
    }
}

