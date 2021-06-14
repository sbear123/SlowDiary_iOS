//
//  WeatherViewCell.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/05/19.
//

import UIKit

class WeatherViewCell: UICollectionViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    func update(data: WeatherModel) {
        dateLabel.text = data.date?.capitalized
        imgView.image = UIImage(systemName: data.conditionName)
        tempLabel.text = data.tempString
        nameLabel.text = data.name
        if data.date == "today" {
            let color = hexStringToUIColor(hex: "#F2B694")
            dateLabel.textColor = color
            imgView.tintColor = color
            tempLabel.textColor = color
            nameLabel.textColor = color
        }
    }
}

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
