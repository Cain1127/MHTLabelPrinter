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
    override init(frame: CGRect, pro: Float = PROPORTION_LOCAL) {
        let textSize = 14 / pro
        let font = UIFont.systemFont(ofSize: CGFloat(textSize))
        let textHeight = StringUtil.getLabHeigh(labelStr: "H", font: font, width: frame.width)
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height - textHeight))
        
        self.titleLabel = UILabel(frame: CGRect(x: 0, y: frame.size.height - textHeight, width: frame.size.width, height: textHeight))
        self.titleLabel?.textAlignment = NSTextAlignment.center
        self.titleLabel?.font = font
        
        super.init(frame: frame, pro: pro)
        self.addSubview(self.imageView!)
        self.addSubview(self.titleLabel!)
        self.sendSubview(toBack: self.imageView!)
        self.sendSubview(toBack: self.titleLabel!)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func widthChangeAction(translation: CGPoint, status: UIGestureRecognizerState) {
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
        
        if(status == .ended) {
            // 重新生成条形码
            let barcodeImage = MHTBase.creatBarCodeImage(content: self.titleLabel?.text!, size: (self.imageView?.frame.size)!)
            self.imageView!.image = barcodeImage
        }
        
        super.widthChangeAction(translation: translation, status: status)
    }
    
    override func heightChangeAction(translation: CGPoint, status: UIGestureRecognizerState) {
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
        
        if(status == .ended) {
            // 重新生成条形码
            let barcodeImage = MHTBase.creatBarCodeImage(content: self.titleLabel?.text!, size: (self.imageView?.frame.size)!)
            self.imageView!.image = barcodeImage
        }
        
        super.heightChangeAction(translation: translation, status: status)
    }
}

extension BarcodeElementView {
    // 根据数据模型刷新UI
    func updateUIWithModel(image: UIImage, model: TemplateQCModel = TemplateQCModel(), pro: Float = PROPORTION_LOCAL) -> Void {
        self.titleLabel?.text = model.text!
        self.imageView?.image = image
        
//        let textSize = model.TEXT_SIZE! / pro
        let textSize = model.TEXT_SIZE!
        let font = UIFont.systemFont(ofSize: CGFloat(textSize))
        let textHeight = StringUtil.getLabHeigh(labelStr: model.text!, font: font, width: frame.width)
        let newWidth = self.frame.width / CGFloat(self.pro / pro)
        let newHeight = self.frame.height / CGFloat(self.pro / pro)
        if(1 == model.DRAW_TEXT_POSITION) {
            self.titleLabel?.isHidden = false
            self.titleLabel?.frame = CGRect(x: 0, y: newHeight - textHeight, width: newWidth, height: textHeight)
            self.imageView?.frame = CGRect(x: 0, y: 0, width: newWidth, height: newHeight - textHeight)
        } else if(2 == model.DRAW_TEXT_POSITION) {
            self.titleLabel?.isHidden = false
            self.titleLabel?.frame = CGRect(x: 0, y: 0, width: newWidth, height: textHeight)
            self.imageView?.frame = CGRect(x: 0, y: textHeight, width: newWidth, height: newHeight - textHeight)
        } else {
            self.titleLabel?.isHidden = true
            self.imageView?.frame = CGRect(x: 0, y: 0, width: newWidth, height: newHeight)
        }
        
        // 调整父窗口大小
        super.resetFrameWithPro(pro: pro)
    }
}
