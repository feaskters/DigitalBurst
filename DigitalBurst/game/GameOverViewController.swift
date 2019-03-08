//
//  GameOverViewController.swift
//  DigitalBurst
//
//  Created by iOS123 on 2019/3/8.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var score: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    var gvc : GameViewController?
    var block :Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.score.text = "0"
    }

    func setPropertys(block:Int,score:String,gvc:GameViewController) {
        self.score.text = String(score)
        self.titleLabel.text = String(block) + " Blocks"
        self.block = block
        self.gvc = gvc
    }
    
    @IBAction func back(_ sender: UIButton) {
        Music.shared().musicPlayEffective()
        
        //插入数据库
        switch self.block! {
        case 2:
            UserDb.shared().inserttwoBlocks(withName: self.name.text!, score: self.score.text!)
            break
        case 3:
            UserDb.shared().insertthreeBlocks(withName: self.name.text!, score: self.score.text!)
            break
        default:
            break
        }
        
        self.dismiss(animated: true, completion: nil)
        self.gvc?.dismiss(animated: true, completion: nil)
        
    }
    
}
