//
//  HomeTopTitle.swift
//  TodayNews
//
//  Created by 星空浩 on 2016/10/27.
//  Copyright © 2016年 hrscy. All rights reserved.
//

//import UIKit

import Foundation


class HomeTopTitle: NSObject ,NSCoding{

    var category: String?
    var web_url :String?
    var concern_id :String?
    var icon_url: String?
    var name: String?
    var isSelected: Bool = true
    init(dict:[String:AnyObject]) {
        super.init()
        category = dict["category"] as? String
        web_url = dict["web_url"] as? String
        concern_id = dict["concern_id"] as? String
        icon_url = dict["icon_url"] as? String
        name = dict["name"] as? String
    }
    required init?(coder aDecoder: NSCoder){
        super.init()
        category = aDecoder.decodeObject(forKey: "category") as? String
        web_url = aDecoder.decodeObject(forKey: "web_url") as? String
        concern_id = aDecoder.decodeObject(forKey: "concern_id") as? String
        icon_url = aDecoder.decodeObject(forKey: "icon_url") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        isSelected = aDecoder.decodeBool(forKey: "isSelected")

    }
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(category, forKey: "category")
        aCoder.encode(web_url, forKey: "web_url")
        aCoder.encode(concern_id, forKey: "concern_id")
        aCoder.encode(icon_url, forKey: "icon_url")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(isSelected, forKey: "isSelected")
    }

}
