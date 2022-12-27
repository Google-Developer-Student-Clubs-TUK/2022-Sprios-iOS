//
//  AuthEmailController.swift
//  sprios_ios
//
//  Created by 지윤 on 2022/12/02.
//

import UIKit

class AuthEmailController: UIViewController {
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var confirmCodeField: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let addNameVC = storyboard?.instantiateViewController(withIdentifier: "AddNameVC") as! AddNameController
        navigationController?.pushViewController(addNameVC, animated: true)
    }
}
