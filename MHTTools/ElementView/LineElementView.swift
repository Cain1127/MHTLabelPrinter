//
//  LineElementView.swift
//  MHTLabelPrinter
//
//  Created by Admin on 23/01/2018.
//  Copyright © 2018 MHT. All rights reserved.
//

import UIKit

class LineElementView: ElementVerticalView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}
