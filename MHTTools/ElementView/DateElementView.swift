//
//  DateElementView.swift
//  MHTLabelPrinter
//
//  Created by Admin on 23/01/2018.
//  Copyright © 2018 MHT. All rights reserved.
//

import Foundation

class DateElementView: TextElementView {
    
}

extension DateElementView {
    // 更新函数
    func updateDateUIWithModel(model: TemplateTextModel = TemplateTextModel(), pro: Float = PROPORTION_LOCAL) -> Void {
        self.dataSource = model
        self.textView?.text = model.text
        self.textLabel?.text = model.text
        
        let textSize = self.dataSource.TEXT_SIZE! / pro
        let font = UIFont.systemFont(ofSize: CGFloat(textSize))
        self.textView?.font = font
        self.textLabel?.font = font
        
        // 设置新的行高像素值
        let newLineHeight = StringUtil.getLabHeigh(labelStr: "H", font: font, width: frame.width)
        self.textLabel?.wordSpace = CGFloat(self.dataSource.WORD_SPACE!)
        self.textLabel?.lineSpace = CGFloat(newLineHeight)
        
        // 重置UI的宽高
        let newPro = CGFloat(self.pro / pro)
        self.textLabel?.frame.size.width = (self.textLabel?.frame.width)! / newPro
        self.textLabel?.frame.size.height = (self.textLabel?.frame.height)! / newPro
        self.textView?.frame.size.width = (self.textView?.frame.width)! / newPro
        self.textView?.frame.size.height = (self.textView?.frame.height)! / newPro
        super.resetFrameWithPro(pro: pro)
        
        // 重新扩展UI的高度，因为文字有可能分行
        self.resetUIHeightWithWidth(width: (self.textLabel?.frame.width)!, pro: Float(newPro))
    }
}
