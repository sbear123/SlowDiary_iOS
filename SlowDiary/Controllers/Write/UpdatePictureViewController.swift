//
//  UpdatePictureViewController.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/06/01.
//

import UIKit

class UpdatePictureViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBAction func back(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func finishPic(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    let vm: PictureViewModel = PictureViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.cntData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UpdatePicCell", for: indexPath) as! PictureUpdateViewCell
        
        let index: Int = indexPath.row
        let data: PictureModel = vm.getData(index)
        
        cell.update(data)
        
        return cell
    }

}
