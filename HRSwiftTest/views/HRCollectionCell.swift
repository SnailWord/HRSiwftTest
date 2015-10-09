//
//  HRCollectionCell.swift
//  HRSwiftTest
//
//  Created by ZhangHeng on 15/9/22.
//  Copyright © 2015年 ZhangHeng. All rights reserved.
//

import UIKit

class HRCollectionCell: UICollectionViewCell {
    var avator:UIImageView!
    var title:UILabel!
    var bigBkg:UIImageView!
    var userName:UILabel!
    var gradient:HRGradientView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        self.customMyCell()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func customMyCell(){
        bigBkg = UIImageView.init()
        bigBkg.contentMode = UIViewContentMode.ScaleAspectFill
        bigBkg.clipsToBounds = true
        self.contentView.addSubview(bigBkg!)
        bigBkg.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView.snp_top)
            make.left.equalTo(self.contentView.snp_left)
            make.right.equalTo(self.contentView.snp_right)
            make.bottom.equalTo(self.contentView.snp_bottom).offset(-35)
        }
        
        gradient = HRGradientView.init()
        self.contentView.addSubview(gradient)
        gradient.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.contentView.snp_left)
            make.right.equalTo(self.contentView.snp_right)
            make.bottom.equalTo(self.contentView.snp_bottom).offset(-30)
            make.height.equalTo(40)
        }
        
        avator = UIImageView.init()
        avator.backgroundColor = UIColor.greenColor()
        avator.layer.cornerRadius = 30
        avator.contentMode = UIViewContentMode.ScaleAspectFill
        avator.clipsToBounds = true
        avator.layer.borderColor = UIColor.redColor().CGColor
        avator.layer.borderWidth = 1
        self.contentView.addSubview(avator)
        avator.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.contentView.snp_left).offset(10)
            make.bottom.equalTo(self.contentView.snp_bottom).offset(-10)
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
        
        userName = UILabel.init()
        userName.textColor = UIColor.whiteColor()
        userName.font = UIFont.systemFontOfSize(12)
        self.contentView.addSubview(userName)
        userName.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(avator.snp_right).offset(10)
            make.right.equalTo(self.contentView.snp_right)
            make.bottom.equalTo(avator.snp_centerY).offset(-5)
            make.height.equalTo(12)
        }
        
        title = UILabel.init()
        title.textColor = UIColor.blackColor()
        title.font = UIFont.systemFontOfSize(14)
        self.contentView.addSubview(title)
        title.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(avator.snp_right).offset(10)
            make.top.equalTo(avator.snp_centerY).offset(15)
            make.right.equalTo(self.contentView.snp_right).offset(-5)
            make.height.equalTo(15)
        }
    }
}
