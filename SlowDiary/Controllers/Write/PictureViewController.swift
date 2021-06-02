//
//  PictureViewController.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/06/01.
//

import UIKit

class PictureViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBAction func updatePic(_ sender: Any) {
        self.performSegue(withIdentifier: "updatePicture", sender: self)
    }
    
    @IBAction func back(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    let vm: PictureViewModel = PictureViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.cntData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PictureCell", for: indexPath) as! PictureViewCell
        
        let index: Int = indexPath.row
        let data: PictureModel = vm.getData(index)
        
        cell.update(data: data)
        
        return cell
    }
    
}
