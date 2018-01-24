
//
//  TemplateRectModel.swift
//  MHTLabelPrinter
//
//  Created by Admin on 24/01/2018.
//  Copyright © 2018 MHT. All rights reserved.
//

import Foundation

struct TemplateRectModel: Codable {
    // 控件的宽度(单位 px)
    var W: Float?
    
    // 控件的高度(单位 px) contentRect:内容的坐标点，格式可参考注释一(单位 px) selectRect:选择框左边点，格式可参考注释一(单位 px)
    var H: Float?
    
    // 外层选择框坐标
    var selectRect: String?
    
    // 内容的坐标
    var contentRect: String?
    
    // 旋转角度
    var rotate: Int?
    
    // 旋转点的 x 坐标
    var rotate_x: Float?
    
    // 旋转点的 y 坐标
    var rotate_y: Float?
    
    // 线条宽度
    var linkWidth: Float?
}
