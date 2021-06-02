//
//  ContentViewController.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/06/02.
//

import UIKit

class ContentViewController: UIViewController {

    @IBAction func back(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func updateContent(_ sender: Any) {
        self.performSegue(withIdentifier: "updateContent", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
