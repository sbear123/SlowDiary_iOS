//
//  UpdateContentViewController.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/06/02.
//

import UIKit

class UpdateContentViewController: UIViewController {

    @IBAction func back(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func finishContent(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
