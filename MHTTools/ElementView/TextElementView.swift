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
    
    /**
     * 重写构造函数
     */
    override init(frame: CGRect) {
        self.textView = UITextView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        
        super.init(frame: frame)
        self.addSubview(self.textView!)
        self.sendSubview(toBack: self.textView!)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension TextElementView: UITextViewDelegate {
    
}
