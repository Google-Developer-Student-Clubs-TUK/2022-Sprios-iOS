//
//  JoinViewController.swift
//  sprios_ios
//
//  Created by 이정동 on 2022/11/28.
//

import UIKit
class JoinViewController: UIViewController {
    
    var userData : User = User()
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        // 탈출 클로저 + 동시성
        
        getMethod(idField.text!) { message in
            if message == "회원 아이디 중복" {
                print("중복")
            } else {
                print("중복 X")
                DispatchQueue.main.async {
                    let addNameVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNameVC") as! AddNameController
                    
                    self.userData.account = self.idField.text
                    addNameVC.user = self.userData
                    
                    self.navigationController?.pushViewController(addNameVC, animated: true)
                }
                
            }
        }
    }
    
    func getMethod(_ account : String, completion: @escaping (String) -> Void) {
        
        guard let url = URL(string: "http://3.35.24.16:8080/api/members/duplicated/\(account)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                print(error!)
                return
            }
        
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~=
            response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            if let safeData = data {
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(ResMessage.self, from: safeData)
                    print(decodedData.message)
                    
                    completion(decodedData.message)
                    
                } catch {
                    print("Err")
                }
            }
            
        }.resume()
    }
}
