//
//  TextElementView.swift
//  MHTLabelPrinter
//
//  Created by Admin on 23/01/2018.
//  Copyright © 2018 MHT. All rights reserved.
//

import UIKit

class TextElementView: ElementHorizontalView {
    var textView: UITextView?
    var textLabel: UILabel?
    
    /**
     * 重写构造函数
     */
    override init(frame: CGRect) {
        self.textView = UITextView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        self.textView?.font = UIFont.systemFont(ofSize: CGFloat(14 * MHTBase.autoScreen()))
        self.textView?.isHidden = true
        
        self.textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        self.textLabel?.font = UIFont.systemFont(ofSize: CGFloat(14 * MHTBase.autoScreen()))
        self.textLabel?.numberOfLines = 0
        
        super.init(frame: frame)
        self.textView?.delegate = self
        self.addSubview(self.textLabel!)
        self.addSubview(self.textView!)
        self.sendSubview(toBack: self.textView!)
        self.sendSubview(toBack: self.textLabel!)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func widthPanAction(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: gesture.view!)
        if(translation.x > 0) {
            self.textView?.frame.size.width = self.oriWidth + translation.x
            self.textLabel?.frame.size.width = self.oriWidth + translation.x
            self.resetUIHeightWithWidth(width: self.oriWidth + translation.x)
        } else {
            let width = oriWidth + translation.x
            if(5 >= width) {
                return
            }
            
            self.textView?.frame.size.width = width
            self.textLabel?.frame.size.width = width
            self.resetUIHeightWithWidth(width: width)
        }
        super.widthPanAction(gesture: gesture)
    }
    
    func setTextString(text: String) -> Void {
        self.textView?.text = text
        self.textLabel?.text = text
    }
    
    func setTextEdit(isEdit: Bool) -> Void {
        self.textView?.isHidden = !isEdit
        self.textLabel?.isHidden = isEdit
        if(isEdit) {
            self.textView?.becomeFirstResponder()
        } else {
            self.textView?.resignFirstResponder()
        }
    }
    
    /**
     * 根据新的宽度重置元素frame
     */
    func resetUIHeightWithWidth(width: CGFloat) -> Void {
        let font = UIFont.systemFont(ofSize: CGFloat(14 * MHTBase.autoScreen()))
        var newHeight = StringUtil.getLabHeigh(labelStr: (self.textLabel?.text)!, font: font, width: width)
        newHeight = newHeight < 30 ? 30 : newHeight
        newHeight = newHeight > 30 ? (newHeight + 16) : newHeight
        self.textView?.frame.size.height = newHeight
        self.textLabel?.frame.size.height = newHeight
        self.frame.size.height = newHeight
    }
    
    // 重写回收键盘方法
    override func resignKeyboardAction() -> Void {
        self.textView?.resignFirstResponder()
        self.textView?.isHidden = true
        self.textLabel?.isHidden = false
    }
}

extension TextElementView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        // 计算需要的高度
        self.textLabel?.text = textView.text
        self.resetUIHeightWithWidth(width: (self.textLabel?.frame.width)!)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        var tempString = textView.text as NSString
        tempString = tempString.replacingCharacters(in: range, with: text) as NSString
        self.textLabel?.text = tempString as String
         self.resetUIHeightWithWidth(width: (self.textLabel?.frame.width)!)
        return true
    }
}

