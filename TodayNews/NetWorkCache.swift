//
//  NetWorkCache.swift
//  TodayNews
//
//  Created by 星空浩 on 2016/11/10.
//  Copyright © 2016年 DFYG_YF3. All rights reserved.
//
enum archiveError:Error{
    case fileNotExist
    case fileOutTime
}
import UIKit

class NetWorkCache: NSObject {
    
    var outTime:TimeInterval = 100
    func archiveNetData(filelName:String,obj:Any){
        let saveDate:TimeInterval = NSDate().timeIntervalSince1970

        let md5Name = filelName.md5()
        
        let filePath = self.fileCachePath.appending("/" + md5Name)
        
        let saveData = ["date":saveDate,"data":obj]
        
        NSKeyedArchiver.archiveRootObject(saveData, toFile: filePath)
    }
    func unarchiveNetData(fileName:String,  obj:AnyObject) ->AnyObject{
        var obj = obj

        let md5Name = fileName.md5()
        let filePath = self.fileCachePath.appending("/" + md5Name)
        guard FileManager.default.fileExists(atPath: filePath) else {
            return obj
        }
        
        let saveData:[String:AnyObject] = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as! [String:AnyObject]
        let nowtime:TimeInterval = NSDate().timeIntervalSince1970
        let saveDate:TimeInterval = saveData["date"] as!TimeInterval

        guard nowtime - saveDate < outTime else {
            return obj
        }
        
        obj =  saveData["data"]!
        return obj
//        do {
//            try fileExist(filePath: filePath)
//            let saveData:[String:AnyObject] = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as! [String:AnyObject]
//            let nowtime:TimeInterval = NSDate().timeIntervalSince1970
//            let saveDate:TimeInterval = saveData["date"] as!TimeInterval
//            if nowtime - saveDate > outTime {
//                
//            }
//             obj = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as AnyObject
//            
//        }catch{
//            
//        }
//        return obj
    }
//    func fileExist(filePath:String)throws {
//        guard FileManager.default.fileExists(atPath: filePath) else {
//            throw archiveError.fileNotExist
//        }
//        
//    }
    
    
    
    
    
    func fileWriteToDisk(data:Data,fileName:String){
        
        let fileManager:FileManager = FileManager.default
        let filePath:String = self.fileCachePath + "/" + fileName.md5() + ".txt"
        if !fileManager.createFile(atPath: filePath, contents: data, attributes: nil) {
            print("缓存失败")
        }
    }
    
    
    func getFileFromDisk(fileName:String)->Data?{
        
        let fileManager:FileManager = FileManager.default
        let filePath:String = self.fileCachePath + "/" + fileName.md5() + ".txt"
        if fileManager.fileExists(atPath: filePath){
            do{
                let url = URL(fileURLWithPath: filePath)
                let cacheData = try Data(contentsOf: url)
                return cacheData
            }catch{
                
            }
        }
        return nil
    }
    private lazy var fileCachePath:String = {
        let fileCachePath:String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first! as String
        return fileCachePath
    }()
    private lazy var doucumentPath:String = {
        let doucumentPath:String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first! as String
        return doucumentPath

    }()
}
            
