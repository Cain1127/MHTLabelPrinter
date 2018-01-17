//
//  MHTBase.swift
//  MHTLabelPrinter
//
//  Created by 程骋 on 2017/12/27.
//  Copyright © 2017年 MHT. All rights reserved.
//

import UIKit

class MHTBase: NSObject {
    
    class func internationalStringWith(str:String) -> String {
        return NSLocalizedString(str, comment: str)
    }
    class func autoScreen() -> Float {
        switch SCREEN_width {
        case 320:
            return 0.85
        case 375:
            return 1.00
        case 414:
            return 1.15
        default:
            return 1.00
        }
    }
}
