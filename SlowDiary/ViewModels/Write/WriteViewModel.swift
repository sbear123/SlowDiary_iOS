//
//  WriteViewModel.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/06/01.
//

import Foundation
import Alamofire
import SwiftyJSON

class WriteViewModel {
    
    static let shared = WriteViewModel()
    
    let server: Server = Server()
    let api: String = "/write"
    let uVM: UserViewModel = UserViewModel()
    
    var today: Write = Write()
    
    func getTodayWrite(handler: @escaping (Write) -> Void) {
        let year = GetToday(format: "yyyy")
        let month = GetToday(format: "MM")
        let date = GetToday(format: "dd")
        let param: [String:Any] = ["id":uVM.getUserData().id!,"year":year,"month":month,"date":date]
        server.GET(api: "\(api)/read", param: param).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let data = try? JSONDecoder().decode(Write.self, from: json.rawData())
                self.today = data!
                handler(self.today)
            case .failure:
                handler(Write())
            }
        }
    }
    
    func getWirte(date: DateModel, handler: @escaping (Write) -> Void) {
        let param: [String:Any] = ["id":date.id!,"year":date.year!,"month":date.month!,"date":date.date!]
        server.GET(api: "\(api)/read", param: param).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let data = try? JSONDecoder().decode(Write.self, from: json.rawData())
                handler(data!)
            case .failure:
                handler(Write())
            }
        }
    }
    
    func getContents(text: String) -> [String] {
        var str = ""
        var cnt = 0
        var result: [String] = []
        var lastCh = ""
        
        for t in text {
            cnt += 1
            let string = String(t)
            if string == "\n" {
                result.append(str)
                cnt = 0
                str = ""
            }
            else if string == " " {
                if str == "" { str += "      " }
                else if isSChar(lastCh) { str += "      " }
                else { str += "     " }
            }
            else if isSChar(string) { str += string + "    " }
            else { str += string + "   " }
            if cnt == 9 {
                result.append(str)
                cnt = 0
                str = ""
            }
            if result.count == 11 { return result }
            lastCh = string
        }
        result.append(str)
        for _ in result.count...11 {
            result.append("")
        }
        
        return result
    }
    
    func isSChar(_ ch: String) -> Bool {
        let charRegEx = "[!:\"'|;^/.,]{1}"
        let pred = NSPredicate(format: "SELF MATCHES %@", charRegEx)
        return pred.evaluate(with: ch)
    }
    
    func updateContent(_ id: Int, content: String) {
        let param: [String:Any] = ["id":id, "content": content]
        server.PATCH(api: "\(api)/update/content", param: param).responseJSON { response in
            switch response.result {
            case .success:
                print("success")
            case .failure:
                print("false")
            }
        }
    }
    
    func updateWrite(write: Write, handler: @escaping () -> Void) {
        var param: [String:Any] = [:]
        param["id"] = write.id!
        param["feel"] = write.feel ?? ""
        param["praise"] = write.praise ?? ""
        param["reflection"] = write.reflection ?? ""
        param["title"] = write.title!
        param["satisfaction"] = write.satisfaction!
        param["goal"] = write.goal ?? ""
        
        server.PATCH(api: "\(api)/update/write", param: param).responseJSON { response in
            switch response.result {
            case .success:
                handler()
            case .failure:
                handler()
            }
        }
    }
    
    func createWrite(write: Write) {
        var cWrite = write
        var param: [String:Any] = [:]
        param["id"] = uVM.getUserData().id!
        param["feel"] = write.feel ?? ""
        param["praise"] = write.praise ?? ""
        param["reflection"] = write.reflection ?? ""
        param["title"] = write.title!
        param["satisfaction"] = write.satisfaction!
        param["goal"] = write.goal ?? ""
        
        server.POST(api: "\(api)/create", param: param).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let id = json["id"].int!
                cWrite.id = id
                print("성공")
            case .failure:
                print("실패")
            }
        }
    }
    
    func createContent(write: Write, handler: @escaping (Write) -> Void) {
        var cWrite = write
        var param: [String:Any] = [:]
        param["id"] = uVM.getUserData().id!
        param["content"] = write.content ?? ""
        
        server.POST(api: "\(api)/create", param: param).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let id = json["id"].int!
                cWrite.id = id
                handler(cWrite)
            case .failure:
                handler(Write())
            }
        }
    }
    
}
