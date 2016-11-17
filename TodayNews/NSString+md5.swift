//
//  NSString+md5.swift
//  
//
//  Created by 星空浩 on 2016/11/11.
//
//

import Foundation
import UIKit
extension String{
    func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize()
        
        return String(format: hash as String)
    }
    func calculationStringSize(text:String,size:CGSize)->CGSize{
        var rect:CGRect
        rect = text.boundingRect(with: size, options: NSStringDrawingOptions.usesFontLeading, attributes: nil, context: nil);
        return rect.size
    }
}
