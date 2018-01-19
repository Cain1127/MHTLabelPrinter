//
//  ElementView.swift
//  MHTLabelPrinter
//
//  Created by Admin on 18/01/2018.
//  Copyright © 2018 MHT. All rights reserved.
//

import UIKit

class ElementView: UIView {    
    var isSelected: Bool = false
    var isLock: Bool = false
    
    /**
     * 重写构造函数
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    /**
     * 更新控件的选择状态
     */
    
    func setIsSelected(isSelected: Bool) -> Void {
        self.isSelected = isSelected
        if(isSelected) {
            self.layer.borderColor = UIColor.black.cgColor
            self.layer.borderWidth = 0.5
        } else {
            self.layer.borderColor = UIColor.white.cgColor
            self.layer.borderWidth = 0
        }
    }
    
    func getIsSelected() -> Bool {
        return self.isSelected
    }
}
