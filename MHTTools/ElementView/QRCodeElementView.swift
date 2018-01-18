//
//  QRCodeElementView.swift
//  MHTLabelPrinter
//
//  Created by Admin on 18/01/2018.
//  Copyright © 2018 MHT. All rights reserved.
//

import Foundation

class QRCodeElementView: ElementVerticalView {
    var imageView: UIImageView?
    var title: String?
    
    /**
     * 重写构造函数
     */
    override init(frame: CGRect) {
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        
        super.init(frame: frame)
        self.addSubview(self.imageView!)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}
