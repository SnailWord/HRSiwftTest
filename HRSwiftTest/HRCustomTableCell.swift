//
//  HRCustomTableCell.swift
//  HRSwiftTest
//
//  Created by ZhangHeng on 15/9/11.
//  Copyright © 2015年 ZhangHeng. All rights reserved.
//

import UIKit
import SnapKit

class HRCustomTableCell: UITableViewCell {
    var bgImage:UIImageView!
    var iconImage:UIImageView!
    var title:UILabel!
    var sign:UILabel!
    //var line:UIView!
    var imageOffset:CGPoint?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.customCell()
    }
    
    func customCell(){
        self.clipsToBounds = true
        self.contentView.clipsToBounds = true
        
        bgImage = UIImageView.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 258))
        bgImage.contentMode = UIViewContentMode.ScaleAspectFill
        bgImage.clipsToBounds = true
        self.contentView.addSubview(bgImage)
        
        
        iconImage = UIImageView.init()
        iconImage.contentMode = UIViewContentMode.ScaleAspectFill
        iconImage.clipsToBounds = true
        iconImage.layer.cornerRadius = 30
        self.contentView.addSubview(iconImage)
        iconImage.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.contentView.snp_centerX)
            make.bottom.equalTo(self.contentView.snp_bottom).offset(-20)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        title = UILabel.init()
        title.textColor = UIColor.whiteColor()
        self.contentView.addSubview(title)
        title.textAlignment = NSTextAlignment.Center
        title.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.contentView.snp_left)
            make.right.equalTo(self.contentView.snp_right)
            make.bottom.equalTo(iconImage.snp_top).offset(-30)
            make.height.equalTo(20)
        }
        
        sign = UILabel.init()
        sign.textColor = UIColor.whiteColor()
        sign.font = UIFont.systemFontOfSize(12)
        sign.textAlignment = NSTextAlignment.Center
        self.contentView.addSubview(sign)
        sign.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(title.snp_bottom)
            make.left.equalTo(title.snp_left)
            make.right.equalTo(title.snp_right)
            make.height.equalTo(15)
        }
    }
}
