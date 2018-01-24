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
        self.addDoneButtonOnKeyboard()
        self.textView?.delegate = self
        self.addSubview(self.textLabel!)
        self.addSubview(self.textView!)
        self.sendSubview(toBack: self.textView!)
        self.sendSubview(toBack: self.textLabel!)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func widthChangeAction(translation: CGPoint, status: UIGestureRecognizerState) {
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
        super.widthChangeAction(translation: translation, status: status)
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
        
        let widthButtonYPoint = (newHeight - (self.widthChangeButton?.frame.height)!) / 2
        self.widthChangeButton?.frame = CGRect(x: (self.widthChangeButton?.frame.minX)!,
                                               y: widthButtonYPoint,
                                               width: (self.widthChangeButton?.frame.width)!,
                                               height: (self.widthChangeButton?.frame.height)!)
    }
    
    //在键盘上添加“完成“按钮
    func addDoneButtonOnKeyboard() {
        let doneToolbar = UIToolbar()
        
        //左侧的空隙
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil, action: nil)
        //右侧的完成按钮
        let done: UIBarButtonItem = UIBarButtonItem(title: "确定", style: .done,
                                                    target: self,
                                                    action: #selector(keyboardDoneButtonAction))
        
        var items:[UIBarButtonItem] = []
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        self.textView?.inputAccessoryView = doneToolbar
    }
    
    // 重写回收键盘方法
    override func resignKeyboardAction() -> Void {
        self.setTextEdit(isEdit: false)
    }
}

extension TextElementView: UITextViewDelegate {
    //“确定“按钮点击响应
    @objc func keyboardDoneButtonAction() {
        //收起键盘
        self.textLabel?.text = self.textView?.text
        self.resetUIHeightWithWidth(width: (self.textLabel?.frame.width)!)
        self.setTextEdit(isEdit: false)
    }
    
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

