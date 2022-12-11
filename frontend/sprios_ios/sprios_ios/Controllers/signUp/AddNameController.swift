//
//  AddNameController.swift
//  sprios_ios
//
//  Created by 지윤 on 2022/12/02.
//

import UIKit
class AddNameController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let createPwdVC = storyboard?.instantiateViewController(withIdentifier: "CreatePwdVC") as! CreatePwdController
        navigationController?
            .pushViewController(createPwdVC, animated: true)
    }
}
