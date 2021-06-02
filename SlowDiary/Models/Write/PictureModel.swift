//
//  PictureModel.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/06/01.
//

import Foundation

class PictureModel {
    enum Picture {
        case img
        case loc
        case tag1
        case tag2
        case tag3
    }
    let img: String
    let loc: String
    let tag1: String
    let tag2: String
    let tag3: String
    
    init(img: String, loc: String, tag1: String, tag2: String, tag3: String) {
        self.img = img
        self.loc = loc
        self.tag1 = tag1
        self.tag2 = tag2
        self.tag3 = tag3
    }
}
