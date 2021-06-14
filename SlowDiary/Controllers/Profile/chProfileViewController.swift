//
//  chProfileViewController.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/05/27.
//

import UIKit

class chProfileViewController: UIViewController {

    @IBOutlet var chProfileV: UIView!
    
    @IBOutlet var pw: UITextField!
    @IBOutlet var chPw: UITextField!
    @IBOutlet var name: UITextField!
    @IBOutlet var age: UITextField!
    @IBOutlet var gender: UISegmentedControl!
    
    @IBOutlet var finishB: UIButton!
    
    let uVM: UserViewModel = UserViewModel.shared
    let pVM: ProfileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setProfile()
    }
    
    private func setProfile() {
        let user = uVM.getUserData()
        pw.text = user.pw
        name.text = user.name
        age.text = String(user.age!)
        gender.selectedSegmentIndex = user.gender! ? 0 : 1
    }
    
    @IBAction func showPw(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            pw.isSecureTextEntry = !pw.isSecureTextEntry
        default:
            chPw.isSecureTextEntry = !chPw.isSecureTextEntry
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func finish(_ sender: Any) {
        //정보수정하는 코드
        pVM.changeProfile(pw: pw.text!, name: name.text!, age: age.text!, gender: gender.selectedSegmentIndex==0) { success in
            if success {
                self.makeAlert(title: "성공", msg: "정보수정에 성공하셨습니다.")
                self.navigationController?.popViewController(animated: true)
            }
            else {
                self.makeAlert(title: "실패", msg: "정보수정에 실패하셨습니다.")
            }
        }
    }
    
    func makeAlert(title: String, msg: String) -> Void {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        var okAction : UIAlertAction
        okAction = UIAlertAction(title: "OK", style: .default, handler : nil)
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
    }

}
