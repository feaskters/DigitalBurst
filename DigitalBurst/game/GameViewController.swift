//
//  GameViewController.swift
//  DigitalBurst
//
//  Created by iOS123 on 2019/3/7.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

class GameViewController: UIViewController,NumberProtocol {
    
    var blockNum : Int? //空格数
    var numArray : Array<Array<NumberView>> = [] //数字串
    var borderArray : Array<UIView> = [] //边框数组
    var arrayWidth : CGFloat?
    let border_silver = UIImage.init(named: "border_silver")
    let border_gold = UIImage.init(named: "border_gold")
    var selectNum : NumberView? //提供选择的数字
    var skillNum : Dictionary<String,Int> = ["random" : 3,
                                             "128" : 1,
                                             "256" : 0,
                                             "512" : 0]
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var selectImage: UIImageView!
    
    @IBOutlet weak var selectView: UIView!
    
    @IBOutlet weak var score: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var imageArray:Array<UIImage> = []
        for i in 0...15{
            imageArray.append(UIImage.init(named: String("旋转" + String(i)))!)
        }
        self.selectImage.animationImages = imageArray
        self.selectImage.animationDuration = 1
        self.selectImage.startAnimating()
    }
    
    //出现随机数字
    func randomNumber() {
        let numView = NumberView.init(frame: CGRect.init(x: self.selectView.frame.origin.x + 25, y: self.selectView.frame.origin.y + 50, width: 100, height: 50))
        numView.setType(type: 0)
        numView.delegate = self
        self.view.addSubview(numView)
        self.selectNum = numView
    }
    
    //更换随机数字
    func changeNum() {
        //保存现有数字
        let num = self.selectNum?.getNum()
        self.selectNum?.removeFromSuperview()
        self.randomNumber()
        //判断相等
        while  num == self.selectNum?.getNum(){
            self.selectNum?.removeFromSuperview()
            self.randomNumber()
        }
    }
    
    //清空Num以下的数字
    func clearNumsBelow(Num:Int) {
        for i in 0...numArray.count - 1 {
            var flag = 0 //删除数字个数标致
            for j in 0...self.numArray[i].count{
                let index = j - flag
                
                if self.numArray[i].count > index {
                    if self.numArray[i][index].getNum() < Num{
                        self.numArray[i][index].removeFromSuperview()
                        self.numArray[i].remove(at: index)
                        flag = flag + 1
                        
                        if self.numArray[i].count > index {
                        //动画向上
                            UIView.animate(withDuration: 0.5, animations: {
                                 self.numArray[i][index].frame = CGRect.init(x: self.numArray[i][index].frame.origin.x, y: self.numArray[i][index].frame.origin.y - CGFloat( 62.5 * Double(flag)), width: self.numArray[i][index].frame.width, height: self.numArray[i][index].frame.height)
                            })
                           
                        }
                    }
                }
                
            }
            self.merge(index: i,tag:0)
        }
    }
    
