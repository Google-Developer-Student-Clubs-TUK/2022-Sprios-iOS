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
        setupNavigationButton()
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
    
    func setupNavigationButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(rightBarButtonTapped))
    }
    
    @objc func rightBarButtonTapped() {
        // 1. 사용자 이름 중복 검사
        // 2. 중복 시 알림 창, 중복 아닐 시 변경
    }
    
    @objc func profileImageTapped() {
        print("tap")
    }

}

