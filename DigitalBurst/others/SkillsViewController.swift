//
//  SkillsViewController.swift
//  DigitalBurst
//
//  Created by iOS123 on 2019/3/11.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

class SkillsViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.contentSize = self.scrollView.frame.size
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        let height = self.scrollView.frame.height
        self.scrollView.frame = CGRect.init(x: self.scrollView.frame.origin.x, y: self.scrollView.frame.origin.y, width: self.scrollView.frame.width, height: 0)
        UIView.animate(withDuration: 2) {
            self.scrollView.frame = CGRect.init(x: self.scrollView.frame.origin.x, y: self.scrollView.frame.origin.y, width: self.scrollView.frame.width, height: height)
        }
    }

    @IBAction func back(_ sender: UIButton) {
        Music.shared().musicPlayEffective()
        self.dismiss(animated: true, completion: nil)
    }
}
