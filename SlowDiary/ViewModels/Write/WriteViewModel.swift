//
//  WriteViewModel.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/06/01.
//

import Foundation

class WriteViewModel {
    private var imgName = ["pic.jpg","paperImage.png"]
    
    func imgCount() -> Int {
        return imgName.count
    }
    
    func getImgName(_ num:Int) -> String {
        return imgName[num]
    }
    
}
