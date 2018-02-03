
//
//  RectElementView.swift
//  MHTLabelPrinter
//
//  Created by Admin on 23/01/2018.
//  Copyright © 2018 MHT. All rights reserved.
//

import UIKit

class RectElementView: ElementVerticalView {
    override init(frame: CGRect, pro: Float = PROPORTION_LOCAL) {
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

extension RectElementView {
    // 根据数据模型刷新UI
    func updateUIWithModel(model: TemplateRectModel = TemplateRectModel(), pro: Float = PROPORTION_LOCAL) -> Void {
        self.frame.size.width = CGFloat(model.W! / pro)
        self.frame.size.height = CGFloat(model.H! / pro)
        self.layer.borderWidth = CGFloat(model.linkWidth! / pro)
        self.pro = pro
    }
}
