//
//  ContentViewController.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/06/02.
//

import UIKit

class ContentViewController: UIViewController {
    
    @IBOutlet var text: UITextView!
    var bottomView: TodayViewController?
    var write: Write = Write()
    
    @IBAction func back(_ sender: UIButton) {
        bottomView?.drawView()
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func updateContent(_ sender: UIButton) {
        self.performSegue(withIdentifier: "updateContent", sender: self.write)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawView(content: write.content ?? "")
    }
    
    func drawView(content: String) {
        text.text = content
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "updateContent" {
            let vc = segue.destination as? UpdateContentViewController
            if var w = sender as? Write {
                w.content = self.text.text
                vc?.write = w
                vc?.bottomContentView = self
            }
        }
    }
    
}
