//
//  JoinViewController.swift
//  sprios_ios
//
//  Created by 이정동 on 2022/11/28.
//

import UIKit
class JoinViewController: UIViewController {
    
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        getMethod(idField.text!)

        let addNameVC = storyboard?.instantiateViewController(withIdentifier: "AddNameVC") as! AddNameController
        navigationController?.pushViewController(addNameVC, animated: true)
    }
    
    func getMethod(_ account : String) {
        
        guard let url = URL(string: "http://localhost:8080/api/members/duplicated/\(account)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                print(error!)
                return
            }
            guard let safeData = data else {
                print("Error: Did not receive data")
                return
            }
        
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~=
            response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            print(String(decoding: safeData, as: UTF8.self))
            
        }.resume()
    }
}
