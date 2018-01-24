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
    var oriWidth = CGFloat(0)
    var oriHeight = CGFloat(0)
    
    /**
     * 重写构造函数
     */
    override init(frame: CGRect) {
        self.oriWidth = frame.width
        self.oriHeight = frame.height
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
    
    // 回收键盘
    func resignKeyboardAction() -> Void {
        
    }
}

extension ElementView {
    // 高度变化处理事件
    @objc func heightChangeAction(translation: CGPoint, status: UIGestureRecognizerState) -> Void {
        if(translation.y > 0) {
            // 向下滑动
            self.frame.size.height = self.oriHeight + translation.y
        } else {
            // 向上滑动
            let height = self.oriHeight + translation.y
            if(5 >= height) {
                return
            }
            
            self.frame.size.height = height
        }
        
        // 结束后保存尺寸
        if(status == .ended) {
            var height = self.oriHeight + translation.y
            height = height >= 5 ? height : 5
            self.oriHeight = height
        }
    }
    
    // 宽度变化处理事件
    @objc func widthChangeAction(translation: CGPoint, status: UIGestureRecognizerState) -> Void {
        if(translation.x > 0) {
            // 向右滑动
            self.frame.size.width = CGFloat(self.oriWidth + translation.x)
        } else {
            // 向左滑动
            let width = self.oriWidth + translation.x
            if(5 >= width) {
                return
            }
            
            self.frame.size.width = width
        }
        
        // 结束后保存尺寸
        if(status == .ended) {
            var width = self.oriWidth + translation.x
            width = width >= 5 ? width : 5
            self.oriWidth = width
        }
    }
    
    // 上下滑动事件
    @objc func heightPanAction(gesture: UIPanGestureRecognizer) -> Void {
        let translation = gesture.translation(in: gesture.view!)
        self.heightChangeAction(translation: translation, status: gesture.state)
    }
    
    // 左右滑动事件
    @objc func widthPanAction(gesture: UIPanGestureRecognizer) -> Void {
        let translation = gesture.translation(in: gesture.view!)
        self.widthChangeAction(translation: translation, status: gesture.state)
    }
}
