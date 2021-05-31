//
//  WeatherViewModel.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/05/19.
//

import Foundation

class WeatherViewModel {
    let WeatherList: [WeatherModel] = [
        WeatherModel(conditionID: 700, date: "yesterday", name: "연무", temp: 7.26),
        WeatherModel(conditionID: 800, date: "today", name: "맑음", temp: 3),
        WeatherModel(conditionID: 800, date: "tomorrow", name: "맑음", temp: 11.48)
    ]
    
    var countOfImageList: Int {
        return WeatherList.count
    }
    
    func GetWeather(at index: Int) -> WeatherModel {
        return WeatherList[index]
    }
}
