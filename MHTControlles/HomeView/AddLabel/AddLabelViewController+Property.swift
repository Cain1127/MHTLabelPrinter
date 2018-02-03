//
//  AddLabelViewController+Property.swift
//  MHTLabelPrinter
//
//  Created by Admin on 01/02/2018.
//  Copyright © 2018 MHT. All rights reserved.
//

import UIKit

extension AddLabelViewController: UITextFieldDelegate {
    // 创建属性元素
    func createPropertyView() -> Void {
        // 清空原对象
        for subView in self.propertyScrollView.subviews {
            subView.removeFromSuperview()
        }
        
        // 判断当前的属性类型
        if self.isMultSelected {
            self.createEditViewPropertyView()
            return
        }
        
        // 当前是单选，判断是否有选择项，有的话，就直接中止当前消息
        for subView in self.editView.subviews {
            if subView.isKind(of: ElementView.self) {
                let subElementView = subView as! ElementView
                if subElementView.isSelected {
                    self.createElementViewPropertyView(view: subElementView)
                    return
                }
            }
        }
        
        // 无论单选，多选，如果没有选择的元素时，都是创建编辑窗口的属性栏
        self.createEditViewPropertyView()
    }
    
    // 创建编辑窗口的属性view
    func createEditViewPropertyView() -> Void {
        // 通用高度
        let normalHeight = CGFloat(40)
        let normalWidth = self.propertyScrollView.frame.width
        
        // 标签属性
        let titleLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: CGFloat(0), width: normalWidth, height: normalHeight))
        titleLabel.backgroundColor = SYS_LIGHT_GREY
        titleLabel.text = "  " + MHTBase.internationalStringWith(str: "标签属性")
        self.propertyScrollView.addSubview(titleLabel)
        
        // 分隔线
        let sepLabel1 = UILabel(frame: CGRect.init(x: CGFloat(0), y: titleLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel1.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel1)
        
        // 名称
        let nameLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel1.frame.maxY, width: CGFloat(80), height: normalHeight))
        nameLabel.text = "  " + MHTBase.internationalStringWith(str: "标签名称")
        self.propertyScrollView.addSubview(nameLabel)
        
        // 名称输入框
        let nameTextField = UITextField(frame: CGRect.init(x: nameLabel.frame.maxX + 16, y: sepLabel1.frame.maxY, width: normalWidth - nameLabel.frame.width - 16 - 16, height: normalHeight))
        nameTextField.delegate = self
        nameTextField.text = self.dataSource.labelName
        nameTextField.placeholder = MHTBase.internationalStringWith(str: "请输入名称")
        nameTextField.textAlignment = NSTextAlignment.right
        nameTextField.textColor = SYS_LIGHT_GREY
        self.propertyScrollView.addSubview(nameTextField)
        
        // 分隔线
        let sepLabel2 = UILabel(frame: CGRect.init(x: CGFloat(0), y: nameLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel2.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel2)
        
        // 宽度
        let widthLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel2.frame.maxY, width: CGFloat(80), height: normalHeight))
        widthLabel.text = "  " + MHTBase.internationalStringWith(str: "标签宽度")
        self.propertyScrollView.addSubview(widthLabel)
        
        // 宽度输入框
        let widthTextField = UITextField(frame: CGRect.init(x: widthLabel.frame.maxX + 16, y: sepLabel2.frame.maxY, width: normalWidth - widthLabel.frame.width - 16 - 16, height: normalHeight))
        widthTextField.delegate = self
        widthTextField.text = (self.dataSource.width?.description)! + "mm"
        widthTextField.textAlignment = NSTextAlignment.right
        widthTextField.textColor = SYS_LIGHT_GREY
        self.propertyScrollView.addSubview(widthTextField)
        
        // 分隔线
        let sepLabel3 = UILabel(frame: CGRect.init(x: CGFloat(0), y: widthLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel3.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel3)
        
        // 高度
        let heightLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel3.frame.maxY, width: CGFloat(80), height: normalHeight))
        heightLabel.text = "  " + MHTBase.internationalStringWith(str: "标签高度")
        self.propertyScrollView.addSubview(heightLabel)
        
        // 高度输入框
        let heightTextField = UITextField(frame: CGRect.init(x: heightLabel.frame.maxX + 16, y: sepLabel3.frame.maxY, width: normalWidth - heightLabel.frame.width - 16 - 16, height: normalHeight))
        heightTextField.delegate = self
        heightTextField.text = (self.dataSource.height?.description)! + "mm"
        heightTextField.textAlignment = NSTextAlignment.right
        heightTextField.textColor = SYS_LIGHT_GREY
        self.propertyScrollView.addSubview(heightTextField)
        
        // 分隔线
        let sepLabel4 = UILabel(frame: CGRect.init(x: CGFloat(0), y: heightLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel4.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel4)
        
        // 剩余纸张
        let pageNumberLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel4.frame.maxY, width: CGFloat(80), height: normalHeight))
        pageNumberLabel.text = "  " + MHTBase.internationalStringWith(str: "剩余纸张")
        self.propertyScrollView.addSubview(pageNumberLabel)
        
        // 剩余纸张输入框
        let pageNumberTextField = UITextField(frame: CGRect.init(x: pageNumberLabel.frame.maxX + 16, y: sepLabel4.frame.maxY, width: normalWidth - pageNumberLabel.frame.width - 16 - 16, height: normalHeight))
        pageNumberTextField.text = "1000mm"
        pageNumberTextField.textColor = SYS_LIGHT_GREY
        pageNumberTextField.textAlignment = NSTextAlignment.right
        pageNumberTextField.isUserInteractionEnabled = false
        self.propertyScrollView.addSubview(pageNumberTextField)
        
        // 分隔线
        let sepLabel5 = UILabel(frame: CGRect.init(x: CGFloat(0), y: pageNumberLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel5.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel5)
        
        // 打印方向
        let printDirectLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel5.frame.maxY, width: CGFloat(80), height: normalHeight))
        printDirectLabel.text = "  " + MHTBase.internationalStringWith(str: "打印方向")
        self.propertyScrollView.addSubview(printDirectLabel)
        
        let buttonGap = CGFloat(10)
        let buttonLeftWidth = normalWidth - 16 - 16
        let buttonWidth = (buttonLeftWidth - printDirectLabel.frame.width - 3 * buttonGap) / 4
        let printDirectButton1 = UIButton()
        printDirectButton1.frame = CGRect.init(x: pageNumberLabel.frame.maxX + 16, y: printDirectLabel.frame.minY + 5, width: buttonWidth, height: normalHeight - 10)
        printDirectButton1.setTitle("0", for: UIControlState.normal)
        printDirectButton1.layer.borderWidth = 1
        printDirectButton1.layer.borderColor = SYS_Color.cgColor
        printDirectButton1.layer.cornerRadius = 4
        printDirectButton1.imageView?.layer.cornerRadius = 4
        printDirectButton1.clipsToBounds = true
        printDirectButton1.setTitleColor(UIColor.black, for: UIControlState.normal)
        printDirectButton1.setTitleColor(UIColor.white, for: UIControlState.selected)
        printDirectButton1.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        printDirectButton1.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        printDirectButton1.isSelected = self.dataSource.printingDirection == 0
        printDirectButton1.tag = 3000 + 0
        self.propertyScrollView.addSubview(printDirectButton1)
        printDirectButton1.addTarget(self, action: #selector(changePrintDirectionAction(sender:)), for: UIControlEvents.touchUpInside)
        
        let printDirectButton2 = UIButton()
        printDirectButton2.frame = CGRect.init(x: printDirectButton1.frame.maxX + buttonGap, y: printDirectButton1.frame.minY, width: printDirectButton1.frame.width, height: printDirectButton1.frame.height)
        printDirectButton2.setTitle("90", for: UIControlState.normal)
        printDirectButton2.layer.borderWidth = 1
        printDirectButton2.layer.borderColor = SYS_Color.cgColor
        printDirectButton2.layer.cornerRadius = 4
        printDirectButton2.imageView?.layer.cornerRadius = 4
        printDirectButton2.clipsToBounds = true
        printDirectButton2.setTitleColor(UIColor.black, for: UIControlState.normal)
        printDirectButton2.setTitleColor(UIColor.white, for: UIControlState.selected)
        printDirectButton2.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        printDirectButton2.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        printDirectButton2.isSelected = self.dataSource.printingDirection == 90
        printDirectButton2.tag = 3000 + 90
        self.propertyScrollView.addSubview(printDirectButton2)
        printDirectButton2.addTarget(self, action: #selector(changePrintDirectionAction(sender:)), for: UIControlEvents.touchUpInside)
        
        let printDirectButton3 = UIButton()
        printDirectButton3.frame = CGRect.init(x: printDirectButton2.frame.maxX + buttonGap, y: printDirectButton1.frame.minY, width: printDirectButton1.frame.width, height: printDirectButton1.frame.height)
        printDirectButton3.setTitle("180", for: UIControlState.normal)
        printDirectButton3.layer.borderWidth = 1
        printDirectButton3.layer.borderColor = SYS_Color.cgColor
        printDirectButton3.layer.cornerRadius = 4
        printDirectButton3.imageView?.layer.cornerRadius = 4
        printDirectButton3.clipsToBounds = true
        printDirectButton3.setTitleColor(UIColor.black, for: UIControlState.normal)
        printDirectButton3.setTitleColor(UIColor.white, for: UIControlState.selected)
        printDirectButton3.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        printDirectButton3.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        printDirectButton3.isSelected = self.dataSource.printingDirection == 180
        printDirectButton3.tag = 3000 + 180
        self.propertyScrollView.addSubview(printDirectButton3)
        printDirectButton3.addTarget(self, action: #selector(changePrintDirectionAction(sender:)), for: UIControlEvents.touchUpInside)
        
        let printDirectButton4 = UIButton()
        printDirectButton4.frame = CGRect.init(x: printDirectButton3.frame.maxX + buttonGap, y: printDirectButton1.frame.minY, width: printDirectButton1.frame.width, height: printDirectButton1.frame.height)
        printDirectButton4.setTitle("270", for: UIControlState.normal)
        printDirectButton4.layer.borderWidth = 1
        printDirectButton4.layer.borderColor = SYS_Color.cgColor
        printDirectButton4.layer.cornerRadius = 4
        printDirectButton4.imageView?.layer.cornerRadius = 4
        printDirectButton4.clipsToBounds = true
        printDirectButton4.setTitleColor(UIColor.black, for: UIControlState.normal)
        printDirectButton4.setTitleColor(UIColor.white, for: UIControlState.selected)
        printDirectButton4.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        printDirectButton4.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        printDirectButton4.isSelected = self.dataSource.printingDirection == 270
        printDirectButton4.tag = 3000 + 270
        self.propertyScrollView.addSubview(printDirectButton4)
        printDirectButton4.addTarget(self, action: #selector(changePrintDirectionAction(sender:)), for: UIControlEvents.touchUpInside)
        
        // 分隔线
        let sepLabel6 = UILabel(frame: CGRect.init(x: CGFloat(0), y: printDirectLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel6.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel6)
        
        // 是否开启镜像
        let mirrorLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel6.frame.maxY, width: CGFloat(120), height: normalHeight))
        mirrorLabel.text = "  " + MHTBase.internationalStringWith(str: "是否开启镜像")
        self.propertyScrollView.addSubview(mirrorLabel)
        
        self.mirrorButton = UIButton()
        self.mirrorButton?.frame = CGRect.init(x: normalWidth - 16 - 40, y: sepLabel6.frame.maxY + 10, width: 40, height: 20)
        self.mirrorButton?.setImage(UIImage(named: "isCompression"), for: UIControlState.normal)
        self.mirrorButton?.setImage(UIImage(named: "isCompressionO"), for: UIControlState.selected)
        self.propertyScrollView.addSubview(self.mirrorButton!)
        self.mirrorButton?.addTarget(self, action: #selector(changeMirrorSettingAction(sender:)), for: UIControlEvents.touchUpInside)
        
        // 分隔线
        let sepLabel7 = UILabel(frame: CGRect.init(x: CGFloat(0), y: 0, width: normalWidth, height: CGFloat(0.5)))
        sepLabel7.backgroundColor = UIColor.black
        
        // 尾巴方向
        let tailLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel7.frame.maxY, width: CGFloat(80), height: normalHeight))
        tailLabel.text = "  " + MHTBase.internationalStringWith(str: "尾巴方向")
        
        let tailDirectButton1 = UIButton()
        tailDirectButton1.frame = CGRect.init(x: tailLabel.frame.maxX + 16, y: tailLabel.frame.minY + 5, width: buttonWidth, height: normalHeight - 10)
        tailDirectButton1.setTitle("上", for: UIControlState.normal)
        tailDirectButton1.layer.borderWidth = 1
        tailDirectButton1.layer.borderColor = SYS_Color.cgColor
        tailDirectButton1.layer.cornerRadius = 4
        tailDirectButton1.imageView?.layer.cornerRadius = 4
        tailDirectButton1.clipsToBounds = true
        tailDirectButton1.setTitleColor(UIColor.black, for: UIControlState.normal)
        tailDirectButton1.setTitleColor(UIColor.white, for: UIControlState.selected)
        tailDirectButton1.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        tailDirectButton1.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        tailDirectButton1.isSelected = self.dataSource.tailDirection == 2
        tailDirectButton1.addTarget(self, action: #selector(changeMirrorDirectionAction(sender:)), for: UIControlEvents.touchUpInside)
        tailDirectButton1.tag = 2000 + 2
        
        let tailDirectButton2 = UIButton()
        tailDirectButton2.frame = CGRect.init(x: tailDirectButton1.frame.maxX + buttonGap, y: tailDirectButton1.frame.minY, width: tailDirectButton1.frame.width, height: tailDirectButton1.frame.height)
        tailDirectButton2.setTitle("下", for: UIControlState.normal)
        tailDirectButton2.layer.borderWidth = 1
        tailDirectButton2.layer.borderColor = SYS_Color.cgColor
        tailDirectButton2.layer.cornerRadius = 4
        tailDirectButton2.imageView?.layer.cornerRadius = 4
        tailDirectButton2.clipsToBounds = true
        tailDirectButton2.setTitleColor(UIColor.black, for: UIControlState.normal)
        tailDirectButton2.setTitleColor(UIColor.white, for: UIControlState.selected)
        tailDirectButton2.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        tailDirectButton2.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        tailDirectButton2.isSelected = self.dataSource.tailDirection == 3
        tailDirectButton2.addTarget(self, action: #selector(changeMirrorDirectionAction(sender:)), for: UIControlEvents.touchUpInside)
        tailDirectButton2.tag = 2000 + 3
        
        let tailDirectButton3 = UIButton()
        tailDirectButton3.frame = CGRect.init(x: tailDirectButton2.frame.maxX + buttonGap, y: tailDirectButton1.frame.minY, width: tailDirectButton1.frame.width, height: tailDirectButton1.frame.height)
        tailDirectButton3.setTitle("左", for: UIControlState.normal)
        tailDirectButton3.layer.borderWidth = 1
        tailDirectButton3.layer.borderColor = SYS_Color.cgColor
        tailDirectButton3.layer.cornerRadius = 4
        tailDirectButton3.imageView?.layer.cornerRadius = 4
        tailDirectButton3.clipsToBounds = true
        tailDirectButton3.setTitleColor(UIColor.black, for: UIControlState.normal)
        tailDirectButton3.setTitleColor(UIColor.white, for: UIControlState.selected)
        tailDirectButton3.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        tailDirectButton3.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        tailDirectButton3.isSelected = self.dataSource.tailDirection == 0
        tailDirectButton3.addTarget(self, action: #selector(changeMirrorDirectionAction(sender:)), for: UIControlEvents.touchUpInside)
        tailDirectButton3.tag = 2000 + 0
        
        let tailDirectButton4 = UIButton()
        tailDirectButton4.frame = CGRect.init(x: tailDirectButton3.frame.maxX + buttonGap, y: tailDirectButton1.frame.minY, width: tailDirectButton1.frame.width, height: tailDirectButton1.frame.height)
        tailDirectButton4.setTitle("右", for: UIControlState.normal)
        tailDirectButton4.layer.borderWidth = 1
        tailDirectButton4.layer.borderColor = SYS_Color.cgColor
        tailDirectButton4.layer.cornerRadius = 4
        tailDirectButton4.imageView?.layer.cornerRadius = 4
        tailDirectButton4.clipsToBounds = true
        tailDirectButton4.setTitleColor(UIColor.black, for: UIControlState.normal)
        tailDirectButton4.setTitleColor(UIColor.white, for: UIControlState.selected)
        tailDirectButton4.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        tailDirectButton4.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        tailDirectButton4.isSelected = self.dataSource.tailDirection == 1
        tailDirectButton4.addTarget(self, action: #selector(changeMirrorDirectionAction(sender:)), for: UIControlEvents.touchUpInside)
        tailDirectButton4.tag = 2000 + 1
        
        // 分隔线
        let sepLabel8 = UILabel(frame: CGRect.init(x: CGFloat(0), y: tailLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel8.backgroundColor = UIColor.black
        
        // 尾巴长度
        let tailLengthLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel8.frame.maxY, width: CGFloat(80), height: normalHeight))
        tailLengthLabel.text = "  " + MHTBase.internationalStringWith(str: "尾巴长度")
        
        let tailLengthField = UITextField(frame: CGRect.init(x: tailLengthLabel.frame.maxX + 16, y: sepLabel8.frame.maxY, width: normalWidth - tailLengthLabel.frame.width - 16 - 16, height: normalHeight))
        tailLengthField.delegate = self
        if nil != self.dataSource.tailLength {
            tailLengthField.text = (self.dataSource.tailLength?.description)! + "mm"
        } else {
            self.dataSource.tailLength = 10
            tailLengthField.text = (self.dataSource.tailLength?.description)! + "mm"
        }
        tailLengthField.textAlignment = NSTextAlignment.right
        tailLengthField.textColor = SYS_LIGHT_GREY
        
        // 镜像功能View
        self.mirrorPropertyView = UIView(frame: CGRect.init(x: CGFloat(0), y: mirrorLabel.frame.maxY, width: normalWidth, height: tailLengthLabel.frame.maxY))
        self.mirrorPropertyView?.addSubview(sepLabel7)
        self.mirrorPropertyView?.addSubview(tailLabel)
        self.mirrorPropertyView?.addSubview(tailDirectButton1)
        self.mirrorPropertyView?.addSubview(tailDirectButton2)
        self.mirrorPropertyView?.addSubview(tailDirectButton3)
        self.mirrorPropertyView?.addSubview(tailDirectButton4)
        self.mirrorPropertyView?.addSubview(sepLabel8)
        self.mirrorPropertyView?.addSubview(tailLengthLabel)
        self.mirrorPropertyView?.addSubview(tailLengthField)
        self.mirrorPropertyView?.isHidden = true
        self.propertyScrollView.addSubview(self.mirrorPropertyView!)
        
        // 判断是否有镜像
        if self.dataSource.mirror! {
            self.mirrorButton?.isSelected = true
            self.mirrorPropertyView?.isHidden = false
            
            // 设置滚动
            self.propertyScrollView.contentSize = CGSize(width: normalWidth, height: (self.mirrorPropertyView?.frame.maxY)!)
        } else {
            // 设置滚动
            self.propertyScrollView.contentSize = CGSize(width: normalWidth, height: mirrorLabel.frame.maxY)
        }
    }
    
    // 创建元素类型的属性窗口
    func createElementViewPropertyView(view: ElementView) -> Void {
        if view.isKind(of: DateElementView.self) {
            let tempView = view as! DateElementView
            self.createDateElementViewPropertyView(view: tempView)
            return
        }
        
        if view.isKind(of: TextElementView.self) {
            let tempView = view as! TextElementView
            self.createTextElementViewPropertyView(view: tempView)
            return
        }
        
        if view.isKind(of: BarcodeElementView.self) {
            let tempView = view as! BarcodeElementView
            self.createQCCodeElementViewPropertyView(view: tempView)
            return
        }
        
        if view.isKind(of: ImageElementView.self) {
            let tempView = view as! ImageElementView
            self.createImageElementViewPropertyView(view: tempView)
            return
        }
        
        if view.isKind(of: QRCodeElementView.self) {
            let tempView = view as! QRCodeElementView
            self.createQRCodeElementViewPropertyView(view: tempView)
            return
        }
        
        if view.isKind(of: LineElementView.self) {
            let tempView = view as! LineElementView
            self.createLineElementViewPropertyView(view: tempView)
            return
        }
        
        if view.isKind(of: RectElementView.self) {
            let tempView = view as! RectElementView
            self.createRectElementViewPropertyView(view: tempView)
            return
        }
    }
    
    func createDateElementViewPropertyView(view: DateElementView) -> Void {
        
    }
    
    func createTextElementViewPropertyView(view: TextElementView) -> Void {
        
    }
    
    func createQCCodeElementViewPropertyView(view: BarcodeElementView) -> Void {
        
    }
    
    func createImageElementViewPropertyView(view: ImageElementView) -> Void {
        
    }
    
    func createQRCodeElementViewPropertyView(view: QRCodeElementView) -> Void {
        
    }
    
    func createLineElementViewPropertyView(view: LineElementView) -> Void {
        
    }
    
    func createRectElementViewPropertyView(view: RectElementView) -> Void {
        
    }
    
    // 选择打印方向事件
    @objc func changePrintDirectionAction(sender: UIButton) {
        if sender.isSelected {
            return
        }
        
        let tempButton = self.propertyScrollView.viewWithTag(self.dataSource.printingDirection! + 3000) as! UIButton
        tempButton.isSelected = false
        self.dataSource.printingDirection = sender.tag - 3000
        sender.isSelected = true
    }
    
    // 选择镜像方向事件
    @objc func changeMirrorDirectionAction(sender: UIButton) {
        if sender.isSelected {
            return
        }
        
        let tempButton = self.propertyScrollView.viewWithTag(self.dataSource.tailDirection! + 2000) as! UIButton
        tempButton.isSelected = false
        self.dataSource.tailDirection = sender.tag - 2000
        sender.isSelected = true
    }
    
    // 选择镜像事件
    @objc func changeMirrorSettingAction(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.mirrorPropertyView?.isHidden = !sender.isSelected
        self.dataSource.mirror = sender.isSelected
        if sender.isSelected {
            // 设置滚动
            self.propertyScrollView.contentSize = CGSize(width: (self.mirrorPropertyView?.frame.width)!, height: (self.mirrorPropertyView?.frame.maxY)!)
        } else {
            // 设置滚动
            self.propertyScrollView.contentSize = CGSize(width: (self.mirrorPropertyView?.frame.width)!, height: self.propertyScrollView.contentSize.height - (self.mirrorPropertyView?.frame.height)!)
        }
    }
}
