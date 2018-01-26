//
//  TemplateTextLable.swift
//  MHTLabelPrinter
//
//  Created by Admin on 25/01/2018.
//  Copyright © 2018 MHT. All rights reserved.
//

import UIKit

class TemplateTextLable: UILabel {
    var wordSpace = CGFloat(0)
    
    var lineSpace = CGFloat(0)
    
    // 文字区域
//    override func drawText(in rect: CGRect) {
//        super.drawText(in: rect)
//        super.drawText(in: UIEdgeInsetsInsetRect(rect, UIEdgeInsets.init(top: 0, left: padding, bottom: 0, right: padding)))
//    }
    
    // UILabel的内容区域
//    override func textRect(forBounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
//        let insets = UIEdgeInsets.init(top: 0, left: padding, bottom: 0, right: padding)
//        var rect = super.textRect(forBounds: UIEdgeInsetsInsetRect(bounds, insets), limitedToNumberOfLines: numberOfLines)
//        rect.origin.x -= insets.left
//        rect.origin.y -= insets.top
//        rect.size.width += (insets.left + insets.right)
//        rect.size.height += (insets.top + insets.bottom)
//        var rect = super.textRect(forBounds: forBounds, limitedToNumberOfLines: numberOfLines)
//        return rect
//    }
}
