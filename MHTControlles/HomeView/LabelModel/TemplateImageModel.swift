//
//  TemplateImageModel.swift
//  MHTLabelPrinter
//
//  Created by Admin on 16/01/2018.
//  Copyright © 2018 MHT. All rights reserved.
//

import Foundation

struct TemplateImageModel: Codable {
    var W: Float!;
    
    var H: Float!;
    
    var contentRect: String!;
    
    var selectRect: String!;
    
    var rotate: Float!;
    
    var rotate_x: Float!;
    
    var rotate_y: Float!;
    
    var bitmap: String!;
}
