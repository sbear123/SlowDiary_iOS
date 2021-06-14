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
    
    let vm: SignUpViewModel = SignUpViewModel()
    
    @IBAction func showLogin(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func SignUp(_ sender: Any) {
        var msg = ""
        if vm.CheckNil(id.text!, pw.text!, chPw.text!, name.text!, age.text!) {
            msg = "입력이 안된곳이 있습니다. 확인해주세요."
        } else if Int(age.text!) == nil {
            msg = "숫자로 나이를 입력해주세요."
        } else if vm.checkPw(pw: pw.text!, chPw: chPw.text!) {
            msg = "비밀번호와 비밀번호 확인이 다릅니다."
        }
        if msg != "" {
            makeAlert(title: vm.GetAlertMsg(msg), msg: msg)
            return
        }
        vm.checkId(id.text!) { isID in
            if isID {
                self.vm.SignUp(self.GetUser()) { msg in
                    self.makeAlert(title: self.vm.GetAlertMsg(msg), msg: msg)
                }
            }
            else {
                let msg = "중복된 아이디가 존재합니다."
                self.makeAlert(title: self.vm.GetAlertMsg(msg), msg: msg)
            }
        }
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
    
    func makeAlert(title: String, msg: String) -> Void {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        var okAction : UIAlertAction
        if title == "성공" {
            okAction = UIAlertAction(title: "OK", style: .default, handler:  { (action) in
                self.navigationController?.popViewController(animated: true)
            })
        } else {
            okAction = UIAlertAction(title: "OK", style: .default, handler : nil)
        }
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
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
    
    func GetUser() -> User {
        return User(id: id.text, pw: pw.text, name: name.text, age: Int(age.text!), gender: gender.selectedSegmentIndex==0)
    }
}
