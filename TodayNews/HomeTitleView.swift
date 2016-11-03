//
//  HomeTitleView.swift
//  TodayNews
//
//  Created by 星空浩 on 2016/10/27.
//  Copyright © 2016年 DFYG_YF3. All rights reserved.
//

import UIKit
import SnapKit
class HomeTitleView: UIView {
    
    var startIndex:NSInteger = 0
    var titles = [HomeTopTitle]()
    var buttonHeight:CGFloat = 44.0
    var buttonWidths:CGFloat = 0.0

    var didSelectTitle:((_ titleBtn: TitleButton)->())?
    
//    var titlesClosure:(_ titleArray: [])
    
    var lastTitleBtn:TitleButton? = nil
    override init(frame:CGRect){
        super.init(frame: frame)
    self.isUserInteractionEnabled = true
    }
    override func draw(_ rect: CGRect) {

    }
    
    
    func setupUI(titles:[HomeTopTitle]){
        buttonHeight = self.frame.size.height
        buttonWidths = (SCREENW - 40.0*2)/6.5
        
        self.titles = titles
        addSubview(titleScroll)
        addSubview(addButton)
        addSubview(searchButton)
        titleScroll.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(0)
            make.right.equalTo(addButton.snp.left).offset(0)
        }
        addButton.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(0)
            make.left.equalTo(titleScroll.snp.right).offset(0)
            make.width.equalTo(40)
            make.right.equalTo(searchButton.snp.left).offset(0)
        }
        searchButton.snp.makeConstraints { (make) in
            make.top.right.bottom.equalTo(0)
            make.width.equalTo(40)
        }
        self.setupButtons()
    }
    
    private lazy var titleScroll:UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        scroll.isScrollEnabled = true
        scroll.contentSize = CGSize(width: self.buttonWidths * CGFloat(self.titles.count), height: self.frame.size.height)
        return scroll
    }()
    private lazy var addButton:UIButton = {
        let addBtn = UIButton()
        addBtn.setImage(UIImage(named:"add_channel_titlbar_16x16_"), for: .normal)
        addBtn.setTitleColor(UIColor.white, for: .normal)
        addBtn.addTarget(self, action: #selector(addButtonClick), for: .touchUpInside)
        
        return addBtn
    }()
    private lazy var searchButton:UIButton = {
        let searchButton = UIButton(type: .custom)
        searchButton.setImage(UIImage(named:"searchicon_search_20x20_"), for: .normal)
        return searchButton
    }()
    func addButtonClick(){

    }
    
    
    private func setupButtons(){
        for (index,topic) in titles.enumerated(){
            
            let button = TitleButton(frame: CGRect(x: CGFloat(index) * self.buttonWidths, y: 0, width: self.buttonWidths, height: buttonHeight))
            button.setTitle(topic.name, for: .normal)
            button.tag = index + 100
            if startIndex == index {
                button.currentScale = 1.1
            }
            button.backgroundColor = UIColor.orange
            button.setTitleColor(XKColor(r: 235, g: 235, b: 235, a: 1.0), for: .normal)
            button.setTitleColor(UIColor.white, for: .selected)
            button.titleLabel?.textAlignment = .center
            button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
            button.addTarget(self, action: #selector(tapTitleBtn(titleButton:)), for: .touchUpInside)
            titleScroll.addSubview(button)
            
        }
    }
     func adjustTitleOffSetToCurrentIndex(index:NSInteger){
        
        let centerX:CGFloat = SCREENW/2.0
        var scrollSpace = buttonWidths * CGFloat(index-100) + buttonWidths/2.0  - centerX
        if scrollSpace<0 {
            scrollSpace = 0
        }
        if scrollSpace>buttonWidths*CGFloat(titles.count) - self.titleScroll.width {
            scrollSpace = CGFloat(titles.count)*buttonWidths - self.titleScroll.width
        }
        titleScroll.setContentOffset(CGPoint(x:scrollSpace ,y:0), animated: true)
        
        let currentBtn:TitleButton = self.viewWithTag(index) as! TitleButton

        guard currentBtn != lastTitleBtn else {
            return
        }
        currentBtn.currentScale = 1.1
        lastTitleBtn?.currentScale = 1.0
        lastTitleBtn = currentBtn
        
    }
     func tapTitleBtn(titleButton: TitleButton){
        guard lastTitleBtn != titleButton else {
            return
        }
        titleButton.isSelected = !titleButton.isSelected
        lastTitleBtn?.isSelected = !(lastTitleBtn?.isSelected)!
        
        self.adjustTitleOffSetToCurrentIndex(index: titleButton.tag)
        //向外传出 点击的按钮
        self.didSelectTitle!(titleButton)
    }
    func didSelectTitleClosure(closure:@escaping (_ titleButton: TitleButton) -> ()) {
        didSelectTitle = closure
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension HomeTitleView {

}
class TitleButton: UIButton {
    var currentScale:CGFloat = 1.0 {
        didSet{
                transform = CGAffineTransform(scaleX: currentScale,y: currentScale)
        }
    }
}
