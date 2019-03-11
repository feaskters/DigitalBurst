//
//  RankViewController.swift
//  DigitalBurst
//
//  Created by iOS123 on 2019/3/8.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

class RankViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    


    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moreView: UIView!
    @IBOutlet weak var scrollView: UITableView!
    
    var InfoArray : Array<Any>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.delegate = self
        self.scrollView.dataSource = self
        self.scrollView.register(rankTableViewCell.classForCoder(), forCellReuseIdentifier: "rankCell")
        self.getTwoBlocks()
        // Do any additional setup after loading the view.
    }


    
    @IBAction func more(_ sender: UIButton) {
        Music.shared().musicPlayEffective()
        
        UIView.animate(withDuration: 1) {
            self.moreView.alpha = 1
            self.moreView.frame = CGRect.init(x:
                self.moreView.frame.origin.x, y: self.moreView.frame.origin.y , width: self.moreView.frame.width, height: 100)
            for item in self.moreView.subviews{
                item.alpha = 1
            }
        }
    }
    
    @IBAction func changeBtn(_ sender: UIButton) {
        Music.shared().musicPlayEffective()
        
        switch sender.tag {
        case 2:
            self.titleLabel.text = "2 Blocks"
            self.getTwoBlocks()
            break
        case 3:
            self.titleLabel.text = "3 Blocks"
            self.getThreeBlocks()
            break
        default:
            break
        }
        //本身消失
        UIView.animate(withDuration: 1) {
            
            self.moreView.frame = CGRect.init(x: self.moreView.frame.origin.x, y: self.moreView.frame.origin.y, width: self.moreView.frame.width, height: 0)
            
            self.moreView.alpha = 0
            for item in self.moreView.subviews{
                item.alpha = 0
            }
        }
    }
    
    //获取2Blocks数据
    func getTwoBlocks() {
        self.InfoArray =  UserDb.shared().selecttwoBlocks()
        self.scrollView.reloadData()
    }
    
    //获取3Blocks数据
    func getThreeBlocks() {
        self.InfoArray =  UserDb.shared().selectthreeBlocks()
        self.scrollView.reloadData()
    }
    
    
    @IBAction func back(_ sender: UIButton) {
        Music.shared().musicPlayEffective()
        self.dismiss(animated: true, completion: nil)
    }
    
    //tableview代理
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.InfoArray?.count)!
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell :rankTableViewCell = tableView.dequeueReusableCell(withIdentifier: "rankCell") as! rankTableViewCell
        cell = rankTableViewCell.rankTableViewCell()
        let infoDic = self.InfoArray![indexPath.row] as! Dictionary<String,Any>
        let dic :Dictionary<String,String> = ["rank" : String(indexPath.row + 1),
                                              "name" : String(infoDic["name"]! as! String),
                                              "score" : String(infoDic["score"]! as! Int)]
        cell.rankInfo = dic
        return cell
    }
    
}
