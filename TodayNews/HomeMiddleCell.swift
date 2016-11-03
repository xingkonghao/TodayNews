//
//  HomeMiddleCell.swift
//  TodayNews
//
//  Created by 星空浩 on 2016/11/3.
//  Copyright © 2016年 DFYG_YF3. All rights reserved.
//

import UIKit

class HomeMiddleCell: HomeTopicCell {
    
    var newsTopic: NewsItem? {
        didSet{
            titleLabel.text = String(newsTopic!.title!)
            timeLabel.text = NSString.changeDateTime(publish_time: newsTopic!.publish_time!)
            if let sourceAvatar = newsTopic?.source_avatar {
                nameLabel.text = newsTopic!.source
                avatarImageView.setCircleHeader(url: sourceAvatar)
                rightImageView.kf.setImage(with:URL(string: sourceAvatar)!)
            }
            
            if let mediaInfo = newsTopic!.media_info {
                nameLabel.text = mediaInfo.name
                avatarImageView.setCircleHeader(url: mediaInfo.avatar_url!)
                rightImageView.kf.setImage(with:URL(string: mediaInfo.avatar_url!))

            }
            
            
            if let commentCount = newsTopic!.comment_count {
                commentCount >= 10000 ? (commentLabel.text = "\(commentCount / 10000)万评论") : (commentLabel.text = "\(commentCount)评论")
            } else {
                commentLabel.isHidden = true
            }
            
            if (newsTopic!.titleH + avatarImageView.height + kMargin) < (newsTopic?.imageH)! {
                closeButton.snp.remakeConstraints({ (make) in
                    make.right.equalTo(rightImageView.snp.left).offset(-kHomeMargin)
                    make.centerY.equalTo(avatarImageView)
                    make.size.equalTo(CGSize(width:17,height: 12))
                })
            }
            filterWords = newsTopic?.filter_words
            let url = newsTopic!.middle_image?.url
            rightImageView.kf.setImage(with:URL(string: url!)!)
            
            if let label = newsTopic?.label {
                stickLabel.setTitle(" \(label) ", for: .normal)
                stickLabel.isHidden = false
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(rightImageView)
        
        addSubview(timeButton)
        
//        timeButton.snp.makeConstraints { (make) in
//            make.right.equalTo(rightImageView.snp.right).offset(-5)
//            make.bottom.equalTo(rightImageView.snp.bottom).offset(-5)
//        }
//        
//        rightImageView.snp.makeConstraints { (make) in
//            make.top.equalTo(self).offset(kHomeMargin)
//            make.size.equalTo(CGSize(width:108,height: 70))
//            make.right.equalTo(self).offset(-kHomeMargin)
//        }
//        
//        titleLabel.snp.remakeConstraints { (make) in
//            make.right.equalTo(rightImageView.snp.left).offset(-kHomeMargin)
//            make.left.top.equalTo(self).offset(kHomeMargin)
//        }
    }
    
    /// 右下角的视频时长
    private lazy var timeButton: UIButton = {
        let timeButton = UIButton()
        timeButton.isHidden = true
        timeButton.isUserInteractionEnabled = false
        timeButton.layer.cornerRadius = 8
        timeButton.layer.masksToBounds = true
        timeButton.setTitleColor(UIColor.white, for: .normal)
        timeButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        timeButton.setImage(UIImage(named: "palyicon_video_textpage_7x10_"), for: .normal)
        return timeButton
    }()
    
    /// 右边图片
    private lazy var rightImageView: UIImageView = {
        let rightImageView = UIImageView()
        rightImageView.backgroundColor = UIColor.lightGray
        return rightImageView
    }()
    
    /// 举报按钮点击
    override func closeBtnClick() {
        closeButtonClosure?(filterWords!)
    }
    
    /// 举报按钮点击回调
    func closeButtonClick(closure:@escaping (_ filterWord: [YMFilterWord])->()) {
        closeButtonClosure = closure
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
