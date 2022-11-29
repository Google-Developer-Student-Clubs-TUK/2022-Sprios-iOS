//
//  ViewController.swift
//  sprios_ios
//
//  Created by 이정동 on 2022/11/28.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var joinButton: UIButton!
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwdTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextField()
        setupButton()
    }
    
    // 텍스트필드 설정
    func setupTextField() {
        // 델리게이트 설정
        idTextField.delegate = self
        passwdTextField.delegate = self
        
        // Clear Button
        idTextField.clearButtonMode = .whileEditing
        passwdTextField.clearButtonMode = .whileEditing
    }
    
    // 버튼 모서리 둥글게 설정
    func setupButton() {
        loginButton.layer.cornerRadius = 5
        joinButton.layer.cornerRadius = 5
    }
    
    // 화면 터치 시 키보드 내려감
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // 로그인 버튼 클릭 이벤트
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
    }
    
    // 회원가입 버튼 클릭 이벤트
    @IBAction func joinButtonTapped(_ sender: UIButton) {
        navigationController?.pushViewController(JoinViewController(), animated: true)
    }
    
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    
}
