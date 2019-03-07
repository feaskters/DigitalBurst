//
//  GameSelectorViewController.swift
//  DigitalBurst
//
//  Created by iOS123 on 2019/3/7.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

class GameSelectorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }

    @IBAction func back(_ sender: UIButton) {
        //音效
        let music = Music.shared()
        music.musicPlayEffective()
        
        self.dismiss(animated: true) {
            
        }
    }
    /*
     tag 2:2
         3:3
         4:4
         1:rank
     */
    @IBAction func btn_click(_ sender: UIButton) {
        //音效
        let music = Music.shared()
        music.musicPlayEffective()
        
        switch sender.tag {
        case 2,3:
            let gvc = GameViewController.init(nibName: nil, bundle: nil)
            gvc.blockNum = sender.tag
            self.present(gvc, animated: false, completion: nil)
            break
        case 1:
            break
        default:
            break
        }
        
    }
    
}
