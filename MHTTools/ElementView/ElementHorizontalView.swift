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
        self.widthChangeButton?.isUserInteractionEnabled = true
        
        super.init(frame: frame)
        self.addSubview(self.widthChangeButton!)
        self.addWidthChangePanAction()
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
    
    /**
     * 添加左右滑动事件
     */
    func addWidthChangePanAction() -> Void {
        let pan = UIPanGestureRecognizer(target:self, action:#selector(widthPanAction(gesture:)))
        pan.maximumNumberOfTouches = 1
        self.widthChangeButton?.addGestureRecognizer(pan)
    }
}

extension ElementHorizontalView {
    // 左右滑动事件
    override func widthPanAction(gesture: UIPanGestureRecognizer) -> Void {
        let translation = gesture.translation(in: gesture.view!)
        if(translation.x > 0) {
            // 向右滑动
            let widthButtonXPoint = (self.oriWidth - (self.widthChangeButton?.frame.width)! / 2) + translation.x
            self.widthChangeButton?.frame = CGRect(x: widthButtonXPoint,
                                                   y: (self.widthChangeButton?.frame.minY)!,
                                                   width: (self.widthChangeButton?.frame.width)!,
                                                   height: (self.widthChangeButton?.frame.height)!)
        } else {
            // 向左滑动
            let width = oriWidth + translation.x
            if(5 >= width) {
                return
            }

            let widthButtonXPoint = (self.oriWidth - (self.widthChangeButton?.frame.width)! / 2) + translation.x
            self.widthChangeButton?.frame = CGRect(x: widthButtonXPoint,
                                                   y: (self.widthChangeButton?.frame.minY)!,
                                                   width: (self.widthChangeButton?.frame.width)!,
                                                   height: (self.widthChangeButton?.frame.height)!)
        }
        super.widthPanAction(gesture: gesture)
    }
}
