//
//  BarcodeElementView.swift
//  MHTLabelPrinter
//
//  Created by Admin on 18/01/2018.
//  Copyright © 2018 MHT. All rights reserved.
//

import Foundation

class BarcodeElementView: ElementVerticalView {
    var imageView: UIImageView?
    var titleLabel: UILabel?
    
    /**
     * 重写构造函数
     */
    override init(frame: CGRect) {
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height - 16))
        
        self.titleLabel = UILabel(frame: CGRect(x: 0, y: frame.size.height - 16, width: frame.size.width, height: 16))
        self.titleLabel?.textAlignment = NSTextAlignment.center
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        super.init(frame: frame)
        self.addSubview(self.imageView!)
        self.addSubview(self.titleLabel!)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}
