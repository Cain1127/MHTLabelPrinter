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
    var textLabel: TemplateTextLable?
    
    // 每行文字的高度
    var lineHeight: Float?
    
    // 数据源
    var dataSource: TemplateTextModel = TemplateTextModel()
    var pro: Float = PROPORTION_LOCAL
    
    /**
     * 重写构造函数
     */
    override init(frame: CGRect) {
        let textSize = self.dataSource.TEXT_SIZE! / pro
        let font = UIFont.systemFont(ofSize: CGFloat(textSize))
        
        self.textView = UITextView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        self.textView?.font = font
        self.textView?.isHidden = true
        self.textView?.textContainer.lineBreakMode = .byWordWrapping
        
        self.textLabel = TemplateTextLable(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        self.textLabel?.font = font
        self.textLabel?.numberOfLines = 0
        self.textLabel?.lineBreakMode = .byWordWrapping
        
        super.init(frame: frame)
        self.addDoneButtonOnKeyboard()
        
        // 设置新的行高像素值
        let newLineHeight = StringUtil.getLabHeigh(labelStr: "H", font: font, width: frame.width)
        self.lineHeight = Float(newLineHeight)
        
        self.textView?.text = self.dataSource.text
        self.textLabel?.text = self.dataSource.text
        self.textLabel?.wordSpace = CGFloat(self.dataSource.WORD_SPACE!)
        self.textLabel?.lineSpace = CGFloat(self.dataSource.SPACING!)
        
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
    func resetUIHeightWithWidth(width: CGFloat, pro: Float = PROPORTION_LOCAL, isRotation: Bool = false) -> Void {
        let textSize = self.dataSource.TEXT_SIZE! / pro
        let font = UIFont.systemFont(ofSize: CGFloat(textSize))
        var newHeight = StringUtil.getLabHeigh(labelStr: (self.textLabel?.text)!, font: font, width: width)
        newHeight = newHeight < 30 ? 30 : newHeight
        newHeight = newHeight > 30 ? (newHeight + 16) : newHeight
        self.textView?.frame.size.height = newHeight
        self.textLabel?.frame.size.height = newHeight
        if(isRotation && nil != self.dataSource.rotate && 0 < self.dataSource.rotate!) {
            self.frame.size.width = newHeight
        } else {
            self.frame.size.height = newHeight
        }
        
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
    
    // 更新函数
    func updateUIWithModel(model: TemplateTextModel = TemplateTextModel(), pro: Float = PROPORTION_LOCAL) -> Void {
        self.dataSource = model
        self.textView?.text = model.text
        self.textLabel?.text = model.text
        
        let textSize = self.dataSource.TEXT_SIZE! / pro
        let font = UIFont.systemFont(ofSize: CGFloat(textSize))
        self.textView?.font = font
        self.textLabel?.font = font
        
        // 设置新的行高像素值
        let newLineHeight = StringUtil.getLabHeigh(labelStr: "H", font: font, width: frame.width)
        self.lineHeight = Float(newLineHeight)
        
        // 新的字间距和行间距
        self.textLabel?.wordSpace = CGFloat(self.dataSource.WORD_SPACE!)
        self.textLabel?.lineSpace = CGFloat(self.dataSource.SPACING!)
        
        self.pro = pro
        self.resetUIHeightWithWidth(width: (self.textLabel?.frame.width)!, pro: pro)
    }
}

extension TextElementView: UITextViewDelegate {
    //“确定“按钮点击响应
    @objc func keyboardDoneButtonAction() {
        //收起键盘
        self.textLabel?.text = self.textView?.text
        self.resetUIHeightWithWidth(width: (self.textLabel?.frame.width)!, pro: self.pro)
        self.setTextEdit(isEdit: false)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        // 计算需要的高度
        self.textLabel?.text = textView.text
        self.resetUIHeightWithWidth(width: (self.textLabel?.frame.width)!, pro: self.pro, isRotation: true)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        var tempString = textView.text as NSString
        tempString = tempString.replacingCharacters(in: range, with: text) as NSString
        self.textLabel?.text = tempString as String
         self.resetUIHeightWithWidth(width: (self.textLabel?.frame.width)!, pro: self.pro, isRotation: true)
        return true
    }
}
