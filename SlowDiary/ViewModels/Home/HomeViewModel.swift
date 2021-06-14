//
//  HomeViewModel.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/06/08.
//

import Foundation
import Alamofire
import SwiftyJSON

class HomeViewModel {
    
    static let shared = HomeViewModel()
    
    let server: Server = Server()
    let uVM: UserViewModel = UserViewModel.shared
    
    var word = "오늘 어떤하루를 보내셨나요?"
    
    func getGoal(handler: @escaping (String) -> Void) {
        let param: [String:Any] = ["id":uVM.getUserData().id!,"date":GetToday(format: "yyyy.MM.dd")]
        server.GET(api: "/goal/read", param: param).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let data = try? JSONDecoder().decode(Goal.self, from: json.rawData())
                self.uVM.goal = data?.goal ?? ""
                handler(self.uVM.goal)
            case .failure:
                handler("아직 작성된 목표가 없습니다.")
            }
        }
    }
    
    func getWord(handler: @escaping (String) -> Void) {
        server.GET(api: "/home/word", param: ["date":GetToday(format: "yyyy.MM.dd")]).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let data = try? JSONDecoder().decode(Word.self, from: json.rawData())
                handler(data?.word ?? "오늘 어떤하루를 보내셨나요?")
            case .failure:
                handler("오늘 어떤하루를 보내셨나요?")
            }
        }
    }
    
    func getWrites(month: String, year: String, handler: @escaping ([String:String]) -> Void) {
        
        server.GET(api: "/home/read", param: ["month": month, "year": year]).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                var writes: [String:String] = [:]
                for data in json["write"].array! {
                    let date = "\(year).\(month).\(data["day"])"
                    writes.updateValue(data["feel"].string!, forKey: date)
                }
                handler(writes)
            case .failure:
                handler([:])
            }
        }
    }
    
}
