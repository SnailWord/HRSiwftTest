//
//  HRBaseModel.swift
//  HRSwiftTest
//
//  Created by ZhangHeng on 15/9/20.
//  Copyright © 2015年 ZhangHeng. All rights reserved.
//

import UIKit

class HRBaseModel: NSObject {
    internal convenience init(_ dictionary: Dictionary<String, AnyObject>) {
        self.init()
        for(key, value) in dictionary{
            self.setValue(value, forKeyPath: key)
            //print(value,key)
        }
        
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        print("未实现key",key,"的编写")
    }
}
