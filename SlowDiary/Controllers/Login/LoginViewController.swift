//
//  LoginViewController.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/05/26.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var loginV: UIView!
    @IBOutlet var markV: UIView!
    
    @IBOutlet var id: UITextField!
    @IBOutlet var pw: UITextField!
    
    @IBOutlet var loginB: UIButton!
    
    let vm: LoginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawView()
        self.id.delegate = self
        self.pw.delegate = self
    }
    
    @IBAction func ShowPw(_ sender: Any) {
        pw.isSecureTextEntry = !pw.isSecureTextEntry
    }
    
    @IBAction func login(_ sender: Any) {
        print(id.text!)
        print(pw.text!)
        print("-------------------")
        let msg = vm.CheckLogin(id.text!, pw.text!)
        makeAlert(title: vm.alertMsg[msg]!, msg: msg)
    }
    
    func drawView() {
        loginV.layer.cornerRadius = 20
        loginV.layer.masksToBounds = true
        
        markV.layer.cornerRadius = 15
        markV.layer.masksToBounds = true
        
        loginB.layer.cornerRadius = 10
        loginB.layer.masksToBounds = true
    }
    
    func makeAlert(title: String, msg: String) -> Void {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        var okAction : UIAlertAction
        if title == "성공" {
            okAction = UIAlertAction(title: "OK", style: .default, handler:  { (action) in
                self.goMain()
            })
        } else {
            okAction = UIAlertAction(title: "OK", style: .default, handler : nil)
        }
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
    }
    
    func goMain() -> Void {
        let storyboard = UIStoryboard(name: "Tab", bundle: nil)
        let TabController = storyboard.instantiateViewController(identifier: "TabController")
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(TabController)
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.id:
            self.pw.becomeFirstResponder()
        default:
            self.pw.resignFirstResponder()
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
