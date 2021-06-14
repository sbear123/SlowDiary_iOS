//
//  DateModel.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/06/05.
//

import Foundation

struct DateModel: Codable {
    var id: String?
    var year: Int?
    var month: Int?
    var date: Int?
}

func GetToday(format: String) -> String {
    let now = Date()
    let date = DateFormatter()
    date.locale = Locale(identifier: "ko_kr")
    date.timeZone = TimeZone(abbreviation: "KST")
    date.dateFormat = format
    return date.string(from: now)
}
