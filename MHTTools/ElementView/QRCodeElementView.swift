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
    override init(frame: CGRect, pro: Float = PROPORTION_LOCAL) {
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        
        super.init(frame: frame, pro: pro)
        self.addSubview(self.imageView!)
        self.sendSubview(toBack: self.imageView!)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func widthChangeAction(translation: CGPoint, status: UIGestureRecognizerState) {
        if(translation.x > 0) {
            self.imageView?.frame.size.width = self.oriWidth + translation.x
        } else {
            let width = oriWidth + translation.x
            if(5 >= width) {
                return
            }

            self.imageView?.frame.size.width = width
        }
        super.widthChangeAction(translation: translation, status: status)
    }
    
    override func heightChangeAction(translation: CGPoint, status: UIGestureRecognizerState) {
        if(translation.y > 0) {
            self.imageView?.frame.size.height = self.oriHeight + translation.y
        } else {
            let height = self.oriHeight + translation.y
            if(5 >= height) {
                return
            }

            self.imageView?.frame.size.height = height
        }
        super.heightChangeAction(translation: translation, status: status)
    }
}

extension QRCodeElementView {
    // 根据数据模型刷新UI
    func updateUIWithModel(image: UIImage, model: TemplateQRModel = TemplateQRModel(), pro: Float = PROPORTION_LOCAL) -> Void {
        self.imageView?.image = image
        self.imageView?.frame.size.width = (self.imageView?.frame.width)! / CGFloat(self.pro / pro)
        self.imageView?.frame.size.height = (self.imageView?.frame.height)! / CGFloat(self.pro / pro)
        super.resetFrameWithPro(pro: pro)
    }
}
