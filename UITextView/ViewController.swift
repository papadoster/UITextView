//
//  ViewController.swift
//  UITextView
//
//  Created by Marina Karpova on 04.01.2023.
//

import UIKit

class ViewController: UIViewController {

    var myTextView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTextView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func createTextView() {
        myTextView = UITextView(frame: CGRect(x: 0, y: 100, width: self.view.bounds.width, height: self.view.bounds.height - 100))
        myTextView.text = "some text"
        myTextView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 40)
        myTextView.font = UIFont.systemFont(ofSize: 17)
        myTextView.backgroundColor = UIColor.white
        self.view.addSubview(myTextView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.myTextView.resignFirstResponder()
        self.myTextView.backgroundColor = UIColor.white
    }

    
    @objc func updateTextView(param: Notification) {
        let userInfo = param.userInfo
        
        let getKeyboardRect = (userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardFrame = self.view.convert(getKeyboardRect, to: view.window)
        
        if param.name == UIResponder.keyboardWillHideNotification {
            myTextView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 40)
        } else {
            myTextView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: keyboardFrame.height + 40, right: 40)
            myTextView.scrollIndicatorInsets = myTextView.contentInset
        }
        
        myTextView.scrollRangeToVisible(myTextView.selectedRange)
    }
}

