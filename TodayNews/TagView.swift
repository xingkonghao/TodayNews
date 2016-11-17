//
//  TagView.swift
//  TodayNews
//
//  Created by 星空浩 on 2016/11/16.
//  Copyright © 2016年 DFYG_YF3. All rights reserved.
//

import UIKit

let space:CGFloat =  10
let btnSpace:CGFloat = 10
let marginSpace:CGFloat = 10
let btnHeihgt:CGFloat = 20
class TagView: UIView {

    let tagTitiles:[String] = ["快讯","股票","宏观经济","理财","基金","更多"]
    var alreadyCreat:Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        creatTagButton()
    }
    
    func creatTagButton() {
        if alreadyCreat {
            return
        }
        alreadyCreat = true
        var index:Int = 0
        let sizeArr:[CGSize] = caculateSize()
        
        var nextX = marginSpace
        for  size  in sizeArr {
        
            let btn:UIButton = UIButton(frame: CGRect(x: nextX, y: 5, width: size.width+space*2, height: btnHeihgt))
                btn.setTitle(tagTitiles[index], for: .normal)
            btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
            btn.tag = index + 100
            btn.setTitleColor(UIColor.lightGray, for: .normal)
            btn.layer.cornerRadius = btnHeihgt/2.0
            btn.layer.masksToBounds = true
            btn.layer.borderColor = UIColor.lightGray.cgColor
            btn.layer.borderWidth = 0.5
            self.addSubview(btn)
            btn.addTarget(self, action: #selector(btnAction(btn:)), for: .touchUpOutside)
            nextX = nextX + btn.frame.size.width + btnSpace
            index += 1
        }
    }
    
    func caculateSize() -> [CGSize] {
        var sizeArr:[CGSize]  = [CGSize]()

        var maxWidth:CGFloat = SCREENW - marginSpace * 2
        var index:Int = 0
        for var text in tagTitiles {
            text = text as String
            let maxSize:CGSize = CGSize(width: SCREENW-20, height: 30)
            let size = text.calculationStringSize(text: text, size: maxSize)
       
            let subtractor:CGFloat = index == tagTitiles.count - 1 ? size.width : size.width + space
            if  maxWidth - subtractor > 0 {
                sizeArr.append(size)
                maxWidth = maxWidth - subtractor
                index += 1
            }else
            {
                break
            }
        }
        return sizeArr
    }
    
    func btnAction(btn:UIButton)  {
        
    }
}
