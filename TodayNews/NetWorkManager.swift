//
//  NetWorkManager.swift
//  TodayNews
//
//  Created by 星空浩 on 2016/11/2.
//  Copyright © 2016年 DFYG_YF3. All rights reserved.
//

import UIKit
import Alamofire
class NetWorkManager: NSObject {
    //单例
    static let shareNetWorkManager = NetWorkManager()
    ///GET
    func request_get(url: String,params:[String : AnyObject],finished:@escaping (_ response:DataResponse<Any>)->()) {
    
        Alamofire.request(url, method: .get, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else{
                print(response.result.error ?? "请求失败")
                
                return
            }
            finished(response)
        }
    }
    func request_getWithNoParams(url: String,finished:@escaping (_ response:DataResponse<Any>)->()) {
        
        Alamofire.request(url, method: .get).responseJSON { (response) in
            guard response.result.isSuccess else{
                print(response.result.error ?? "请求失败")
                return
            }
            finished(response)
        }
    }
    //Post
    func request_post(url:String,params:[String : AnyObject],finished:@escaping (_ response:DataResponse<Any>)->())  {
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { (response) in
            finished(response)
        }
    }
   
}
