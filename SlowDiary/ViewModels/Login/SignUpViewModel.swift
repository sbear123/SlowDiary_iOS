//
//  SignUpViewModel.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/05/26.
//

import Foundation

class SignUpViewModel {
    
    func checkId(_ id: String ) -> Bool {
        return true
    }
    
    func checkPw(pw: String, chPw: String) -> Bool {
        return true
    }
    
    func checkNil(text: String) -> Bool {
        if text == "" {
            return false
        }
        return true
    }
    
    
}
