//
//  TemplateTextModel.swift
//  MHTLabelPrinter
//
//  Created by Admin on 16/01/2018.
//  Copyright © 2018 MHT. All rights reserved.
//

import Foundation

struct TemplateTextModel: Codable {
    // 控件的宽度(单位 px)
    var W: Float? = 96 * PROPORTION_LOCAL
    
    // 控件的高度(单位 px) contentRect:内容的坐标点，格式可参考注释一(单位 px) selectRect:选择框左边点，格式可参考注释一(单位 px)
    var H: Float? = 30 * PROPORTION_LOCAL
    
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
    
    // 文字大小。单位 px
    var TEXT_SIZE: Float? = 12 * PROPORTION_LOCAL
    
    // 行距。单位 px
    var SPACING: Float? = 1.0
    
    // 字间距。单位 px
    var WORD_SPACE: Float? = 0.01
    
    // 内容
    var text: String? = "请输入内容"
}
