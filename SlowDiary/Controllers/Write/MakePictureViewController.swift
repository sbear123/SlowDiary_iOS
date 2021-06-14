//
//  MakePictureViewController.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/06/11.
//

import UIKit
import MobileCoreServices

class MakePictureViewController: UIViewController {
    @IBOutlet var img: UIImageView!
    @IBOutlet var loc: UITextField!
    @IBOutlet var tag1: UITextField!
    @IBOutlet var tag2: UITextField!
    @IBOutlet var tag3: UITextField!
    
    var pic: Picture = Picture()
    let pVM: PictureViewModel = PictureViewModel()
    var bottomView: UpdatePictureViewController?
    var isUpdate: Bool = false
    var picNum: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func pickPicture(_ sender: Any) {
        let alert = UIAlertController(title: "선택", message: "선택", preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let camera = UIAlertAction(title: "카메라", style: .default) { [weak self] (_) in
            self?.presentCamera()
        }
        let album = UIAlertAction(title: "앨범", style: .default) { [weak self] (_) in
            self?.presentAlbum()
        }
        
        alert.addAction(cancel)
        alert.addAction(camera)
        alert.addAction(album)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func finish(_ sender: Any) {
        if img.image == UIImage(named: "picImage.png") {
            makeAlert(title: "사진이 등록 안 되어있습니다.", msg: "사진을 등록해주세요.")
            return
        } else if loc.text == nil {
            makeAlert(title: "위치 작성이 되어있지 않습니다.", msg: "사진의 위치를 입력해주세요.")
            return
        }
        pic = Picture(id: 0, url: "", place: loc.text, tag1: tag1.text, tag2: tag2.text, tag3: tag3.text)
        if isUpdate {
            pVM.updatePics(pic: pic)
            self.bottomView?.pics[picNum!] = pic
            self.bottomView?.reload()
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        }
        else {
            pVM.createPic(img: img.image!, pic: pic) { picture in
                self.bottomView?.pics.append(picture)
                self.bottomView?.reload()
                self.presentingViewController?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func presentCamera(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        
        present(vc, animated: true, completion: nil)
    }
    
    func presentAlbum(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        
        present(vc, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    func makeAlert(title: String, msg: String) -> Void {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        var okAction : UIAlertAction
        okAction = UIAlertAction(title: "OK", style: .default, handler : nil)
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
    }
    
}

extension MakePictureViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //카메라나 앨범등 PickerController가 사용되고 이미지 촬영을 했을 때 발동 된다.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            img.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
}
