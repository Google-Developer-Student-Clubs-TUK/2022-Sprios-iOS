//
//  ViewController.swift
//  sprios_ios
//
//  Created by 이정동 on 2022/11/28.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var instagramLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwdTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextField()
        setupButton()
        setupUI()
        
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
    
    func setupUI() {
        instagramLabel.font = UIFont(name: "Billabong", size: 60)
    }
    
    // 화면 터치 시 키보드 내려감
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // 로그인 버튼 클릭 이벤트
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        let id = idTextField.text ?? ""
        let passwd = passwdTextField.text ?? ""
        
        // 서버로 ID, PW 보내기
        UserNetManager.shared.loginUser(account: id, password: passwd) { status in
            if status == 200 {
                UserNetManager.shared.getUserData { statusCode, user in
                    if statusCode == 200 {
                        DispatchQueue.main.async {
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
                            
                            UserManager.shared.setLoginUser(user: user)
                            
                            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
                        }
                    }
                    else {
                        print("error")
                    }
                }
                
            } else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "로그인 실패", message: "아이디 또는 패스워드를 다시 확인하세요.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .default))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
        }
    }
    
    // 회원가입 버튼 클릭 이벤트
    @IBAction func joinButtonTapped(_ sender: UIButton) {
        let joinVC = storyboard?.instantiateViewController(withIdentifier: "JoinVC") as! JoinViewController
        navigationController?.pushViewController(joinVC, animated: true)
    }
    
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .next {
            passwdTextField.becomeFirstResponder()
        } else if textField.returnKeyType == .done {
            self.view.endEditing(true)
        }
        return true
    }
}
