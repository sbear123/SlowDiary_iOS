//
//  WeatherInfo.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/05/19.
//

import Foundation
struct WeatherModel: Codable {
    let conditionID: Int?
    let date: String?
    let name: String?
    let temp: Double?
    var tempString: String {
        return String(format: "%.1f", temp!) + "°"
    }
    
    var conditionName: String{
            switch conditionID! {
            case 200...232:
                return "cloud.bolt"
            case 300...321:
                return "cloud.drizzle"
            case 500...504:
                return "cloud.sun.rain"
            case 511:
                return "cloud.snow"
            case 520...531:
                return "cloud.rain"
            case 600...622:
                return "cloud.snow"
            case 701...781:
                return "cloud.fog"
            case 800:
                return "sun.max"
            case 801:
                return "cloud.sun"
            default:
                return "cloud"
            }
    }
}

struct WeatherData: Codable {
    let yesterday: Weather?
    let today: Weather?
    let tomorrow: Weather?
}

struct Weather: Codable {
    let temp: Double?
    let weather: String?
    let id: Int?
}

struct Location: Codable {
    var lat: String?
    var lon: String?
}
