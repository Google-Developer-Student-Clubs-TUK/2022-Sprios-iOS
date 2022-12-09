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
    

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let addNameVC = storyboard?.instantiateViewController(withIdentifier: "AddNameVC") as! AddNameController
        navigationController?.pushViewController(addNameVC, animated: true)
    }
}
