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
    
    var width: Int!;
    
    var height: Int!;
    
    var proportion: Float!;
    
    var concentration: Int!;
    
    var printingDirection: Int!;
    
    var mirror: Bool!;
    
    var tailDirection: Int!;
    
    var tailLength: Int!;
    
    // 
    var qcControls: Array<TemplateQCModel>!;
    
    // 文本框控件数组
    var textControl: Array<TemplateTextModel>!;
    
    // 图片控件
    var bitmapControls: Array<TemplateImageModel>!;
    
    var fileName: String!;
    
    var labelViewBack: String!;
}
