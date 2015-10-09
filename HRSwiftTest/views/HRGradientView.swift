//
//  HRGradientView.swift
//  HRSwiftTest
//
//  Created by ZhangHeng on 15/10/9.
//  Copyright © 2015年 ZhangHeng. All rights reserved.
//

import UIKit
import QuartzCore

class HRGradientView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func layoutSubviews() {
        let rect : CGRect = self.frame
        let vista : UIView = UIView.init(frame: rect)
        let gradient : CAGradientLayer = CAGradientLayer()
        gradient.frame = vista.bounds
        
        let cor1 = UIColor.blackColor().colorWithAlphaComponent(0.2).CGColor
        let cor2 = UIColor.whiteColor().colorWithAlphaComponent(0.1).CGColor
        let arrayColors = [cor1, cor2]
        
        gradient.colors = arrayColors
        self.layer.addSublayer(gradient)
    }

}
