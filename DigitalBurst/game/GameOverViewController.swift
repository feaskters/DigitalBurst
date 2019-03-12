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
        if self.getCurrentLanguage() == "cn" {
            
            self.titleLabel.text = String(block) + "格"
        }else{
            
            self.titleLabel.text = String(block) + " Blocks"
        }
        self.block = block
        self.gvc = gvc
    }
    
    //获取系统语言
    func getCurrentLanguage() -> String {
        //        let defs = UserDefaults.standard
        //        let languages = defs.object(forKey: "AppleLanguages")
        //        let preferredLang = (languages! as AnyObject).object(0)
        let preferredLang = Bundle.main.preferredLocalizations.first! as NSString
        //        let preferredLang = (languages! as AnyObject).object(0)
        
        switch String(describing: preferredLang) {
        case "en-US", "en-CN":
            return "en"//英文
        case "zh-Hans-US","zh-Hans-CN","zh-Hant-CN","zh-TW","zh-HK","zh-Hans":
            return "cn"//中文
        default:
            return "en"
        }
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
