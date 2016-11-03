//
//  XKPageCell.swift
//  TodayNews
//
//  Created by 星空浩 on 2016/10/31.
//  Copyright © 2016年 DFYG_YF3. All rights reserved.
//

import UIKit

class XKPageCell: UICollectionViewCell {
   
    public func setupUI(text:String){
        addSubview(lab)
        lab.text = text
    }
    var lab:UILabel = {
        let lab = UILabel(frame: CGRect(x: SCREENW/2.0-50, y: SCREENH/2.0-100, width: 100, height: 30))
        lab.textColor = UIColor.black
        lab.backgroundColor = UIColor.white
        lab.textAlignment = .center
        return lab
    }()
}
