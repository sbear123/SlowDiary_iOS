//
//  HomeModel.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/06/03.
//

import Foundation

struct Home: Codable {
    var write: Feel?
}

struct Feel: Codable {
    var day: Int?
    var feel: String?
}

struct Word: Codable {
    var word: String?
    var feel: String?
}
