//
//  HomeSmallCell.swift
//  TodayNews
//
//  Created by 星空浩 on 2016/11/3.
//  Copyright © 2016年 DFYG_YF3. All rights reserved.
//

import UIKit

class HomeSmallCell: HomeTopicCell {
    
    var newsTopic: NewsItem? {
        didSet{
            titleLabel.text = newsTopic?.title as String?
            timeLabel.text = NSString.changeDateTime(publish_time: newsTopic!.publish_time!)
            if let sourceAvatar = newsTopic?.source_avatar {
                nameLabel.text = newsTopic!.source
                avatarImageView.setCircleHeader(url: sourceAvatar)
            }
            
            if let mediaInfo = newsTopic!.media_info {
                nameLabel.text = mediaInfo.name
                avatarImageView.setCircleHeader(url: mediaInfo.avatar_url!)
            }
            
            if let commentCount = newsTopic!.comment_count {
                commentCount >= 10000 ? (commentLabel.text = "\(commentCount / 10000)万评论") : (commentLabel.text = "\(commentCount)评论")
            } else {
                commentLabel.isHidden = true
            }
            
            filterWords = newsTopic?.filter_words
            
            if newsTopic!.image_list.count > 0 {
                for index in 0..<newsTopic!.image_list.count {
                    let imageView = UIImageView()
                    let imageList = newsTopic!.image_list[index]
                    let urlLlist = imageList.url_list![index]
                    let urlString = urlLlist["url"] as! String
                    if urlString.hasSuffix(".webp") {
                        let range =  urlString.range(of: ".webp")
                        
                        let url = urlString.substring(to: (range?.lowerBound)!)
                        imageView.kf.setImage(with:URL(string: url)!)
                    } else {
                        imageView.kf.setImage(with:URL(string: urlString))
                    }
                    let x: CGFloat = CGFloat(index) * (newsTopic!.imageW + 6)
                    imageView.frame = CGRect(x:x,y:0,width:newsTopic!.imageW,height: newsTopic!.imageH)
                    imageView.backgroundColor = UIColor.lightGray
                    middleView.addSubview(imageView)
                }
            }
            
            if let label = newsTopic?.label {
                stickLabel.setTitle(" \(label) ", for: .normal)
                stickLabel.isHidden = false
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(middleView)
        print(self.subviews.count)
        middleView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.avatarImageView.snp.top).offset(-kMargin)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(kMargin)
            make.left.equalTo(self.titleLabel.snp.left)
            make.right.equalTo(self.titleLabel.snp.right)
        }
    }
    
    /// 中间 3 张图的容器
    private lazy var middleView: UIView = {
        let middleView = UIView()
        return middleView
    }()
    
    /// 举报按钮点击
    override func closeBtnClick() {
        closeButtonClosure?(filterWords!)
    }
    
    /// 举报按钮点击回调
    func closeButtonClick(closure:@escaping (_ filterWords: [YMFilterWord])->()) {
        closeButtonClosure = closure
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
