//
//  TemplateModel.swift
//  MHTLabelPrinter
//
//  Created by Admin on 16/01/2018.
//  Copyright © 2018 MHT. All rights reserved.
//

import Foundation

struct TemplateModel: Codable {
    var labelName: String!;
    
    var width: Float?;
    
    var height: Float?;
    
    var proportion: Float?;
    
    var concentration: Float?;
    
    var printingDirection: Float?;
    
    var mirror: Bool?;
    
    var tailDirection: Float?;
    
    var tailLength: Float?;
    
    //  一维码元素数组
    var qcControls: Array<TemplateQCModel>?;
    
    // 文本框控件数组
    var textControl: Array<TemplateTextModel>?;
    
    // 图片控件
    var bitmapControls: Array<TemplateImageModel>?;
    
    var fileName: String?;
    
    var labelViewBack: String?;
    
    /**
     * 初始化
     */
    init() {
        self.labelName = ""
        self.width = 48
        self.height = 30
    }
}
