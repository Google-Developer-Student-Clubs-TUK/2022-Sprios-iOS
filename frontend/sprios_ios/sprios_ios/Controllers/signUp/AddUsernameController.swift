//
//  AddUsernameController.swift
//  sprios_ios
//
//  Created by 지윤 on 2022/12/10.
//

import UIKit
class AddUsernameController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func finishButton(_ sender: UIButton) {
        
        let createPwdVC = storyboard?.instantiateViewController(withIdentifier: "CreatePwdVC") as! CreatePwdController
        navigationController?
            .pushViewController(createPwdVC, animated: true)
        
    }
    
}
