//
//  HRBaseModel.swift
//  HRSwiftTest
//
//  Created by ZhangHeng on 15/9/20.
//  Copyright © 2015年 ZhangHeng. All rights reserved.
//

import UIKit

class HRBaseModel: NSObject {
    init(dictionary:NSDictionary){
        super.init()
        for(key, value) in dictionary{
            self.setValue(value, forKeyPath: key as! String)
            //print(value,key)
        }
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        let className:NSString = NSStringFromClass(self.classForCoder)
        print("类",className,"未实现key",key,"的编写")
    }
}
