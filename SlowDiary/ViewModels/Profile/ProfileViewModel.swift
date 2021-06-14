//
//  ProfileViewModel.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/05/26.
//

import Foundation
import Alamofire
import SwiftyJSON

class ProfileViewModel {
    let server: Server = Server()
    let api: String = "/goal"
    
    let uVM: UserViewModel = UserViewModel.shared
    
    let changeImage = ["highlighter", "person.fill", "power"]
    let sections: [String] = ["목표수정", "정보수정", "로그아웃"]
    
    func checkNil(_ text: String) -> Bool {
        return text == ""
    }
    
    func changeProfile(pw: String, name: String, age: String, gender: Bool, handler: @escaping (Bool) -> Void) {
        if checkNil(pw) || checkNil(name) || checkNil(age) { handler(false) }
        let param: [String:Any] = ["id":uVM.getUserData().id!,"pw":pw,"name":name,"age":age,"gender":gender]
        
        server.PATCH(api: "\(api)/update", param: param).responseJSON {response in
            switch response.result {
            case .success:
                let user: User = User(id: self.uVM.getUserData().id, pw: pw, name: name, age: Int(age), gender: gender)
                self.uVM.setUserData(user)
                handler(true)
            case .failure:
                handler(false)
            }
        }
    }
    
    func changeGoal(goal: String, handler: @escaping (Bool) -> Void) {
        let param: [String:Any] = ["id":uVM.getUserData().id!,"goal":goal,"date":GetToday(format: "yyyy.MM.dd")]
        server.PATCH(api: "\(api)/update", param: param).responseJSON { response in
            switch response.result {
            case .success:
                handler(true)
            case .failure:
                handler(false)
            }
        }
    }
    
    func createGoal(goal: String, handler: @escaping (Bool) -> Void) {
        let param: [String:Any] = ["id":uVM.getUserData().id!,"goal":goal,"date":GetToday(format: "yyyy.MM.dd")]
        server.POST(api: "\(api)/create", param: param).responseJSON { response in
            switch response.result {
            case .success:
                handler(true)
            case .failure:
                handler(false)
            }
        }
    }
}
