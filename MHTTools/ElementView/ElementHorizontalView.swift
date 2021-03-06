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
    
    // 定义一个放大时的闭包，主要是当前控件变宽时，外部有可能联动变宽其他控件，比如编辑窗口为多选时
    var widthChangeClosure: ((_ view: ElementView, _ translation: CGPoint, _ status: UIGestureRecognizerState) -> Void)?
    
    /**
     * 重写构造函数
     */
    override init(frame: CGRect, pro: Float = PROPORTION_LOCAL) {
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
    override func widthChangeAction(translation: CGPoint, status: UIGestureRecognizerState) {
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
        super.widthChangeAction(translation: translation, status: status)
    }
    
    override func widthPanAction(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: gesture.view!)
        // 回调宽度改变
        if((self.widthChangeClosure) != nil) {
            self.widthChangeClosure!(self, translation, gesture.state)
        }
        self.widthChangeAction(translation: translation, status: gesture.state)
    }
    
    // 根据新的比率，刷新frame
    override func resetFrameWithPro(pro: Float) {
        self.widthChangeButton?.frame.origin.x = (self.widthChangeButton?.frame.origin.x)! / CGFloat(self.pro / pro)
        self.widthChangeButton?.frame.origin.y = (self.widthChangeButton?.frame.origin.y)! / CGFloat(self.pro / pro)
        super.resetFrameWithPro(pro: pro)
    }
}
