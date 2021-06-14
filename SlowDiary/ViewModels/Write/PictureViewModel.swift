//
//  PictureViewModel.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/06/01.
//

import Foundation
import SwiftyJSON
import Alamofire

class PictureViewModel {
    
    static let shared = PictureViewModel()
    
    let server: Server = Server()
    let api: String = "/picture"
    let uVM: UserViewModel = UserViewModel.shared
    
    let defaultPic: [Picture] = [Picture(id:0, url:"picImage.png", place: "등록된 사진이 없습니다.", tag1: "사진을 등록해주세요!",tag2: "사진을 등록해주세요!", tag3: "사진을 등록해주세요!")]
    
    var todayPic: [Picture] = []
    
    func cntData() -> Int {
        return todayPic.count
    }
    
    func getData(_ num:Int) -> Picture {
        return todayPic[num]
    }
    
    func getPics(date: DateModel, handler: @escaping ([Picture]) -> Void) {
        let param: [String:Any] = ["id":uVM.getUserData().id!, "year":date.year!, "month":date.month!,"date":date.date!]
        
        server.GET(api: "\(api)/read", param: param).responseJSON {response in
            switch response.result{
            case .success(let value):
                let json = JSON(value).array!
                var pics: [Picture] = []
                if json.count == 0 {handler(self.defaultPic)}
                else {
                    for data in json {
                        pics.append(try! JSONDecoder().decode(Picture.self, from: data.rawData()))
                    }
                    handler(pics)
                }
            case .failure:
                handler(self.defaultPic)
            }
        }
    }
    
    func getTodayPics(handler: @escaping ([Picture]) -> Void) {
        let year = GetToday(format: "yyyy")
        let month = GetToday(format: "MM")
        let date = GetToday(format: "dd")
        let param: [String:Any] = ["id":uVM.getUserData().id!,"year":year,"month":month,"date":date]
        
        server.GET(api: "\(api)/read", param: param).responseJSON {response in
            switch response.result{
            case .success(let value):
                let json = JSON(value).array!
                var pics: [Picture] = []
                if json.count == 0 {handler(self.defaultPic)}
                else {
                    for data in json {
                        pics.append(try! JSONDecoder().decode(Picture.self, from: data.rawData()))
                    }
                    self.todayPic = pics
                    handler(pics)
                }
            case .failure:
                handler(self.defaultPic)
            }
        }
    }
    
    func updatePics(pic: Picture) {
        let param: [String:Any] = ["id":pic.id!, "place":pic.place!,"tag":[pic.tag1 ?? "",pic.tag2 ?? "",pic.tag3 ?? ""]]
        
        server.PATCH(api: "\(api)/update", param: param).responseJSON {response in
            switch response.result{
            case .success:
                print("수정 성공")
            case .failure:
                print("수정 실패")
            }
        }
    }
    
    func createPic(img: UIImage,pic: Picture, handler: @escaping (Picture) -> Void) {
        var cPic: Picture = pic
        let param: [String:Any] = ["id": uVM.getUserData().id!, "place":pic.place!,"tag":[pic.tag1 ?? "",pic.tag2 ?? "",pic.tag3 ?? ""]]
        
        server.UPLOAD(api: "\(api)/create", param: param, pic: img).responseJSON {response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                if let id = json["id"].int {
                    cPic.id = id
                }
                if let url = json["url"].string {
                    cPic.url = url
                }
                handler(cPic)
            case .failure:
                print("실패")
                handler(Picture())
            }
        }
    }
    
    func deletPic(pic: Picture) {
        let param: [String:Any] = ["id":pic.id!, "userid": uVM.getUserData().id!]
        
        server.DELETE(api: "\(api)/delete", param: param).responseJSON {response in
            switch response.result{
            case .success:
                print("수정 성공")
            case .failure:
                print("수정 실패")
            }
        }
    }
}
