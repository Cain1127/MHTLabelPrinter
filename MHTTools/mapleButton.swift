//
//  mapleButton.swift
//  MHTLabelPrinter
//
//  Created by 程骋 on 2018/1/7.
//  Copyright © 2018年 MHT. All rights reserved.
//

import UIKit
enum mapleCBtnType:String {
    case CustomButtonImageTop
    case CustomButtonImageLeft
    case CustomButtonImageBottom
    case CustomButtonImageRight
    }
class mapleButton: UIButton {
    var intervalSpace:CGFloat = 0.0
//    var mapleBtnType = mapleCBtnType(rawValue: <#String#>)

    var typeNum = 1
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageWith: CGFloat? = imageView?.frame.size.width
        let imageHeight: CGFloat? = imageView?.frame.size.height
        var labelWidth: CGFloat = 0.0
        var labelHeight: CGFloat = 0.0
        if Float(UIDevice.current.systemVersion) ?? 0.0 >= 8.0 {
            labelWidth = (titleLabel?.intrinsicContentSize.width)!
            labelHeight = (titleLabel?.intrinsicContentSize.height)!
        }
        else {
            labelWidth = (titleLabel?.frame.size.width)!
            labelHeight = (titleLabel?.frame.size.height)!
        }
        var imageEdgeInsets = UIEdgeInsets.zero as? UIEdgeInsets
        var labelEdgeInsets = UIEdgeInsets.zero as? UIEdgeInsets
        switch (typeNum) {
        case 1: do {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight - self.intervalSpace , 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith!, -imageHeight! - self.intervalSpace , 0);
            }
        case 2: do {
            imageEdgeInsets = UIEdgeInsetsMake(0, -self.intervalSpace , 0, self.intervalSpace );
            labelEdgeInsets = UIEdgeInsetsMake(0, self.intervalSpace , 0, -self.intervalSpace );
            }
        case 3: do {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight - self.intervalSpace , -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight! - self.intervalSpace , -imageWith!, 0, 0);
            }
        case 4: do {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + self.intervalSpace , 0, -labelWidth - self.intervalSpace );
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith! - self.intervalSpace , 0, imageWith! + self.intervalSpace );
            }
        default:
            break;
        }
        
        
    }
    func interval() -> CGFloat {
        if intervalSpace == 0.0 {
            intervalSpace = 5
        }
        return intervalSpace
    }
    
}
