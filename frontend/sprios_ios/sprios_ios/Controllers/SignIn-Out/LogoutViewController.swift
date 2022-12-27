//
//  LogoutViewController.swift
//  sprios_ios
//
//  Created by 이정동 on 2022/12/17.
//

import UIKit

class LogoutViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "로그아웃", message: "로그아웃을 하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "로그아웃", style: .default, handler: { action in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginNavController = storyboard.instantiateViewController(withIdentifier: "LoginNavigationController")
            
            UserNetManager.shared.logoutUser {
                UserDefaults.standard.unsetLoginUser()
                DispatchQueue.main.async {
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginNavController)
                }
            }
            

        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func withdrawalButtonTapped(_ sender: UIButton) {
        print("회원 탈퇴")
    }
    
}
