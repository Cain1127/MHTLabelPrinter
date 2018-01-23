
//
//  RectElementView.swift
//  MHTLabelPrinter
//
//  Created by Admin on 23/01/2018.
//  Copyright © 2018 MHT. All rights reserved.
//

import UIKit

class RectElementView: ElementVerticalView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setIsSelected(isSelected: Bool) -> Void {
        self.isSelected = isSelected
        self.heightChangeButton?.isHidden = !isSelected
        self.widthChangeButton?.isHidden = !isSelected
    }
}