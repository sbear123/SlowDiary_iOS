//
//  UpdateContentViewController.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/06/02.
//

import UIKit

class UpdateContentViewController: UIViewController {
    
    let wVM: WriteViewModel = WriteViewModel.shared
    var write: Write = Write()
    var isUpdate: Bool = false
    var bottomContentView: ContentViewController?
    var bottomWriteView: WriteViewController?
    
    @IBOutlet var text: UITextView!
    
    @IBAction func back(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func finishContent(_ sender: UIButton) {
        if isUpdate {
            makeAlert(title: "작성하시겠습니까?", msg: "일기를 작성합니다.")
        } else {
            makeAlert(title: "수정하시겠습니까?", msg: "수정하시면 예전에 작성하신 글은 사라집니다.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isUpdate = write.id != nil
        text.text = write.content
    }
    
    func makeAlert(title: String, msg: String) -> Void {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        var okAction: UIAlertAction
        var cancel: UIAlertAction
        okAction = UIAlertAction(title: "YES", style: .default, handler : {_ in
            let con = self.text.text
            self.write.content = con
            if self.bottomWriteView == nil {
                self.bottomContentView?.drawView(content: self.write.content!)
                if self.isUpdate {
                    self.wVM.updateContent(self.write.id!, content: con!)
                } else {
                    self.wVM.createContent(write: self.write) { write in
                        self.bottomContentView?.write.id = write.id
                    }
                }
            }
            else {
                self.bottomWriteView?.updateContent(arr: self.wVM.getContents(text: con!))
                if self.isUpdate {
                    self.wVM.updateContent(self.write.id!, content: con!)
                } else {
                    self.wVM.createContent(write: self.write) { write in
                        self.bottomWriteView?.write.id = write.id!
                        self.bottomWriteView?.isUpdate = true
                    }
                }
            }
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        })
        cancel = UIAlertAction(title: "NO", style: .destructive, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancel)
        present(alert, animated: false, completion: nil)
    }

}
