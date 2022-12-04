//
//  JoinViewController.swift
//  sprios_ios
//
//  Created by 이정동 on 2022/11/28.
//

import UIKit
class JoinViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    // 이메일 인증 클릭 이벤트
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let authEmailVC = storyboard?.instantiateViewController(withIdentifier: "AuthEmailVC") as! AuthEmailController
        navigationController?.pushViewController(authEmailVC, animated: true)
        
        navigationController?.pushViewController(AuthEmailController(), animated: true)
        
    }
}
