//
//  SignUpViewModel.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/05/26.
//

import Foundation
import Alamofire
import SwiftyJSON

class SignUpViewModel {
    
    let server: Server = Server()
    let api: String = "/users"
    
    let alertMsg: [String:String] = ["회원가입에 성공하셨습니다.":"성공", "중복된 아이디가 존재합니다.":"실패", "입력이 안된곳이 있습니다. 확인해주세요.":"실패", "회원가입에 실패하셨습니다.":"실패", "숫자로 나이를 입력해주세요.":"실패", "비밀번호와 비밀번호 확인이 다릅니다.":"실패"]
    
    func checkId(_ id: String, handler: @escaping (Bool) -> Void) {
        server.GET(api: api + "/checkId", param: ["id": id])
            .responseJSON { response in
            switch response.result {
            case .success:
                handler(true)
            case .failure:
                handler(false)
            }
        }
    }
    
    func checkPw(pw: String, chPw: String) -> Bool {
        return pw != chPw
    }
    
    func CheckNil(_ id: String,_ pw: String,_ chPw: String,_ name: String,_ age: String) -> Bool {
        return id == "" || pw == "" || chPw == "" || name == "" || age == ""
    }
    
    func SignUp(_ user: User, handler: @escaping (String) -> Void) {
        let param: [String : Any] = ["id": user.id!, "pw": user.pw!, "name": user.name!, "age": user.age!, "gender": user.gender!]
        
        server.POST(api: api + "/register", param: param).responseJSON { response in
            switch response.result {
            case .success:
                handler("회원가입에 성공하셨습니다.")
            case .failure:
                handler("회원가입에 실패하셨습니다.")
            }
        }
    }
    
    func GetAlertMsg(_ text: String) -> String {
        return alertMsg[text]!
    }
    
}
