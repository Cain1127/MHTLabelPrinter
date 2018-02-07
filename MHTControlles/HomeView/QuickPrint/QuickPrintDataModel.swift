
//
//  QuickPrintDataModel.swift
//  MHTLabelPrinter
//
//  Created by Admin on 06/02/2018.
//  Copyright © 2018 MHT. All rights reserved.
//

import UIKit

struct QuickPrintDataModel: Codable {
    var printStyle: Int? = 0
    
    var pageNumber: Int? = 1
    
    var fileNameArray: Array<String>? = []
}
