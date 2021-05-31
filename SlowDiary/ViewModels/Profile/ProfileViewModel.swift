//
//  ProfileViewModel.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/05/26.
//

import Foundation

class ProfileViewModel {
    
    let changeImage = ["person.fill", "power"]
    let sections: [String] = ["정보수정", "로그아웃"]
    
    func logout() {
        
    }
    
    func changeProfile(id: String, pw: String, name: String, age: Int, gender: Bool)->Bool {
        return true
    }
    
    func removeKeys(keyName: String) {
        UserDefaults.standard.removeObject(forKey: keyName)
    }
}
