//
//  LoginViewModel.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/05/26.
//

import Foundation

class LoginViewModel {
    
    
    let alertMsg: [String:String] = ["로그인에 성공하셨습니다.":"성공", "아이디 혹은 비밀번호가 틀렸습니다. 다시 확인해주세요.":"실패", "입력이 안된곳이 있습니다. 확인해주세요.":"실패"]
    
    func CheckLogin(_ id: String,_ pw:String)-> String {
        UserDefaults.standard.set(id, forKey: "userid")
        UserDefaults.standard.set(id, forKey: "userpw")
        return "로그인에 성공하셨습니다."
    }
}
