//
//  UIImageView+Extension.swift
//  TodayNews
//
//  Created by 杨蒙 on 16/8/7.
//  Copyright © 2016年 hrscy. All rights reserved.
//
//  UIImageView 设置圆角
//

import UIKit
import Kingfisher

extension UIImageView {
    func setCircleHeader(url: String) {
        let placeholder = UIImage(named: "home_head_default_29x29_")
        self.kf.setImage(with: URL(string: url) as Resource?)
        self.kf.setImage(with: URL(string:url) as? Resource, placeholder: placeholder, options: nil, progressBlock: nil) { (image, error, cachType, imageUrl) in
            self.image = (image == nil) ? placeholder : image?.circleImage()
        }
      
    }
}
