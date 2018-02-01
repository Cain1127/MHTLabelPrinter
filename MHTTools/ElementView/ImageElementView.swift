//
//  ImageElementView.swift
//  MHTLabelPrinter
//
//  Created by Admin on 30/01/2018.
//  Copyright © 2018 MHT. All rights reserved.
//

import UIKit

class ImageElementView: QRCodeElementView {
    // 图片框刷新UI
    func updateUIWithModel(image: UIImage, imageModel: TemplateImageModel = TemplateImageModel(), pro: Float = PROPORTION_LOCAL) -> Void {
        self.imageView?.image = image
        self.imageView?.frame.size.width = (self.imageView?.frame.width)! / CGFloat(self.pro / pro)
        self.imageView?.frame.size.height = (self.imageView?.frame.height)! / CGFloat(self.pro / pro)
        super.resetFrameWithPro(pro: pro)
    }
}
