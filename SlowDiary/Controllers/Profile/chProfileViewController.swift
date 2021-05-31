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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setProfile()
    }
    
    private func setProfile() {
        pw.text = "안녕하세요."
        chPw.text = "안녕하세요."
        name.text = "박지현"
        age.text = "19"
        gender.selectedSegmentIndex = 1
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
        navigationController?.popViewController(animated: true)
    }

}
