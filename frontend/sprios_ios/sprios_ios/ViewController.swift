//
//  ViewController.swift
//  sprios_ios
//
//  Created by 이정동 on 2022/11/28.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func joinButtonTapped(_ sender: UIButton) {
        navigationController?.pushViewController(JoinViewController(), animated: true)
    }
    
}

