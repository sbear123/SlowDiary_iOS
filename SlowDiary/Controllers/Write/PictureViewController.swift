//
//  PictureViewController.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/06/01.
//

import UIKit

class PictureViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func updatePic(_ sender: Any) {
        if bottomView != nil {
            bottomView?.PicCollectionView.reloadData()
        }
        self.performSegue(withIdentifier: "updatePicture", sender: self)
    }
    
    @IBAction func back(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    let vm: PictureViewModel = PictureViewModel.shared
    var bottomView: TodayViewController?
    var picture: [Picture] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView.init(frame: .zero)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return picture.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PictureCell", for: indexPath) as! PictureViewCell
        
        let index: Int = indexPath.row
        let data: Picture = picture[index]
        
        cell.update(data: data)
        
        return cell
    }
    
}
