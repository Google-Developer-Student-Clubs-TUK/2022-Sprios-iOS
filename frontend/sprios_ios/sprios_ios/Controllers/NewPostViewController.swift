//
//  NewPostViewController.swift
//  sprios_ios
//
//  Created by 이정동 on 2022/12/04.
//

import UIKit

class NewPostViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var postTextView: UITextView!
    
    private let textViewPlaceHolder: String = "문구 입력."
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image
        
        setupTextView()
        setupNavigationBar()
    }
    
    func setupTextView() {
        postTextView.delegate = self
        postTextView.text = textViewPlaceHolder
        postTextView.textColor = .lightGray
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(rightBarButtonTapped))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func rightBarButtonTapped() {
        let profileImage = image.pngData()!
        let content = postTextView.text
        let post = Post(images: [profileImage], content: content)
        
        PostNetManager.shared.createPost(post: post) { statusCode in
            if statusCode == 200 {
                DispatchQueue.main.async {
                    
                    self.navigationController?.popToRootViewController(animated: true)
                }
            } else {
                print("게시물 생성 에러")
            }
        }
    }
    
}

extension NewPostViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceHolder {
            textView.text = nil
            textView.textColor = .black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceHolder
            textView.textColor = .lightGray
        }
    }
}
