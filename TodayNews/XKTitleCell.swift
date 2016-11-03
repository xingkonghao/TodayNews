//
//  XKTitleCell.swift
//  TodayNews
//
//  Created by 星空浩 on 2016/10/31.
//  Copyright © 2016年 DFYG_YF3. All rights reserved.
//

import UIKit

class XKTitleCell: UICollectionViewCell {
   
   
    public var titleText:NSString {
        set {
            titleLab.text = newValue as String
        }
        get {
            return self.titleText
        }
    }
    public lazy var titleLab:UILabel = {
        let titleLab = UILabel(frame: self.bounds)
       titleLab.textAlignment = .center
        titleLab.font = UIFont.boldSystemFont(ofSize: 14)
        return titleLab
    }()
   
    public func setupUI(text:String){
        titleLab.removeFromSuperview()
        
        addSubview(titleLab)
        titleLab.text = text;
    }
    func didselect( selected: Bool){
        if(selected)
        {
            titleLab.font = UIFont.boldSystemFont(ofSize: 17)
        }else
        {
            titleLab.font = UIFont.boldSystemFont(ofSize: 14)
        }
    }
}
