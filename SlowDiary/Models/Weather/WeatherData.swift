//
//  WeatherModel.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/05/19.
//

import Foundation

struct WeatherData: Codable {
    let yestarday: Weather
    let today: Weather
    let tomorrow: Weather
}

struct Weather: Codable {
    let temp: Double
    let weather: String
    let id: Int
}
