//
//  ProfileViewController.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/05/17.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let vm:ProfileViewModel = ProfileViewModel()
    let uVM: UserViewModel = UserViewModel.shared
    
    @IBOutlet var nameL: UILabel!
    @IBOutlet var wordL: UILabel!
    @IBOutlet var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewWillAppear(true)
        self.tableview.delegate = self
        self.tableview.dataSource = self
        nameL.text = "\(uVM.getUserData().name!)님,"
        wordL.text = uVM.word
    }
    
    override func viewWillAppear(_ animated: Bool) {
        wordL.text = uVM.word
        nameL.text = "\(uVM.getUserData().name!)님,"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            chGoal()
        case 1:
            chProfile()
        case 2:
            checkLogOut()
        default:
            return
        }
    }
    
    func chGoal() {
        let GoalAlert = UIAlertController(title: "목표 수정", message: nil, preferredStyle: .alert)
        
        GoalAlert.addTextField() { (tf) in
            tf.placeholder = "이번달의 목표를 입력하세요."
        }
        
        GoalAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        GoalAlert.addAction(UIAlertAction(title: "완료", style: .destructive) { _ in
            let goal = GoalAlert.textFields?[0].text ?? ""
            if self.uVM.goal == "" {
                self.vm.createGoal(goal: goal) { success in
                    let text = success ? "성공" : "실패"
                    self.makeAlert(title: text, msg: "목표 수정에 \(text)하셨습니다.")
                    self.uVM.goal = goal
                }
            }
            else {
                self.vm.changeGoal(goal: goal) { success in
                    let text = success ? "성공" : "실패"
                    self.makeAlert(title: text, msg: "목표 수정에 \(text)하셨습니다.")
                    self.uVM.goal = goal
                }}
        })
        self.present(GoalAlert, animated: true)
    }
    
    func chProfile() {
        self.performSegue(withIdentifier: "showChProfile", sender: self)
    }
    
    func checkLogOut() {
        let alert = UIAlertController(title: "로그아웃 하시겠습니까?", message: "로그아웃 하셔도 이 계정의 데이터는 지워지지 않습니다.", preferredStyle: UIAlertController.Style.alert)
        var okAction : UIAlertAction
        var cancel : UIAlertAction
        
        okAction = UIAlertAction(title: "Yes", style: .destructive, handler:  { (action) in
            self.logout()
        })
        cancel = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(cancel)
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
    }
    
    func logout() {
        uVM.deleteUserData()
        
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let LoginNavContoller = storyboard.instantiateViewController(identifier: "LoginNavContoller")
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(LoginNavContoller)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return vm.sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return vm.sections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SetTableViewCell
        
        let cnt = indexPath.section
        cell.update(t: vm.sections[cnt], img: vm.changeImage[cnt])
        cell.selectionStyle = .none
        
        return cell
    }
    
    func makeAlert(title: String, msg: String) -> Void {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        var okAction : UIAlertAction
        okAction = UIAlertAction(title: "OK", style: .default, handler : nil)
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
    }
    
}
