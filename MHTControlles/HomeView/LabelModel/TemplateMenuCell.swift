//
//  TemplateMenuCell.swift
//  MHTLabelPrinter
//
//  Created by Admin on 19/01/2018.
//  Copyright © 2018 MHT. All rights reserved.
//

import UIKit

class TemplateMenuCell: UITableViewCell {
    
    var titleLabel: UILabel
    
    // 根据宽高创建对象
    init(style: UITableViewCellStyle, reuseIdentifier: String?, width: CGFloat, height: CGFloat) {
        self.titleLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        self.titleLabel.font = UIFont.systemFont(ofSize: CGFloat(16 * MHTBase.autoScreen()))
        self.titleLabel.textAlignment = NSTextAlignment.center
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.addSubview(self.titleLabel)
    }
    
    // 重写初始化方法
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.titleLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.contentView.addSubview(self.titleLabel)
    }
    
    required init(coder: NSCoder) {
        self.titleLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        super.init(coder: coder)!
        self.backgroundColor = UIColor.white
        self.contentView.addSubview(self.titleLabel)
    }
    
    // 设置选择样式
//    func setSelectedStyle(selected: Bool) -> Void {
//        if(selected) {
//            self.contentView.backgroundColor = SYS_Color
//            self.titleLabel.textColor = UIColor.white
//        } else {
//            self.backgroundColor = UIColor.white
//            self.titleLabel.textColor = UIColor.black
//        }
//    }
    
    // 重写选择时的样式
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if(selected) {
            self.contentView.backgroundColor = SYS_Color
            self.titleLabel.textColor = UIColor.white
        } else {
            self.backgroundColor = UIColor.white
            self.titleLabel.textColor = UIColor.black
        }
    }
}
