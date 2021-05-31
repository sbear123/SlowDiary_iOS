//
//  SignUpViewController.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/05/26.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var id: UITextField!
    @IBOutlet var pw: UITextField!
    @IBOutlet var chPw: UITextField!
    @IBOutlet var name: UITextField!
    @IBOutlet var age: UITextField!
    @IBOutlet var gender: UISegmentedControl!
    
    @IBOutlet var signB: UIButton!
    @IBOutlet var loginB: UIButton!
    
    @IBAction func showLogin(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.id.delegate = self
        self.name.delegate = self
        self.pw.delegate = self
        self.chPw.delegate = self
        self.age.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func showPw(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            pw.isSecureTextEntry = !pw.isSecureTextEntry
        default:
            chPw.isSecureTextEntry = !chPw.isSecureTextEntry
        }
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.id:
            self.pw.becomeFirstResponder()
        case self.pw:
            self.chPw.becomeFirstResponder()
        case self.chPw:
            self.name.becomeFirstResponder()
        case self.name:
            self.age.becomeFirstResponder()
        default:
            self.age.resignFirstResponder()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }

}
