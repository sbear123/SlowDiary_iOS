//
//  PictureCell.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/06/01.
//

import UIKit

class PictureViewCell: UITableViewCell {
    @IBOutlet weak var locIcon: UIImageView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var locLabel: UILabel!
    @IBOutlet weak var tag1Label: UILabel!
    @IBOutlet weak var tag2Label: UILabel!
    @IBOutlet weak var tag3Label: UILabel!
    
    func update(data: Picture) {
        let url = URL(string: data.url!)
        do {
            let img = try Data(contentsOf: url!)
            imgView.image = UIImage(data: img)
        } catch  {
            
        }
        locLabel.text = data.place
        tag1Label.text = "# \(data.tag1!)"
        tag2Label.text = "# \(data.tag2!)"
        tag3Label.text = "# \(data.tag3!)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

class PicViewCell: UICollectionViewCell {
    @IBOutlet weak var locIcon: UIImageView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var locLabel: UILabel!
    @IBOutlet weak var tag1Label: UILabel!
    @IBOutlet weak var tag2Label: UILabel!
    @IBOutlet weak var tag3Label: UILabel!
    
    func update(data: Picture) {
        let url = URL(string: data.url!)
        do {
            let img = try Data(contentsOf: url!)
            imgView.image = UIImage(data: img)
        } catch  {
            
        }
        locIcon.image = UIImage(systemName: "mappin.and.ellipse")
        locLabel.text = data.place
        tag1Label.text = "# \(data.tag1!)"
        tag2Label.text = "# \(data.tag2!)"
        tag3Label.text = "# \(data.tag3!)"
    }
}
