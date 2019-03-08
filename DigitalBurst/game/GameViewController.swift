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
                
                self.merge(index: i)
            }else{
            }
        }
        return dic
    }
    
    //合并数字
    func merge( index: Int) {
        guard self.numArray[index].count >= 2 else {
            self.randomNumber()
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
                    self.merge(index: index)
                    
                }
                
            }else{
                //判断block是否为满
                self.judgeBlcok()
                self.randomNumber()
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
