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
    
    // 定义一个变高时的闭包，主要是当前控件变高时，外部有可能联动变高其他控件，比如编辑窗口为多选时
    var heightChangeClosure: ((_ view: ElementView, _ translation: CGPoint, _ status: UIGestureRecognizerState) -> Void)?
    
    /**
     * 重写构造函数
     */
    override init(frame: CGRect, pro: Float = PROPORTION_LOCAL) {
        self.heightChangeButton = UIImageView(frame: CGRect(x: frame.size.width / 2 - 15, y: frame.size.height - 15, width: 30, height: 30))
        self.heightChangeButton?.image = UIImage(named: "modifierVertical")
        self.heightChangeButton?.isHidden = true
        self.heightChangeButton?.isUserInteractionEnabled = true
        
        super.init(frame: frame)
        self.addSubview(self.heightChangeButton!)
        self.addHeightChangePanAction()
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
    
    /**
     * 添加上下滑动事件
     */
    func addHeightChangePanAction() -> Void {
        let pan = UIPanGestureRecognizer(target:self, action:#selector(heightPanAction(gesture:)))
        pan.maximumNumberOfTouches = 1
        self.heightChangeButton?.addGestureRecognizer(pan)
    }
}

extension ElementVerticalView {
    // 上下滑动事件
    override func heightChangeAction(translation: CGPoint, status: UIGestureRecognizerState) -> Void {
        if(translation.y > 0) {
            // 向下滑动
            let heightButtonYPoint = (self.oriHeight - (self.heightChangeButton?.frame.height)! / 2) + translation.y
            self.heightChangeButton?.frame = CGRect(x: (self.heightChangeButton?.frame.minX)!,
                                                   y: heightButtonYPoint,
                                                   width: (self.heightChangeButton?.frame.width)!,
                                                   height: (self.heightChangeButton?.frame.height)!)
            
            let widthButtonYPoint = (self.oriHeight + translation.y - (self.widthChangeButton?.frame.height)!) / 2
            self.widthChangeButton?.frame = CGRect(x: (self.widthChangeButton?.frame.minX)!,
                                                   y: widthButtonYPoint,
                                                   width: (self.widthChangeButton?.frame.width)!,
                                                   height: (self.widthChangeButton?.frame.height)!)
        } else {
            // 向上滑动
            let height = self.oriHeight + translation.y
            if(5 >= height) {
                return
            }
            
            let heightButtonYPoint = (self.oriHeight - (self.heightChangeButton?.frame.height)! / 2) + translation.y
            self.heightChangeButton?.frame = CGRect(x: (self.heightChangeButton?.frame.minX)!,
                                                   y: heightButtonYPoint,
                                                   width: (self.heightChangeButton?.frame.width)!,
                                                   height: (self.heightChangeButton?.frame.height)!)
            
            let widthButtonYPoint = (self.oriHeight + translation.y - (self.widthChangeButton?.frame.height)!) / 2
            self.widthChangeButton?.frame = CGRect(x: (self.widthChangeButton?.frame.minX)!,
                                                   y: widthButtonYPoint,
                                                   width: (self.widthChangeButton?.frame.width)!,
                                                   height: (self.widthChangeButton?.frame.height)!)
        }
        super.heightChangeAction(translation: translation, status: status)
    }
    
    override func widthChangeAction(translation: CGPoint, status: UIGestureRecognizerState) {
        if(translation.x > 0) {
            // 向右滑动
            let heightButtonXPoint = (self.oriWidth + translation.x - (self.heightChangeButton?.frame.width)!) / 2
            self.heightChangeButton?.frame = CGRect(x: heightButtonXPoint,
                                                   y: (self.heightChangeButton?.frame.minY)!,
                                                   width: (self.heightChangeButton?.frame.width)!,
                                                   height: (self.heightChangeButton?.frame.height)!)
        } else {
            // 向左滑动
            let width = oriWidth + translation.x
            if(5 >= width) {
                return
            }

            let heightButtonXPoint = (self.oriWidth + translation.x - (self.heightChangeButton?.frame.width)!) / 2
            self.heightChangeButton?.frame = CGRect(x: heightButtonXPoint,
                                                    y: (self.heightChangeButton?.frame.minY)!,
                                                    width: (self.heightChangeButton?.frame.width)!,
                                                    height: (self.heightChangeButton?.frame.height)!)
        }
        super.widthChangeAction(translation: translation, status: status)
    }
    
    // 上下滑动事件
    override func heightPanAction(gesture: UIPanGestureRecognizer) -> Void {
        let translation = gesture.translation(in: gesture.view!)
        // 回调高度改变
        if((self.heightChangeClosure) != nil) {
            self.heightChangeClosure!(self, translation, gesture.state)
        }
        self.heightChangeAction(translation: translation, status: gesture.state)
    }
    
    // 根据新的比率，刷新frame
    override func resetFrameWithPro(pro: Float) {
        self.heightChangeButton?.frame.origin.x = (self.heightChangeButton?.frame.origin.x)! / CGFloat(self.pro / pro)
        self.heightChangeButton?.frame.origin.y = (self.heightChangeButton?.frame.origin.y)! / CGFloat(self.pro / pro)
        super.resetFrameWithPro(pro: pro)
    }
}
