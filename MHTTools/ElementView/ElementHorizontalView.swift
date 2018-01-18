//
//  ElementHorizontalView.swift
//  MHTLabelPrinter
//
//  Created by Admin on 18/01/2018.
//  Copyright © 2018 MHT. All rights reserved.
//

import Foundation

class ElementHorizontalView: ElementView {
    var widthChangeButton: UIImageView?
    
    /**
     * 重写构造函数
     */
    override init(frame: CGRect) {
        self.widthChangeButton = UIImageView(frame: CGRect(x: frame.size.width - 15, y: frame.size.height / 2 - 15, width: 30, height: 30))
        self.widthChangeButton?.image = UIImage(named: "ModifierHorizontal")
        self.widthChangeButton?.isHidden = true
        
        super.init(frame: frame)
        self.addSubview(self.widthChangeButton!)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /**
     * 更新控件的选择状态
     */
    
    override func setIsSelected(isSelected: Bool) -> Void {
        super.setIsSelected(isSelected: isSelected)
        self.widthChangeButton?.isHidden = !isSelected
    }
}
