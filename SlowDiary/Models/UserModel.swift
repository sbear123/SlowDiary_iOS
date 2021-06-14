//
//  UserModel.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/06/05.
//

import Foundation

struct User: Codable {
    var id: String?
    var pw: String?
    var name: String?
    var age: Int?
    var gender: Bool?
}
