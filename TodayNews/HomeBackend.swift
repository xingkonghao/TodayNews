//
//  HomeBackend.swift
//  TodayNews
//
//  Created by 星空浩 on 2016/11/2.
//  Copyright © 2016年 DFYG_YF3. All rights reserved.
//

import UIKit
import SVProgressHUD
import SwiftyJSON
class HomeBackend: NSObject {
    ///首页标题
    func loadHomeTitlesData(success:@escaping (_ topTitles: [HomeTopTitle])->()){
        let url = BASE_URL + "article/category/get_subscribed/v1/?"
        let params = ["device_id": device_id ,
                      "aid": 13,
                      "iid": IID] as [String : Any]
        NetWorkManager.shareNetWorkManager.request_get(url: url, params: params as [String : AnyObject]) { (response) in
            guard response.result.isSuccess else{
                print(response.result.error)
            SVProgressHUD.showError(withStatus: "加载失败!")
                return
            }
            if let value = response.result.value{
                print(value)
                let json = JSON(value)
                let dataDict = json["data"].dictionary
                if let data = dataDict!["data"]?.arrayObject {
                    var topics = [HomeTopTitle]()
                    for dict in data{
                        let title = HomeTopTitle(dict: dict as! [String :AnyObject])
                        topics.append(title)
                    }
                    success(topics)
                }
            }
        }
    }
    /*某标题下的具体内容*/
    func loadCatogoryContent(category:String,success:@escaping (_ topics:[NewsItem])->()){
        let url = BASE_URL + "api/news/feed/v39/?"
        let params = ["device_id": device_id,
                      "category": category,
                      "iid": IID]
        NetWorkManager.shareNetWorkManager.request_get(url: url, params: params as [String : AnyObject]) { (response) in
            guard response.result.isSuccess else{
                print(response.result.error)
                SVProgressHUD.showError(withStatus: "加载失败!")
                return
            }
            if let value = response.result.value{
//                print(value)
                let json = JSON(value)
                let datas = json["data"].array
                var topics = [NewsItem]()
                for data in datas! {
                    let content = data["content"].stringValue
                    let contentData: NSData = content.data(using: String.Encoding.utf8)! as NSData
                    do {
                        let dict = try JSONSerialization.jsonObject(with: contentData as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                        print(dict)
                        let topic = NewsItem(dict: dict as! [String : AnyObject])
                        topics.append(topic)
                    } catch {
                        SVProgressHUD.showError(withStatus: "获取数据失败!")
                    }
                    
                }
                success(topics)
            }

        }
    }
}
