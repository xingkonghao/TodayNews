//
//  StockCell.swift
//  TodayNews
//
//  Created by 星空浩 on 2016/11/15.
//  Copyright © 2016年 DFYG_YF3. All rights reserved.
//

import UIKit

class StockCell: UITableViewCell {

    @IBOutlet weak var nameLab1: UILabel!
    @IBOutlet weak var nameLab2: UILabel!
    @IBOutlet weak var nameLab3: UILabel!
    @IBOutlet weak var price1: UILabel!
    @IBOutlet weak var price2: UILabel!
    @IBOutlet weak var price3: UILabel!
    @IBOutlet weak var changeLab1: UILabel!
    @IBOutlet weak var changeLab2: UILabel!
    @IBOutlet weak var changeLab3: UILabel!
    @IBOutlet weak var timeLab: UILabel!
    @IBOutlet weak var remiderLab: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var newTopic:NewsItem? {
        didSet{
            
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
