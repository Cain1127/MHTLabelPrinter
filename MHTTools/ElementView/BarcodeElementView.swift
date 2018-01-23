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
//        self.titleLabel?.sizeToFit()
        
        super.init(frame: frame)
        self.addSubview(self.imageView!)
        self.addSubview(self.titleLabel!)
        self.sendSubview(toBack: self.imageView!)
        self.sendSubview(toBack: self.titleLabel!)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func widthPanAction(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: gesture.view!)
        if(translation.x > 0) {
            self.imageView?.frame.size.width = self.oriWidth + translation.x
            self.titleLabel?.frame.size.width = self.oriWidth + translation.x
        } else {
            let width = oriWidth + translation.x
            if(21 >= width) {
                return
            }
            
            self.imageView?.frame.size.width = width
            self.titleLabel?.frame.size.width = width
        }
        super.widthPanAction(gesture: gesture)
    }
    
    override func heightPanAction(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: gesture.view!)
        if(translation.y > 0) {
            self.imageView?.frame.size.height = self.oriHeight + translation.y - 16
            self.titleLabel?.frame.origin.y = self.oriHeight + translation.y - 16
        } else {
            let height = self.oriHeight + translation.y
            if(21 >= height) {
                return
            }
            
            self.imageView?.frame.size.height = height - 16
            self.titleLabel?.frame.origin.y = height - 16
        }
        super.heightPanAction(gesture: gesture)
    }
}
