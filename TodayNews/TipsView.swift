//
//  TipsView.swift
//  TodayNews
//
//  Created by 星空浩 on 2016/11/7.
//  Copyright © 2016年 DFYG_YF3. All rights reserved.
//

import UIKit

class TipsView: UIView {

   override func draw(_ rect: CGRect) {
        setupUI()
    }
    lazy var textLab:UILabel = {
        let textLab:UILabel = UILabel(frame: self.bounds)
        textLab.textColor = UIColor.black
        textLab.textAlignment = NSTextAlignment.center
        return textLab
    }()
    func setupUI() {
        backgroundColor = XKColor(r: 215, g: 233, b: 246, a: 1.0)

        addSubview(textLab)
    }

}
