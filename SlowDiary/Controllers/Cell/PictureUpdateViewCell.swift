//
//  PictureUpdateViewCell.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/06/01.
//

import UIKit

class PictureUpdateViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var locIcon: UIImageView!
    @IBOutlet weak var locLabel: UILabel!
    @IBOutlet weak var tag1Label: UILabel!
    @IBOutlet weak var tag2Label: UILabel!
    @IBOutlet weak var tag3Label: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    let vm: PictureViewModel = PictureViewModel.shared
    
    @IBAction func deletePic(_ sender: Any) {
        
    }
    
    func update(_ data: Picture) {
        let url = URL(string: data.url!)
        do {
            let img = try Data(contentsOf: url!)
            imgView.image = UIImage(data: img)
        } catch  {
            
        }
        self.locLabel.text = data.place
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

class PictureAddViewCell: UITableViewCell {
    
    @IBOutlet var plus: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
