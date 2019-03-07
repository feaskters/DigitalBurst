//
//  ViewController.swift
//  DigitalBurst
//
//  Created by iOS123 on 2019/3/7.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var music_btn: UIButton!
    
    //懒加载提示view
    lazy var tipView : UIView = {
        
        //初始化view
        let view = UIView.init()
        view.frame = CGRect.init(x: 30, y: self.music_btn.frame.origin.y - 500, width: UIScreen.main.bounds.width - 60, height: 0)
        //测试
        view.clipsToBounds = true
        
        //添加控件
        //添加背景图片
        let backImage = UIImageView.init(image: UIImage.init(named: "tipBackground"))
        backImage.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width - 60, height: 250)
        view.addSubview(backImage)
        
        //添加提示语
        let tip = UILabel.init(frame: CGRect.init(x: 40, y: 20, width: UIScreen.main.bounds.width - 120, height: 200))
        tip.numberOfLines = 0
        tip.font = UIFont.init(name: "Marker Felt", size: 18)
        if getCurrentLanguage() == "cn"{
            tip.text = "玩法介绍: \n\t 将相应的数字拖到框中，使得每条线上连接的数字之和为10。"
        }else{
            tip.text = "How to play: \n\t Drag the appropriate number into the box so that the sum of the numbers connected on each line is 10."
        }
        tip.textColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        view.addSubview(tip)
        
        return view
    }()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //初始化背景
        let bg_view :UIImageView = UIImageView.init(frame: self.view.frame)
        bg_view.image = UIImage.init(named: "bg1")
        self.view.addSubview(bg_view)
        self.view.sendSubviewToBack(bg_view)
        
        //判断当前是否静音
        if Music.shared().getMuteVolume() == 0 {
            music_btn.setBackgroundImage(UIImage.init(named: "mute"), for: UIControl.State.normal)
        }else{
            music_btn.setBackgroundImage(UIImage.init(named: "unmute"), for: UIControl.State.normal)
        }
        
        //添加提示view
        self.view .addSubview(self.tipView)
    }

    @IBAction func start(_ sender: UIButton) {
        //音效
        let music = Music.shared()
        music.musicPlayEffective()
        
        let gsc = GameSelectorViewController.init(nibName: nil, bundle: nil)
        self.present(gsc, animated: true) {
            
        }
    }
    
    //音乐开关
    @IBAction func setting(_ sender: UIButton) {
        //播放音效
        let music = Music.shared()
        music.musicPlayEffective()
        //更改静音状态
        music.musicChangeMute()
        //判断当前是否静音
        if music.getMuteVolume() <= 0 {
            sender.setImage(UIImage.init(named: "mute"), for: UIControl.State.normal)
        }else{
            sender.setImage(UIImage.init(named: "unmute"), for: UIControl.State.normal)
        }
    }
    
    //提示按钮
    @IBAction func tip(_ sender: UIButton) {
        Music.shared().musicPlayEffective()
        if sender.tag == 0 {
            sender.tag = 1
            //显示提示View
            UIView.animate(withDuration: 1) {
                self.tipView.frame = CGRect.init(x: 30, y: self.music_btn.frame.origin.y - 400, width: UIScreen.main.bounds.width - 60, height: 250)
            }
        }else{
            sender.tag = 0
            //关闭提示view
            UIView.animate(withDuration: 1, animations: {
                self.tipView.frame = CGRect.init(x: 30, y: self.music_btn.frame.origin.y - 400, width: UIScreen.main.bounds.width - 60, height: 0)
            })
        }
        
    }
    
}

