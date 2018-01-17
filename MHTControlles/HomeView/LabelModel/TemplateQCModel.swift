//
//  TemplateQCModel.swift
//  MHTLabelPrinter
//
//  Created by Admin on 16/01/2018.
//  Copyright © 2018 MHT. All rights reserved.
//

import Foundation

struct TemplateQCModel: Codable {
    var W: Double!;
    
    var H: Double!;
    var contentRect: String!;
    
    var selectRect: String!;
    
    var rotate: Int!;
    
    var rotate_x: Double!;
    
    var rotate_y: Double!;
    
    var text: String!;
    
    var ERROR_LEVEL: Int!;
    
    var WORD_SPACE: Double!;
    
    var DRAW_TEXT_POSITION: Int;
    
    var TEXT_STATE: Int!;
    
    var TEXT_SIZE: Int;
}
