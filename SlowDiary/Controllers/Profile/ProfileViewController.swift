//
//  ProfileViewController.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/05/17.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let vm:ProfileViewModel = ProfileViewModel()
    
    @IBOutlet var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewWillAppear(true)
        self.tableview.delegate = self
        self.tableview.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            chProfile()
        case 1:
            checkLogOut()
        default:
            return
        }
    }
    
    func chProfile() {
        //화면 전환 구성하기
        self.performSegue(withIdentifier: "showChProfile", sender: self)
    }
    
    func checkLogOut() {
        let alert = UIAlertController(title: "로그아웃 하시겠습니까?", message: "로그아웃 하셔도 이 계정의 데이터는 지워지지 않습니다.", preferredStyle: UIAlertController.Style.alert)
        var okAction : UIAlertAction
        var cancel : UIAlertAction
        
        okAction = UIAlertAction(title: "Yes", style: .destructive,handler:  { (action) in
            self.logout()
        })
        cancel = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancel)
        present(alert, animated: false, completion: nil)
    }
    
    func logout() {
        vm.logout()
        
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let LoginNavContoller = storyboard.instantiateViewController(identifier: "LoginNavContoller")
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(LoginNavContoller)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return vm.sections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SetTableViewCell
        
        cell.title.text = vm.sections[indexPath.section]
        cell.icon.image = UIImage(systemName: vm.changeImage[indexPath.section])
        cell.nextIcon.image = UIImage(systemName: "chevron.right")
        cell.selectionStyle = .none
        
        return cell
    }

}
