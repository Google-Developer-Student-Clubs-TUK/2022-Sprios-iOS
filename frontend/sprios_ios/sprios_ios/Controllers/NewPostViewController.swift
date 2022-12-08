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
    }
    
    func setupTextView() {
        postTextView.delegate = self
        postTextView.text = textViewPlaceHolder
        postTextView.textColor = .lightGray
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
