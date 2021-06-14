//
//  PictureModel.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/06/01.
//

import Foundation

struct Picture: Codable {
    var id: Int?
    var url: String?
    var place: String?
    var tag1: String?
    var tag2: String?
    var tag3: String?
}
