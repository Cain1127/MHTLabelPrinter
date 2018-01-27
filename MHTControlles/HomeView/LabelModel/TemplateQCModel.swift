//
//  TemplateQCModel.swift
//  MHTLabelPrinter
//
//  Created by Admin on 16/01/2018.
//  Copyright © 2018 MHT. All rights reserved.
//

import Foundation

struct TemplateQCModel: Codable {
    // 控件的宽度(单位 px)
    var W: Float? = 160 * PROPORTION_LOCAL
    
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
    
    // 文字位置的上，下与不显示。 解释:BUTTON = 1, TOP = 2, NO_TEXT = 3;
    var DRAW_TEXT_POSITION: Int?
    
    // 纠错水平。
    // 解释:MINIMUM(低) = 0, MEDIUM(中) = 1, HEIGHT(高) = 2, STRONG(强) = 3;
    // 注:这个属性不给用户调节，默认为 STRONG
    var ERROR_LEVEL: Int?
    
    // 文字大小。单位 px
    var TEXT_SIZE: Float? = 12 * PROPORTION_LOCAL
    
//    文字状态。
//    解释:TEXT_LEFT(靠左显示) = 3, TEXT_RIGHT(靠右显示) = 4, TEXT_STRETCHING(拉伸显示) = 5, TEXT_CENTER(居中显示) = 6;
//    注:拉伸显示 Android 未实现
    var TEXT_STATE: Int?
    
    // 字间距。单位 px
    var WORD_SPACE: Float? = 0.01
    
    // 文本内容
    var text: String? = "双击编辑"
}
