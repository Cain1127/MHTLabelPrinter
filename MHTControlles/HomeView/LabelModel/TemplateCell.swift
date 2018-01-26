//
//  TemplateCell.swift
//  MHTLabelPrinter
//
//  Created by Admin on 19/01/2018.
//  Copyright © 2018 MHT. All rights reserved.
//

import UIKit

class TemplateCell: UITableViewCell {
    var templateImageView: UIImageView!
    var titleLabel: UILabel!
    
    // 根据宽高创建cell
    init(style: UITableViewCellStyle, reuseIdentifier: String?, width: CGFloat, height: CGFloat) {
        self.titleLabel = UILabel.init(frame: CGRect(x: 16, y: height - 16 - 5, width: width - 16 * 2, height: 16))
        self.titleLabel.font = UIFont.systemFont(ofSize: CGFloat(14 * MHTBase.autoScreen()))
        self.titleLabel.textAlignment = NSTextAlignment.center
        
        self.templateImageView = UIImageView.init(frame: CGRect(x: 16, y: 16, width: width - 16 * 2, height: height - 16 - 16 - 10))
        self.templateImageView.isUserInteractionEnabled = true
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.templateImageView)
    }
    
    // 重写coder方法
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    // 根据数据，更新UI
    func updateUIWithModel(model: TemplateModel, width: CGFloat, height: CGFloat) {
        // 清空原来UI
        self.templateImageView.removeFromSuperview()
        self.templateImageView = nil
        self.titleLabel.removeFromSuperview()
        self.titleLabel = nil
        
        self.titleLabel = UILabel.init(frame: CGRect(x: 16, y: height - 16 - 5, width: width - 16 * 2, height: 16))
        self.titleLabel.font = UIFont.systemFont(ofSize: CGFloat(14 * MHTBase.autoScreen()))
        self.titleLabel.textAlignment = NSTextAlignment.center
        
        self.templateImageView = UIImageView.init(frame: CGRect(x: 16, y: 16, width: width - 16 * 2, height: height - 16 - 16 - 10))
        self.templateImageView.isUserInteractionEnabled = true
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.templateImageView)
        
        //cell上图片
        var imageString = model.labelViewBack!
        imageString = imageString.replacingOccurrences(of: "\n", with: "")
        let base64 = Data(base64Encoded: imageString)
        self.templateImageView.image = UIImage(data: base64!)
        
        // 标题
        self.titleLabel.text = model.labelName
    }
}
