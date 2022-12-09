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
        let addUsernameVC = storyboard?.instantiateViewController(withIdentifier: "AddUsernameVC") as! AddUsernameController
        navigationController?.pushViewController(addUsernameVC, animated: true)
    }
}
