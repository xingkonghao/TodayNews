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
import MJRefresh

class HomeBackend: NSObject {
    
    /// 有多少条文章更新
    func loadArticleRefreshTip(finished:@escaping (_ count: Int)->()) {
        let url = BASE_URL + "2/article/v39/refresh_tip/"
        
        NetWorkManager.shareNetWorkManager.request_getWithNoParams(url: url)  { (response) in
            
            guard response.result.isSuccess else {
                SVProgressHUD.showError(withStatus: "加载失败...")
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                let data = json["data"].dictionary
                let count = data!["count"]!.int
                finished(count!)
                
            }
        }
    }
    ///首页标题
    func loadHomeTitlesData(success:@escaping (_ topTitles: [HomeTopTitle])->()){
        let url = BASE_URL + "article/category/get_subscribed/v1/?"
        let params = ["device_id": device_id ,
                      "aid": 13,
                      "iid": IID,] as [String : Any]
        var titles:[HomeTopTitle] = NetWorkCache().unarchiveNetData(fileName: url + String(describing: params["aid"]), obj: [HomeTopTitle]() as AnyObject) as! [HomeTopTitle]
        if titles.count > 0 {
            success(titles)
            return
        }
        
        NetWorkManager.shareNetWorkManager.request_get(url: url, params: params as [String : AnyObject]) { (response) in
            guard response.result.isSuccess else{
                SVProgressHUD.showError(withStatus: "加载失败!")
                return
            }
            if let value = response.result.value{
                print(value)
                let json = JSON(value)
                let dataDict = json["data"].dictionary
                if let data = dataDict!["data"]?.arrayObject {
                    for dict in data{
                        let title = HomeTopTitle(dict: dict as! [String :AnyObject])
                        titles.append(title)
                    }
                    NetWorkCache().archiveNetData(filelName: url + String(describing: params["aid"]) , obj: titles)
                    
                    success(titles)
                }
            }
        }
    }
    /*某标题下的具体内容*/
    func loadCatogoryContent(tableView:UITableView,category:String,success:@escaping (_ nowTime:TimeInterval , _ topics:[NewsItem])->()){
        let url = BASE_URL + "api/news/feed/v45/?"
        let nowTime = NSDate().timeIntervalSince1970
        let params = ["device_id": device_id,
                      "category": category,
                      "iid": IID, "last_refresh_sub_entrance_interval": 0] as [String : Any]
        var topics:[NewsItem] = [NewsItem]()
        var cacheData = NetWorkCache().getFileFromDisk(fileName: url + category)
//        if cacheData != nil {
//            cacheData = cacheData! as Data
//            do {
//                let data:[String:Any] = try JSONSerialization.jsonObject(with: cacheData!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : Any]
//                if let dics:[AnyObject] = data["data"] as! [AnyObject]? {
//                    for dict in dics {
//                        let content:String = dict["content"] as! String
//                        let contentData: Data = content.data(using: String.Encoding.utf8)! as Data
//                        let dict = try JSONSerialization.jsonObject(with: contentData as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
//                                                print(dict)
//                        let topic = NewsItem(dict: dict as! [String : AnyObject])
//                        topics.append(topic)
//                    }
//                    
//                }
//                
//                success(noewTime,topics)
//                return
//            }catch{
//                
//            }
//        }
        
            NetWorkManager.shareNetWorkManager.request_get(url: url, params: params as [String : AnyObject]) { (response) in
                tableView.mj_header.endRefreshing()
                guard response.result.isSuccess else{
                    SVProgressHUD.showError(withStatus: "加载失败!")
                    return
                }
                if let value = response.result.value{
//                    print(value)
                    let json = JSON(value)
                    let headerEntrance = json["sub_entrance_list"].array
                    if headerEntrance != nil{
                        for data in headerEntrance! {
                            print(data)
                        }
                    }
                  
                    let datas = json["data"].array
                    for data in datas! {
                        let content = data["content"].stringValue
                        let contentData: Data = content.data(using: String.Encoding.utf8)! as Data
                        do {
                            let dict = try JSONSerialization.jsonObject(with: contentData as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                            //                        print(dict)
                            let topic = NewsItem(dict: dict as! [String : AnyObject])
                            topics.append(topic)
                        } catch {
                            SVProgressHUD.showError(withStatus: "获取数据失败!")
                        }
                    }
                    
                    NetWorkCache().fileWriteToDisk(data: response.data! , fileName: url + category)
                    
                    success(nowTime,topics)
                }
            }
        
    }
        /// 获取更多首页不同分类的新闻内容
        func loadHomeCategoryMoreNewsFeed(category: String, lastRefreshTime: TimeInterval, tableView: UITableView, finished:@escaping (_ moreTopics: [NewsItem])->()) {
            let url = BASE_URL + "api/news/feed/v39/?"
            let params = [
                          "category": category,
                          "device_id": device_id,
                           "iid": IID,
                          "last_refresh_sub_entrance_interval": lastRefreshTime] as [String : Any]
            NetWorkManager.shareNetWorkManager.request_get(url: url, params: params as [String : AnyObject]) { (response) in
                tableView.mj_footer.endRefreshing()
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "加载失败...")
                    return
                }
                if let value = response.result.value {
                    let json = JSON(value)
                    let datas = json["data"].array
                    var topics = [NewsItem]()
                    for data in datas! {
                        let content = data["content"].stringValue
                        let contentData: NSData = content.data(using: String.Encoding.utf8)! as NSData
                        do {
                            let dict = try JSONSerialization.jsonObject(with: contentData as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                            let topic = NewsItem(dict: dict as! [String : AnyObject])
                            topics.append(topic)
                        } catch {
                            SVProgressHUD.showError(withStatus: "获取数据失败!")
                        }
                    }
                    finished(topics)
                }
            }
            
        }
//    func requestStockData( url:String,_: ()->()){
//        <#function body#>
//    }
}
