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
    var iconImage:UIImageView!
    var title:UILabel!
    var sign:UILabel!
    var line:UIView!
    
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
        iconImage = UIImageView.init()
        iconImage.contentMode = UIViewContentMode.ScaleAspectFill
        iconImage.clipsToBounds = true
        self.contentView.addSubview(iconImage)
        iconImage.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView.snp_top).offset(10)
            make.bottom.equalTo(self.contentView.snp_bottom).offset(-10)
            make.left.equalTo(self.contentView.snp_left).offset(10)
            make.width.equalTo(iconImage.snp_height)
            
        }
        title = UILabel.init()
        self.contentView.addSubview(title)
        title.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(iconImage.snp_right).offset(5)
            make.top.equalTo(iconImage.snp_top)
            make.right.equalTo(self.contentView.snp_right).offset(-5)
            make.height.equalTo(20)
        }
        
        sign = UILabel.init(frame: CGRectMake(iconImage.frame.size.width+20, 30, 100, 20))
        self.contentView.addSubview(sign)
        sign.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(iconImage.snp_bottom)
            make.left.equalTo(iconImage.snp_right).offset(5)
            make.right.equalTo(title.snp_right).offset(-5)
            make.height.equalTo(20)
        }
        
        line = UIView.init()
        line.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.5)
        self.contentView.addSubview(line)
        line.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.contentView.snp_bottom)
            make.left.equalTo(self.contentView.snp_left)
            make.right.equalTo(self.contentView.snp_right)
            make.height.equalTo(0.5)
        }
    }

}
