//
//  ElementVerticalView.swift
//  MHTLabelPrinter
//
//  Created by Admin on 18/01/2018.
//  Copyright © 2018 MHT. All rights reserved.
//

import Foundation

class ElementVerticalView: ElementHorizontalView {
    var heightChangeButton: UIImageView?
    
    /**
     * 重写构造函数
     */
    override init(frame: CGRect) {
        self.heightChangeButton = UIImageView(frame: CGRect(x: frame.size.width / 2 - 15, y: frame.size.height - 15, width: 30, height: 30))
        self.heightChangeButton?.image = UIImage(named: "modifierVertical")
        self.heightChangeButton?.isHidden = true
        
        super.init(frame: frame)
        self.addSubview(self.heightChangeButton!)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /**
     * 重写选择状态事件
     */
    override func setIsSelected(isSelected: Bool) -> Void {
        super.setIsSelected(isSelected: isSelected)
        self.heightChangeButton?.isHidden = !isSelected
    }
}
