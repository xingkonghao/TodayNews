//
//  HomeTopicCell.swift
//  TodayNews
//
//  Created by 星空浩 on 2016/11/3.
//  Copyright © 2016年 DFYG_YF3. All rights reserved.
//

import UIKit
import SnapKit
class HomeTopicCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    var filterWords: [YMFilterWord]?
    
    var closeButtonClosure: ((_ filterWords: [YMFilterWord])->())?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI(){
        addSubview(titleLabel)
        
        addSubview(avatarImageView)
        
        addSubview(nameLabel)
        
        addSubview(commentLabel)
        
        addSubview(timeLabel)
        
        addSubview(stickLabel)
        
        addSubview(closeButton)
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(self).offset(kHomeMargin)
            make.right.equalTo(self).offset(-kHomeMargin)
        }
        
        avatarImageView.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.left)
            make.bottom.equalTo(self.snp.bottom).offset(-kHomeMargin)
            make.size.equalTo(CGSize(width:16,height :16))
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarImageView.snp.right).offset(5)
            make.centerY.equalTo(avatarImageView)
        }
        
        commentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.right).offset(5)
            make.centerY.equalTo(nameLabel)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(commentLabel.snp.right).offset(5)
            make.centerY.equalTo(avatarImageView)
        }
        
        stickLabel.snp.makeConstraints { (make) in
            make.left.equalTo(timeLabel.snp.right).offset(5)
            make.centerY.equalTo(avatarImageView)
            make.height.equalTo(15)
        }
        
        closeButton.snp.makeConstraints { (make) in
            make.right.equalTo(titleLabel.snp.right)
            make.centerY.equalTo(avatarImageView)
            make.size.equalTo(CGSize(width:17,height:12))
        }
    }
    /// 置顶，热，广告，视频
    lazy var stickLabel: UIButton = {
        let stickLabel = UIButton()
        stickLabel.isHidden = true
        stickLabel.layer.cornerRadius = 3
        stickLabel.sizeToFit()
        stickLabel.isUserInteractionEnabled = false
        stickLabel.titleLabel!.font = UIFont.systemFont(ofSize: 12)
        stickLabel.setTitleColor(XKColor(r: 241, g: 91, b: 94, a: 1.0), for: .normal)
        stickLabel.layer.borderColor = XKColor(r: 241, g: 91, b: 94, a: 1.0).cgColor
        stickLabel.layer.borderWidth = 0.5
        return stickLabel
    }()
    
    /// 新闻标题
    lazy var titleLabel: UILabel = {

        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor.black
   
        return titleLabel
    }()
    
    /// 用户名头像
    lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        return avatarImageView
  
    }()
    
    /// 用户名
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        nameLabel.textColor = UIColor.lightGray
        return nameLabel
    }()
    
    /// 评论
    lazy var commentLabel: UILabel = {
        let comentLabel = UILabel()
        comentLabel.font = UIFont.systemFont(ofSize: 12)
        comentLabel.textColor = UIColor.lightGray
        return comentLabel
    }()
    
    /// 时间
    lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textColor = UIColor.lightGray
        return timeLabel
    }()
    
    /// 举报按钮
    lazy var closeButton: UIButton = {
        let closeButton = UIButton()
        closeButton.setImage(UIImage(named: "add_textpage_17x12_"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)
        return closeButton
    }()
    
    /// 举报按钮点击
    func closeBtnClick() {
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
