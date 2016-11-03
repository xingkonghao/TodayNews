//
//  HomeNoImageCell.swift
//  TodayNews
//
//  Created by 星空浩 on 2016/11/3.
//  Copyright © 2016年 DFYG_YF3. All rights reserved.
//

import UIKit

class HomeNoImageCell: HomeTopicCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var newsTopic:NewsItem?{
        didSet{
            titleLabel.text = String(describing: newsTopic!.title)
            if let publishTime = newsTopic?.publish_time {
                titleLabel.text = NSString.changeDateTime(publish_time: publishTime)
            }
            if let sourceAvatar = newsTopic?.source_avatar {
                nameLabel.text = newsTopic?.source
                avatarImageView.setCircleHeader(url: sourceAvatar)
            }
            if let mediaInfo = newsTopic!.media_info{
                nameLabel.text = mediaInfo.name
                avatarImageView.setCircleHeader(url: mediaInfo.avatar_url!)
            }
            
            if let commentCount = newsTopic!.comment_count {
                commentCount >= 1000 ? (commentLabel.text = "\(commentCount / 10000)万评论") : (commentLabel.text = "\(commentCount)评论")
            }else {
                commentLabel.isHidden = true
            }
            filterWords = newsTopic?.filter_words
            if let label = newsTopic?.label{
                stickLabel.setTitle("\(label)", for: .normal)
                stickLabel.isHidden = false
                closeButton.isHidden = false
                if label == "置顶" {
                    closeButton.isHidden = true
                }
            }
        }
    }
    override init(style:UITableViewCellStyle,reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// 举报按钮点击
    override func closeBtnClick() {
        closeButtonClosure?(filterWords!)
    }
    
    /// 举报按钮点击回调
    func closeButtonClick(closure:@escaping (_ filterWord: [YMFilterWord])->()) {
        closeButtonClosure = closure
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
