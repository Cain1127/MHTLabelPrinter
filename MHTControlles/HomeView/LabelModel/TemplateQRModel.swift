
//
//  TemplateQRModel.swift
//  MHTLabelPrinter
//
//  Created by Admin on 24/01/2018.
//  Copyright © 2018 MHT. All rights reserved.
//

import Foundation

struct TemplateQRModel: Codable {
    // 控件的宽度(单位 px)
    var W: Float? = 80 * PROPORTION_LOCAL
    
    // 控件的高度(单位 px) contentRect:内容的坐标点，格式可参考注释一(单位 px) selectRect:选择框左边点，格式可参考注释一(单位 px)
    var H: Float? = 80 * PROPORTION_LOCAL
    
    // 外层选择框坐标
    var selectRect: String?
    
    // 内容的坐标
    var contentRect: String?
    
    // 旋转角度
    var rotate: Int? = 0
    
    // 旋转点的 x 坐标
    var rotate_x: Float?
    
    // 旋转点的 y 坐标
    var rotate_y: Float?
    
//    纠错水平。MINIMUM(低) = 0, MEDIUM(中) = 1, HEIGHT(高) = 2, STRONG(强) = 3;
//    注:这个属性不给用户调节，默认为 STRONG
    var ERROR_LEVEL: Int?
    
    // 内容
    var text: String? = "双击编辑"
}