//技能点击
    @IBAction func skill(_ sender: UIButton) {
        Music.shared().musicPlayEffective()
        sender.setTitle(String(Int((sender.titleLabel?.text!)!)! - 1), for: UIControl.State.normal)
        //tag=1025为随机
        if sender.tag == 1025 {
            self.changeNum()
            self.skillNum["random"] = self.skillNum["random"]! - 1
            if self.skillNum["random"]! == 0{
                sender.isEnabled = false
            }
        }else{
            self.clearNumsBelow(Num: sender.tag)
            self.skillNum[String(sender.tag)] = self.skillNum[String(sender.tag)]! - 1
            if self.skillNum[String(sender.tag)]! == 0 {
                sender.isEnabled = false
            }
        }
    }
    
    //增加技能次数
    func addSkill(tag:Int) {
        //判断是否可以加
        let item = self.view.viewWithTag(tag)
        if item != nil {
            self.skillNum[String(tag)] = self.skillNum[String(tag)]! + 1
            let btn = item as! UIButton
            btn.setTitle(String(Int((btn.titleLabel?.text)!)! + 1), for: UIControl.State.normal)
            btn.isEnabled = true
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool)  {
        let containerWidth = container.frame.width //容器宽
        let containerHeight = container.frame.height //容器高
        let arrayWidth = containerWidth / CGFloat(blockNum!) //数字串宽
        self.arrayWidth = arrayWidth
        
        for i in 0...blockNum! - 1  {
            //初始化数组
            numArray.append([])
            //初始化数字串
            let view = UIView.init(frame: CGRect.init(x: CGFloat(i) * arrayWidth, y: 0, width: arrayWidth, height: containerHeight))
            let imageview = UIImageView.init(image: border_silver)
            imageview.frame = CGRect.init(x: 0, y: 0, width: arrayWidth, height: containerHeight)
            self.borderArray.append(view)
            view.addSubview(imageview)
            self.container.addSubview(view)
        }
        
        self.randomNumber()
    }


    @IBAction func back(_ sender: UIButton) {
        //音效
        let music = Music.shared()
        music.musicPlayEffective()
        
        self.dismiss(animated: false) {
            
        }
    }
    
    
    //数字代理
    func NumberIsInBlock(x: CGFloat, y: CGFloat, sender: NumberView) -> Dictionary<String, CGFloat> {
        var dic = Dictionary<String, CGFloat>.init()
        dic["isBlock"] = CGFloat(-1)
        dic["x"] = CGFloat(sender.beginX!)
        dic["y"] = CGFloat(sender.beginY!)
        dic["width"] = CGFloat(0)
        let containerx = self.container.frame.origin.x
        let containery = self.container.frame.origin.y
        for i in 0...borderArray.count - 1 {
            let itemx = borderArray[i].frame.origin.x
            let itemwidth = borderArray[i].frame.width
            let itemheight = borderArray[i].frame.height
            let itemy = borderArray[i].frame.origin.y
            if containerx + itemx < x && x < containerx + itemx + itemwidth && containery + itemy < y && y < containery + itemy + itemheight && numArray[i].count < 7{
                dic["x"] = containerx + itemx + 10
                dic["y"] = containery + itemy + CGFloat(12.5 * Double(numArray[i].count + 1)) + CGFloat(50 * Double(numArray[i].count))
                dic["width"] = itemwidth - 20
                
                dic["isBlock"] = CGFloat(1)
                
                self.numArray[i].append(sender)
                sender.isUserInteractionEnabled = false
                
                self.merge(index: i,tag:1)
            }else{
            }
        }
        return dic
    }
    
    //合并数字
    //tag->是否产生新数字
    func merge( index: Int,tag:Int) {
        guard self.numArray[index].count >= 2 else {
            if tag == 1 {
                self.randomNumber()
            }
            return
        }
            //判断相等
            if self.numArray[index].last?.getNum() == self.numArray[index][self.numArray[index].count - 2].getNum() && self.numArray[index].last?.getNum() != 1024 {
                UIView.animate(withDuration: 0.5, animations: {
                    //播放融合音效
                    Music.shared().musicPlayMergeEffective()
                    self.numArray[index].last?.frame = CGRect.init(x: self.numArray[index].last!.frame.origin.x, y: self.numArray[index].last!.frame.origin.y - 65.5, width: self.numArray[index].last!.frame.width, height: self.numArray[index].last!.frame.height)
                }) { (Bool) in
                    self.numArray[index].last?.removeFromSuperview()
                    self.numArray[index].removeLast()
                    self.numArray[index].last!.setNum(num: self.numArray[index].last!.getNum() * 2)
                    //加分
                    self.score.text = String(Int(self.score.text!)! + self.numArray[index].last!.getNum())
                    //加技能
                    self.addSkill(tag: (self.numArray[index].last!.getNum()) / 2)
                    
                    self.merge(index: index,tag:tag)
                }
                
            }else{
                if tag == 1 {
                    //判断block是否为满
                    self.judgeBlcok()
                    self.randomNumber()
                }
            }
    }
    
    //判断blocks是否已满
    func judgeBlcok() {
        
        var flag = true //判断是否为满标致
        for item in self.numArray{
            if item.count < 7{
                flag = false
            }
        }
        
        //弹出gameOver界面
        if flag{
            let govc = GameOverViewController.init(nibName: nil, bundle: nil)
            self.present(govc, animated: true, completion: nil)
            govc.setPropertys(block: self.blockNum!, score: self.score.text!, gvc: self)
        }
    }
    
    //拖动过程代理
    func NumberMoveToBlock(x: CGFloat, y: CGFloat) {
        let containerx = self.container.frame.origin.x
        let containery = self.container.frame.origin.y
        for item in borderArray {
            let itemx = item.frame.origin.x
            let itemwidth = item.frame.width
            let itemheight = item.frame.height
            let itemy = item.frame.origin.y
            if containerx + itemx < x && x < containerx + itemx + itemwidth && containery + itemy < y && y < containery + itemy + itemheight {
                (item.subviews[0] as! UIImageView).image = border_gold
            }else{
                (item.subviews[0] as! UIImageView).image = border_silver
            }
        }
    }
    
}
