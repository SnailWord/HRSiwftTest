//
//  HRTalkItem.swift
//  HRSwiftTest
//
//  Created by ZhangHeng on 15/10/8.
//  Copyright © 2015年 ZhangHeng. All rights reserved.
//

import UIKit

class HRTalkItem: HRBaseModel {
    var currentPage:NSNumber?
    var detailMovement:NSMutableArray?
    var endTime:NSString?
    var getStatus:NSString?
    var girlid:NSNumber?
    var id:NSNumber?
    var logo:NSString?
    var nickname:NSString?
    var num:NSNumber?
    var personNum:NSNumber?
    var ranking:NSNumber?
    var startTime:NSString?
    var statusUrl:NSString?
    var statusid:NSNumber?
    var talkUrl:NSString?
    var talkcontent:NSString?
    var talkid:NSNumber?
    var type:NSNumber?
    
    override init(dictionary:NSDictionary) {
        super.init(dictionary: dictionary)
        self.configExtraValue(dictionary)
    }
    
    func configExtraValue(extraDic:NSDictionary){
        if((extraDic.objectForKey("detailMovement")?.isKindOfClass(NSArray.classForCoder())) != nil){
            let arrays:NSMutableArray = NSMutableArray.init(array: []) as NSMutableArray
            for itemDic in (extraDic.objectForKey("detailMovement") as! NSArray){
                let item:HRTalkItemDetail = HRTalkItemDetail.init(dictionary: itemDic as! NSDictionary)
                arrays.addObject(item)
            }
            self.detailMovement = arrays
        }
    }
}


/*
currentPage = 0;
detailMovement =         (
{
girlid = 12776;
logo = "http://img2.moko.cc/users/0/0/0/pics/img2_src_10239595.jpg";
nickname = "\U9a6c\U539f";
statusUrl = "http://img.mei.moko.cc/2015-07-03/e420b57b-66b7-4a8c-9d3e-f9675b3c3b69.png";
statusid = 1011000764;
text = "#\U6d4b\U8bd5\U6807\U98980#\U00a5\Uff1b\U89c9\U5f97\U57fa\U7763\U6559";
},
);
endTime = "<null>";
getStatus = "<null>";
girlid = 0;
id = 3;
logo = "<null>";
nickname = "<null>";
num = 3;
personNum = 16;
ranking = 0;
startTime = "<null>";
statusUrl = "<null>";
statusid = 0;
talkUrl = "http://img.mei.moko.cc/2015-07-24/6d6476e9-d4cd-4214-8835-f0085cafa87a.jpg?imageView2/1/w/640/h/684";
talkcontent = "\U6d4b\U8bd5\U6807\U98980";
talkid = 10;
type = 1;
*/