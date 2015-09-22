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
            make.edges.equalTo(self.contentView)
        }
        bigBkg.sd_setImageWithURL(NSURL.init(string: "http://pic74.nipic.com/file/20150803/21060976_140137957001_2.jpg"))
        
        avator = UIImageView.init()
        avator.backgroundColor = UIColor.greenColor()
        avator.layer.cornerRadius = 40
        avator.contentMode = UIViewContentMode.ScaleAspectFill
        avator.clipsToBounds = true
        avator.layer.borderColor = UIColor.yellowColor().CGColor
        avator.layer.borderWidth = 1
        self.contentView.addSubview(avator)
        avator.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.contentView.snp_left).offset(10)
            make.bottom.equalTo(self.contentView.snp_bottom).offset(-10)
            make.height.equalTo(80)
            make.width.equalTo(80)
        }
        avator.sd_setImageWithURL(NSURL.init(string: "http://pic74.nipic.com/file/20150803/21060976_140137957001_2.jpg"))
        
        title = UILabel.init()
        title.text = "标签测试"
        title.textColor = UIColor.whiteColor()
        self.contentView.addSubview(title)
        title.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(avator.snp_right).offset(10)
            make.top.equalTo(avator.snp_top)
            make.right.equalTo(self.contentView.snp_right).offset(-10)
            make.height.equalTo(20)
        }
    }
}
