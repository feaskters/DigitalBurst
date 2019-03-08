//
//  rankTableViewCell.swift
//  DigitalBurst
//
//  Created by iOS123 on 2019/3/8.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

class rankTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var rank: UILabel!
    
    var rankInfo : Dictionary<String,String>?
    
    class func rankTableViewCell() -> rankTableViewCell{
        return Bundle.main.loadNibNamed("rankTableViewCell", owner: nil, options: nil)![0] as! rankTableViewCell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = nil
        self.contentView.backgroundColor = nil
        
        self.rank.text = rankInfo!["rank"]
        self.name.text = rankInfo!["name"]
        self.score.text = rankInfo!["score"]
        
        switch Int(rankInfo!["rank"]!) {
        case 1:
            self.rank.textColor = #colorLiteral(red: 0.9450980392, green: 0.4862745098, blue: 0.4039215686, alpha: 1)
            break
        case 2:
            self.rank.textColor = #colorLiteral(red: 0.9137254902, green: 0.9411764706, blue: 0.1137254902, alpha: 1)
            break
        case 3:
            self.rank.textColor = #colorLiteral(red: 0.9450980392, green: 0.4862745098, blue: 0.4039215686, alpha: 1)
            break
        default:
            break
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
