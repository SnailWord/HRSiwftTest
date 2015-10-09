//
//  MyTalkCollectionReusableView.swift
//  HRSwiftTest
//
//  Created by ZhangHeng on 15/10/8.
//  Copyright © 2015年 ZhangHeng. All rights reserved.
//

import UIKit

class MyTalkCollectionReusableView: UICollectionReusableView {
    var title:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        
        title = UILabel.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 40))
        self.addSubview(title)
        title.textAlignment = NSTextAlignment.Center
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
