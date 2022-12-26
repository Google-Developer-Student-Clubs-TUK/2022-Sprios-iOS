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
    
    var image: UIImage?
    var name: String?
    var username: String?
    var introduce: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupEditView()
        setupProfileImageView()
        setupNavigationButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        profileImage.image = image
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
//        let index = self.navigationController!.viewControllers.count - 2
//        let vc = self.navigationController?.viewControllers[index] as! MyPageViewController
//
//        guard let account = usernameTextField.text else { return }
//
//        let user = UserDefaultsManager.shared.getLoginUser()
//
//        if user?.account != usernameTextField.text {
//            UserNetManager.shared.checkingUser(account: account) { message in
//                DispatchQueue.main.async {
//                    if message == "회원 아이디 중복" {
//                        let alert = UIAlertController(title: "사용자 이름 중복", message: "설정하신 사용자 이름은 사용하실 수 없습니다.", preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: "확인", style: .default))
//                        self.present(alert, animated: true)
//                        return
//                    }
//                }
//            }
//        }
//
//        vc.isUpdated = true
//
//        // 프로필 업데이트 통신 > 유저정보 가져오기 > UserDefault 재설정
//
//        self.navigationController?.popViewController(animated: true)
        
//        let acc = usernameTextField.text!
//        let nm = nameTextField.text!
//        let introd = introduceTextField.text!
//        let img = profileImage.image?.pngData()
//        
//        let prof = NewProfile(account: acc, name: nm, introduce: introd, image: img)
//        
//        uploadNewProfile(with: prof) { bool in
//            if bool {
//                print("성공")
//            } else {
//                print("실패")
//            }
//        }
    }
    
    @objc func profileImageTapped() {
        let profileImgEditVC = storyboard?.instantiateViewController(withIdentifier: "ProfileImgSelVC") as! ProfileImgSelViewController
        
        navigationController?.pushViewController(profileImgEditVC, animated: true)
    }

}

