//
//  NumberView.swift
//  DigitalBurst
//
//  Created by iOS123 on 2019/3/7.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

protocol NumberProtocol {
    func NumberIsInBlock(x:CGFloat , y:CGFloat ,sender:NumberView) -> Dictionary<String,CGFloat>;
    func NumberMoveToBlock(x:CGFloat , y:CGFloat);
}

class NumberView: UIView {
    
    private var num:Int?
    private var type : Int? //类型0->选择，1->固定
    var beginX : CGFloat?
    var beginY : CGFloat?
    var delegate : NumberProtocol?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        self.num = Int(pow(2.0, Double(Int(arc4random() % 4) + 1)))
        let image = UIImage.init(named: String(self.num!))
        let imageview = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        imageview.image = image
        self.addSubview(imageview)
        
        //设置初始位置
        self.beginX = self.frame.origin.x
        self.beginY = self.frame.origin.y
    }
    
    //返回数字
    func getNum() -> Int{
        return self.num!
    }
    
    override func layoutSubviews() {
        
        if type! == 0{
            let handDrag = UIPanGestureRecognizer(target: self, action: #selector(funcDrag))
            self.addGestureRecognizer(handDrag) 
        }else{
            
        }
    }
    
    @objc func funcDrag(sender: UIPanGestureRecognizer){
        var Point = sender.translation(in: self.superview);//现对于起始点的移动位置
        Point = sender.location(in: self.superview);//在整个self.view 中的位置
        
        if(sender.state == .began){
            Music.shared().musicPlayEffective()
            //            print("begin: "+String(describing: Point.x)+","+String(describing:Point.y))
        }else if(sender.state == .ended){
            Music.shared().musicPlayEffective()
            //            print("ended: "+String(describing: Point.x)+","+String(describing:Point.y))
            let dic = delegate?.NumberIsInBlock(x: Point.x, y: Point.y, sender:self)
            if dic!["isBlock"]! < CGFloat(0){
                UIView.animate(withDuration: 0.5) {
                self.frame = CGRect.init(x: self.beginX! , y: self.beginY!, width: 100, height: 50)
                self.subviews[0].frame = CGRect.init(x: 0, y: 0, width: 100, height: 50)
                }
            }else{
                UIView.animate(withDuration: 0.5) {
                    self.frame = CGRect.init(x: dic!["x"]! , y: dic!["y"]!, width: dic!["width"]!, height: 50)
                    self.subviews[0].frame = CGRect.init(x: 0, y: 0, width: dic!["width"]!, height: 50)
                }
            }
        }else{
            //            print("ing: "+String(describing: Point.x)+","+String(describing:Point.y))
            UIView.animate(withDuration: 0.2) {
                self.frame = CGRect.init(x: Point.x - 50, y: Point.y - 25, width: 100, height: 50)
                self.subviews[0].frame = CGRect.init(x: 0, y: 0, width: 100, height: 50)
            }
            
            delegate?.NumberMoveToBlock(x: Point.x, y: Point.y)
        }
        
    }

    func setType(type:Int) {
        self.type = type
    }
    
    func setNum(num:Int) {
        self.num = num
        (self.subviews[0] as! UIImageView).image = UIImage.init(named: String(num))
    }
    
}
