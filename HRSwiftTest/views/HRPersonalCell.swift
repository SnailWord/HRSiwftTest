//
//  HRPersonalCell.swift
//  HRSwiftTest
//
//  Created by ZhangHeng on 15/9/29.
//  Copyright © 2015年 ZhangHeng. All rights reserved.
//

import UIKit
import SnapKit

class HRPersonalCell: UITableViewCell {

    var label:UILabel!
    var content:UILabel!
    var avatorImage:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier:reuseIdentifier)
        self.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
        self.customCell()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func customCell(){
        label = UILabel.init()
        label.textColor = UIColor.blackColor()
        self.contentView.addSubview(label)
        label.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.contentView.snp_centerY)
            make.left.equalTo(self.contentView.snp_left).offset(15)
            make.width.greaterThanOrEqualTo(50)
            make.height.equalTo(15)
        }
        
        content = UILabel.init()
        content.textColor = UIColor.darkGrayColor()
        self.contentView.addSubview(content)
        content.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.contentView.snp_centerY)
            make.right.equalTo(self.contentView.snp_right).offset(-5)
            make.height.equalTo(15)
            make.width.greaterThanOrEqualTo(50)
        }
        
        avatorImage = UIImageView.init()
        avatorImage.layer.cornerRadius = 30
        avatorImage.clipsToBounds = true
        self.contentView.addSubview(avatorImage)
        avatorImage.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView.snp_top).offset(15)
            make.bottom.equalTo(self.contentView.snp_bottom).offset(-15)
            make.right.equalTo(self.contentView.snp_right)
            make.width.equalTo(avatorImage.snp_height)
        }
    }
}
