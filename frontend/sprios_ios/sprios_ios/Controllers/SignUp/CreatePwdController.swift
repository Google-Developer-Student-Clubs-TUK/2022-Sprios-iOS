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
        
        UserNetManager.shared.createUser(user: user) { statusCode in
            if statusCode == 200 {
                DispatchQueue.main.async {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            } else {
                print("회원가입 실패")
            }
        }
    }
}

