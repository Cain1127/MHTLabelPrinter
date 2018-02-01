//
//  LineElementView.swift
//  MHTLabelPrinter
//
//  Created by Admin on 23/01/2018.
//  Copyright © 2018 MHT. All rights reserved.
//

import UIKit

class LineElementView: ElementVerticalView {
    override init(frame: CGRect, pro: Float = PROPORTION_LOCAL) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension LineElementView {
    // 根据数据模型刷新UI
    func updateUIWithModel(model: TemplateLineControlModel = TemplateLineControlModel(), pro: Float = PROPORTION_LOCAL) -> Void {
        self.frame.size.width = CGFloat(model.W! / self.pro / pro)
        self.frame.size.height = CGFloat(model.H! / self.pro / pro)
        self.pro = self.pro / pro
    }
}
