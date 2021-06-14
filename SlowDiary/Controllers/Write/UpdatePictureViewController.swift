//
//  UpdatePictureViewController.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/06/01.
//

import UIKit

class UpdatePictureViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func back(_ sender: Any) {
        if bottomWriteView != nil {
            bottomWriteView?.pics = self.pics
            bottomWriteView?.reloadPics()
        }
        else if bottomTodayView != nil {
            vm.todayPic = pics
        }
        else {
            bottomPicView?.pics = self.pics
            bottomPicView?.tableView.reloadData()
        }
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func finishPic(_ sender: Any) {
        if bottomWriteView != nil {
            bottomWriteView?.pics = self.pics
            bottomWriteView?.reloadPics()
        }
        else if bottomTodayView != nil {
            vm.todayPic = pics
        }
        else {
            bottomPicView?.pics = self.pics
            bottomPicView?.tableView.reloadData()
        }
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    let vm: PictureViewModel = PictureViewModel.shared
    var bottomPicView: UpdatePictureViewController?
    var bottomWriteView: WriteViewController?
    var bottomTodayView: TodayViewController?
    var pics: [Picture] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView.init(frame: .zero)
        // Do any additional setup after loading the view.
    }
    
    func reload() {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addPic" {
            let vc = segue.destination as? MakePictureViewController
            vc?.bottomView = self
        }
        else if segue.identifier == "updatePic" {
            let vc = segue.destination as? MakePictureViewController
            if let pic = sender as? Picture {
                vc?.bottomView = self
                vc?.pic = pic
                let url = URL(string: pic.url!)
                do {
                    let img = try Data(contentsOf: url!)
                    vc?.img.image = UIImage(data: img)
                } catch  {
                    
                }
                vc?.loc.text = pic.place
                vc?.tag1.text = pic.tag1 ?? ""
                vc?.tag2.text = pic.tag2 ?? ""
                vc?.tag3.text = pic.tag3 ?? ""
                vc?.picNum = pics.firstIndex { p in
                    p.id == pic.id
                }
            }
        }
    }
}

extension UpdatePictureViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pics.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if pics.count == indexPath.row {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddPicCell", for: indexPath) as! PictureAddViewCell
            cell.selectionStyle = .none
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "UpdatePicCell", for: indexPath) as! PictureUpdateViewCell
        
        let index: Int = indexPath.row
        let data: Picture = pics[index]
        
        cell.update(data)
        cell.deleteButton.tag = index
        cell.deleteButton.addTarget(self, action: #selector(deleteCell(_:)), for: .touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == pics.count {
            self.performSegue(withIdentifier: "addPic", sender: nil)
        } else {
            self.performSegue(withIdentifier: "updatePic", sender: pics[indexPath.row])
        }
    }
    
    @objc func deleteCell(_ sender: UIButton) {
        let data: Picture = pics[sender.tag]
        // data 값 삭제하는 코드 작성
        vm.deletPic(pic: data)
        pics.remove(at: sender.tag)
        reload()
    }
}
