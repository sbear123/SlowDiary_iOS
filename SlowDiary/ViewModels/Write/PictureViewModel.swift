//
//  PictureViewModel.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/06/01.
//

import Foundation

class PictureViewModel {
    
    static let shared = PictureViewModel()
    
    private var data: [PictureModel] = [PictureModel(img: "pic.jpg", loc: "부산 금정구", tag1: "흑발", tag2: "얼짱 사진관", tag3: "부산"),PictureModel(img: "paperImage.png", loc: "대구 달성군", tag1: "개발중", tag2: "힘들당", tag3: "확인중")]
    
    func cntData() -> Int {
        return data.count
    }
    
    func getData(_ num:Int) -> PictureModel {
        return data[num]
    }
}
