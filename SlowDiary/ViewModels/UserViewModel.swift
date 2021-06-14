//
//  UserViewModel.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/06/07.
//

import Foundation

class UserViewModel {
    
    static let shared = UserViewModel()
    
    var goal = ""
    var word = "오늘 어떤 하루를 보내셨나요?"
    
    func getUserData() -> User {
        var user: User = User()
        user.id = UserDefaults.standard.string(forKey: "id")
        user.pw = UserDefaults.standard.string(forKey: "pw")
        user.age = UserDefaults.standard.integer(forKey: "age")
        user.gender = UserDefaults.standard.bool(forKey: "gender")
        user.name = UserDefaults.standard.string(forKey: "name")
        return user
    }
    
    func setUserData(_ user: User) {
        UserDefaults.standard.set(user.id, forKey: "id")
        UserDefaults.standard.set(user.pw, forKey: "pw")
        UserDefaults.standard.set(user.age, forKey: "age")
        UserDefaults.standard.set(user.gender, forKey: "gender")
        UserDefaults.standard.set(user.name, forKey: "name")
    }
    
    func deleteUserData() {
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "pw")
        UserDefaults.standard.removeObject(forKey: "age")
        UserDefaults.standard.removeObject(forKey: "gender")
        UserDefaults.standard.removeObject(forKey: "name")
    }
}
