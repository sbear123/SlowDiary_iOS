//
//  WeatherViewModel.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/05/19.
//

import Foundation
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewModel {
    
    static let shared = WeatherViewModel()
    
    let server: Server = Server()
    let api: String = "/weather"
    
    var WeatherList: [WeatherModel] = [
        WeatherModel(conditionID: 800, date: "yesterday", name: "로딩중", temp: 0),
        WeatherModel(conditionID: 800, date: "today", name: "로딩중", temp: 0),
        WeatherModel(conditionID: 800, date: "tomorrow", name: "로딩중", temp: 0)
    ]
    
    var countOfImageList: Int {
        return WeatherList.count
    }
    
    func GetWeather(at index: Int) -> WeatherModel {
        return WeatherList[index]
    }
    
    func GetData(lat: Double, lon: Double, handler: @escaping (String) -> Void) {
        let param: [String:Double] = ["lat":lat,"lon":lon]
        
        server.GET(api: api, param: param).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let weather = try! JSONDecoder().decode(WeatherData.self, from: json.rawData())
                self.WeatherList = []
                self.WeatherList.append(WeatherModel(conditionID: weather.yesterday?.id, date: "yesterday", name: weather.yesterday?.weather, temp: weather.yesterday?.temp))
                self.WeatherList.append(WeatherModel(conditionID: weather.today?.id, date: "today", name: weather.today?.weather, temp: weather.today?.temp))
                self.WeatherList.append(WeatherModel(conditionID: weather.tomorrow?.id, date: "tomorrow", name: weather.tomorrow?.weather, temp: weather.tomorrow?.temp))
                
                handler("데이터 불러오기 성공")
            case .failure:
                handler("데이터 불러오기 실패")
            }
        }
    }
}
