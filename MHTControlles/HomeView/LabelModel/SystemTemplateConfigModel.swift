//
//  SystemTemplateConfigModel.swift
//  MHTLabelPrinter
//
//  Created by Admin on 18/01/2018.
//  Copyright © 2018 MHT. All rights reserved.
//

import Foundation

struct SystemTemplateConfigModel: Codable {
    // 分组的名字
    var name: String!
    
    // 分组对应的文件名数组
    var fileNameArray: Array<String>!
    
    var dataSource: Array<TemplateModel>?
}
