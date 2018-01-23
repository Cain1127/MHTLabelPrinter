//
//  TextElementView.swift
//  MHTLabelPrinter
//
//  Created by Admin on 23/01/2018.
//  Copyright © 2018 MHT. All rights reserved.
//

import UIKit

class TextElementView: ElementHorizontalView {
    var textView: UILabel?
    
    /**
     * 重写构造函数
     */
    override init(frame: CGRect) {
        self.textView = UILabel(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        self.textView?.font = UIFont.systemFont(ofSize: CGFloat(14 * MHTBase.autoScreen()))
        self.textView?.numberOfLines = 0
        
        super.init(frame: frame)
        self.addSubview(self.textView!)
        self.sendSubview(toBack: self.textView!)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func widthPanAction(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: gesture.view!)
        if(translation.x > 0) {
            self.textView?.frame.size.width = self.oriWidth + translation.x
        } else {
            let width = oriWidth + translation.x
            if(5 >= width) {
                return
            }
            
            self.textView?.frame.size.width = width
        }
        super.widthPanAction(gesture: gesture)
    }
}

//extension TextElementView: UITextViewDelegate {
//    func textViewDidChange(_ textView: UITextView) {
//        // 计算需要的高度
//
//    }
//
//    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
//        return true
//    }
//}

