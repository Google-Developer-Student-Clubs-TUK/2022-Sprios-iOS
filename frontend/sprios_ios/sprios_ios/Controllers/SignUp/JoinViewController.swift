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
        
        UserNetManager.shared.checkingUser(account: idField.text!) { message in
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
}
