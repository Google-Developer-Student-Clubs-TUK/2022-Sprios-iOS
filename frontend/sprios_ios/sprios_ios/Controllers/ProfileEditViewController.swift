//
//  ProfileEditViewController.swift
//  sprios_ios
//
//  Created by 이정동 on 2022/12/21.
//

import UIKit

class ProfileEditViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var introduceTextField: UITextField!
    
    var image: UIImage!
    var name: String?
    var username: String!
    var introduce: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupEditView()
        setupProfileImageView()
    }
    
    func setupEditView() {
        profileImage.image = image
        nameTextField.text = name
        usernameTextField.text = username
        introduceTextField.text = introduce
    }
    
    func setupProfileImageView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileImage.addGestureRecognizer(tap)
        
        profileImage.isUserInteractionEnabled = true
        
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
    }
    
    @objc func profileImageTapped() {
        print("tap")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
