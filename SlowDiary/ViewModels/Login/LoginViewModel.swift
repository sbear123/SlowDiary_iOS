//
//  LoginViewModel.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/05/26.
//

import Foundation
import Alamofire
import SwiftyJSON

class LoginViewModel {
    
    let server: Server = Server()
    let api: String = "/users"
    let uVM: UserViewModel = UserViewModel()
    
    let alertMsg: [String:String] = ["로그인에 성공하셨습니다.":"성공", "아이디 혹은 비밀번호가 틀렸습니다. 다시 확인해주세요.":"실패", "입력이 안된곳이 있습니다. 확인해주세요.":"실패"]
    
    func CheckNil(_ text: String) -> Bool {
        return text == ""
    }
    
    func CheckLogin(_ id: String,_ pw:String, handler: @escaping (String) -> Void) {
        let param: [String:String] = ["id":id,"pw":pw]
        if CheckNil(id) || CheckNil(pw) { handler("입력이 안된곳이 있습니다. 확인해주세요.") }
        
        server.GET(api: api + "/login", param: param).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                var user = try? JSONDecoder().decode(User.self, from: json.rawData())
                user?.id = id
                user?.pw = pw
                self.uVM.setUserData(user!)
                handler("로그인에 성공하셨습니다.")
            case .failure:
                handler("아이디 혹은 비밀번호가 틀렸습니다. 다시 확인해주세요.")
            }
        }
    }
    
    func GetAlertMsg(_ text: String) -> String {
        return alertMsg[text]!
    }
}
