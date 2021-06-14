//
//  WriteModel.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/06/05.
//

import Foundation

struct Write: Codable {
    var id: Int?
    var feel: String?
    var praise: String?
    var reflection: String?
    var title: String?
    var content: String?
    var satisfaction: Int? //만족도 %로 계산해서 전달
    var goal: String?
}
