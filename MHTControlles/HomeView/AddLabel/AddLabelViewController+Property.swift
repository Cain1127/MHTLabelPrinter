//
//  AddLabelViewController+Property.swift
//  MHTLabelPrinter
//
//  Created by Admin on 01/02/2018.
//  Copyright © 2018 MHT. All rights reserved.
//

import UIKit

extension AddLabelViewController {
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
        nameTextField.tag = 100
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
        // 通用高度
        let normalHeight = CGFloat(40)
        let normalWidth = self.propertyScrollView.frame.width
        
        // 名称
        let nameLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: CGFloat(0), width: CGFloat(80), height: normalHeight))
        nameLabel.text = "  " + MHTBase.internationalStringWith(str: "名称")
        self.propertyScrollView.addSubview(nameLabel)
        
        // 名称输入框，不可以编辑
        let nameTextField = UITextField(frame: CGRect.init(x: nameLabel.frame.maxX + 16, y: nameLabel.frame.minY, width: normalWidth - nameLabel.frame.width - 16 - 16, height: normalHeight))
        nameTextField.delegate = self
        nameTextField.placeholder = MHTBase.internationalStringWith(str: "日期")
        nameTextField.isUserInteractionEnabled = false
        nameTextField.textAlignment = NSTextAlignment.right
        nameTextField.textColor = SYS_LIGHT_GREY
        self.propertyScrollView.addSubview(nameTextField)
        
        // 分隔线
        let sepLabel1 = UILabel(frame: CGRect.init(x: CGFloat(0), y: nameLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel1.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel1)
        
        // 旋转角度
        let printDirectLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel1.frame.maxY, width: CGFloat(80), height: normalHeight))
        printDirectLabel.text = "  " + MHTBase.internationalStringWith(str: "旋转角度")
        self.propertyScrollView.addSubview(printDirectLabel)
        
        let buttonGap = CGFloat(10)
        let buttonLeftWidth = normalWidth - 16 - 16
        let buttonWidth = (buttonLeftWidth - printDirectLabel.frame.width - 3 * buttonGap) / 4
        let printDirectButton1 = UIButton()
        printDirectButton1.frame = CGRect.init(x: printDirectLabel.frame.maxX + 16, y: printDirectLabel.frame.minY + 5, width: buttonWidth, height: normalHeight - 10)
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
        self.propertyScrollView.addSubview(printDirectButton1)
        
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
        self.propertyScrollView.addSubview(printDirectButton2)
        
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
        self.propertyScrollView.addSubview(printDirectButton3)
        
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
        self.propertyScrollView.addSubview(printDirectButton4)
        
        // 分隔线
        let sepLabel2 = UILabel(frame: CGRect.init(x: CGFloat(0), y: printDirectLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel2.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel2)
        
        // 位置大小标题
        let titleLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel2.frame.maxY, width: normalWidth, height: normalHeight))
        titleLabel.backgroundColor = SYS_LIGHT_GREY
        titleLabel.text = "  " + MHTBase.internationalStringWith(str: "位置大小")
        self.propertyScrollView.addSubview(titleLabel)
        
        // 分隔线
        let sepLabel3 = UILabel(frame: CGRect.init(x: CGFloat(0), y: titleLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel3.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel3)
        
        // 立平居中
        let widthCenterButton = (normalWidth - 3 * 16) / 2
        let centerHorizontalButton = UIButton()
        centerHorizontalButton.frame = CGRect(x: 16, y: sepLabel3.frame.maxY + 5, width: widthCenterButton, height: printDirectButton1.frame.height)
        centerHorizontalButton.setTitle(MHTBase.internationalStringWith(str: "水平位置居中"), for: UIControlState.normal)
        centerHorizontalButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        centerHorizontalButton.setTitleColor(SYS_Color, for: UIControlState.highlighted)
        centerHorizontalButton.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.normal)
        centerHorizontalButton.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.highlighted)
        self.propertyScrollView.addSubview(centerHorizontalButton)
        
        // 垂直居中
        let centerVaticalButton = UIButton()
        centerVaticalButton.frame = CGRect(x: centerHorizontalButton.frame.maxX + 16, y: centerHorizontalButton.frame.minY, width: widthCenterButton, height: centerHorizontalButton.frame.height)
        centerVaticalButton.setTitle(MHTBase.internationalStringWith(str: "垂直位置居中"), for: UIControlState.normal)
        centerVaticalButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        centerVaticalButton.setTitleColor(SYS_Color, for: UIControlState.highlighted)
        centerVaticalButton.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.normal)
        centerVaticalButton.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.highlighted)
        self.propertyScrollView.addSubview(centerVaticalButton)
        
        let sepLabel4 = UILabel(frame: CGRect.init(x: CGFloat(0), y: centerHorizontalButton.frame.maxY + 5, width: normalWidth, height: CGFloat(0.5)))
        sepLabel4.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel4)
        
        // 位置上
        let topPositionLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel4.frame.maxY, width: CGFloat(80), height: normalHeight))
        topPositionLabel.text = "  " + MHTBase.internationalStringWith(str: "位置-上")
        self.propertyScrollView.addSubview(topPositionLabel)
        
        let topPositionTextField = UITextField(frame: CGRect.init(x: topPositionLabel.frame.maxX + 16, y: topPositionLabel.frame.minY, width: normalWidth - nameLabel.frame.width - 16 - 16 - 80 - 10, height: normalHeight))
        topPositionTextField.delegate = self
        topPositionTextField.text = "0"
        topPositionTextField.textAlignment = NSTextAlignment.right
        topPositionTextField.textColor = SYS_LIGHT_GREY
        self.propertyScrollView.addSubview(topPositionTextField)
        
        let topPositionAddButton = UIButton()
        topPositionAddButton.frame = CGRect(x: topPositionTextField.frame.maxX + 5, y: topPositionTextField.frame.minY + 5, width: 40, height: 30)
        topPositionAddButton.setTitle("+", for: UIControlState.normal)
        topPositionAddButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        topPositionAddButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        topPositionAddButton.tintColor = SYS_Color
        topPositionAddButton.layer.cornerRadius = 4
        topPositionAddButton.layer.borderColor = SYS_Color.cgColor
        topPositionAddButton.layer.borderWidth = 1
        self.propertyScrollView.addSubview(topPositionAddButton)
        
        let topPositionReduceButton = UIButton()
        topPositionReduceButton.frame = CGRect(x: topPositionAddButton.frame.maxX + 5, y: topPositionTextField.frame.minY + 5, width: 40, height: 30)
        topPositionReduceButton.setTitle("-", for: UIControlState.normal)
        topPositionReduceButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        topPositionReduceButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        topPositionReduceButton.tintColor = SYS_Color
        topPositionReduceButton.layer.cornerRadius = 4
        topPositionReduceButton.layer.borderColor = SYS_Color.cgColor
        topPositionReduceButton.layer.borderWidth = 1
        self.propertyScrollView.addSubview(topPositionReduceButton)
        
        let sepLabel5 = UILabel(frame: CGRect.init(x: CGFloat(0), y: topPositionLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel5.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel5)
        
        // 位置左
        let leftPositionLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel5.frame.maxY, width: CGFloat(80), height: normalHeight))
        leftPositionLabel.text = "  " + MHTBase.internationalStringWith(str: "位置-左")
        self.propertyScrollView.addSubview(leftPositionLabel)
        
        let leftPositionTextField = UITextField(frame: CGRect.init(x: leftPositionLabel.frame.maxX + 16, y: leftPositionLabel.frame.minY, width: normalWidth - nameLabel.frame.width - 16 - 16 - 80 - 10, height: normalHeight))
        leftPositionTextField.delegate = self
        leftPositionTextField.text = "0"
        leftPositionTextField.textAlignment = NSTextAlignment.right
        leftPositionTextField.textColor = SYS_LIGHT_GREY
        self.propertyScrollView.addSubview(leftPositionTextField)
        
        let leftPositionAddButton = UIButton()
        leftPositionAddButton.frame = CGRect(x: leftPositionTextField.frame.maxX + 5, y: leftPositionTextField.frame.minY + 5, width: 40, height: 30)
        leftPositionAddButton.setTitle("+", for: UIControlState.normal)
        leftPositionAddButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        leftPositionAddButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        leftPositionAddButton.tintColor = SYS_Color
        leftPositionAddButton.layer.cornerRadius = 4
        leftPositionAddButton.layer.borderColor = SYS_Color.cgColor
        leftPositionAddButton.layer.borderWidth = 1
        self.propertyScrollView.addSubview(leftPositionAddButton)
        
        let leftPositionReduceButton = UIButton()
        leftPositionReduceButton.frame = CGRect(x: leftPositionAddButton.frame.maxX + 5, y: leftPositionAddButton.frame.minY, width: 40, height: 30)
        leftPositionReduceButton.setTitle("-", for: UIControlState.normal)
        leftPositionReduceButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        leftPositionReduceButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        leftPositionReduceButton.tintColor = SYS_Color
        leftPositionReduceButton.layer.cornerRadius = 4
        leftPositionReduceButton.layer.borderColor = SYS_Color.cgColor
        leftPositionReduceButton.layer.borderWidth = 1
        self.propertyScrollView.addSubview(leftPositionReduceButton)
        
        let sepLabel6 = UILabel(frame: CGRect.init(x: CGFloat(0), y: leftPositionLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel6.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel6)
        
        // 文本
        let textLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel6.frame.maxY, width: normalWidth, height: normalHeight))
        textLabel.backgroundColor = SYS_LIGHT_GREY
        textLabel.text = "  " + MHTBase.internationalStringWith(str: "文本")
        self.propertyScrollView.addSubview(textLabel)
        
        // 字间距
        let wordSpaceLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: textLabel.frame.maxY, width: CGFloat(80), height: normalHeight))
        wordSpaceLabel.text = "  " + MHTBase.internationalStringWith(str: "字间距")
        self.propertyScrollView.addSubview(wordSpaceLabel)
        
        let wordSpaceTextField = UITextField(frame: CGRect.init(x: wordSpaceLabel.frame.maxX + 16, y: wordSpaceLabel.frame.minY, width: normalWidth - nameLabel.frame.width - 16 - 16 - 80 - 10, height: normalHeight))
        wordSpaceTextField.delegate = self
        wordSpaceTextField.text = "0.01"
        wordSpaceTextField.textAlignment = NSTextAlignment.right
        wordSpaceTextField.textColor = SYS_LIGHT_GREY
        self.propertyScrollView.addSubview(wordSpaceTextField)
        
        let wordSpaceAddButton = UIButton()
        wordSpaceAddButton.frame = CGRect(x: wordSpaceTextField.frame.maxX + 5, y: wordSpaceTextField.frame.minY + 5, width: 40, height: 30)
        wordSpaceAddButton.setTitle("+", for: UIControlState.normal)
        wordSpaceAddButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        wordSpaceAddButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        wordSpaceAddButton.tintColor = SYS_Color
        wordSpaceAddButton.layer.cornerRadius = 4
        wordSpaceAddButton.layer.borderColor = SYS_Color.cgColor
        wordSpaceAddButton.layer.borderWidth = 1
        self.propertyScrollView.addSubview(wordSpaceAddButton)
        
        let wordSpaceReduceButton = UIButton()
        wordSpaceReduceButton.frame = CGRect(x: wordSpaceAddButton.frame.maxX + 5, y: wordSpaceAddButton.frame.minY, width: 40, height: 30)
        wordSpaceReduceButton.setTitle("-", for: UIControlState.normal)
        wordSpaceReduceButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        wordSpaceReduceButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        wordSpaceReduceButton.tintColor = SYS_Color
        wordSpaceReduceButton.layer.cornerRadius = 4
        wordSpaceReduceButton.layer.borderColor = SYS_Color.cgColor
        wordSpaceReduceButton.layer.borderWidth = 1
        self.propertyScrollView.addSubview(wordSpaceReduceButton)
        
        let sepLabel7 = UILabel(frame: CGRect.init(x: CGFloat(0), y: wordSpaceLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel7.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel7)
        
        // 行间距
        let lineSpaceLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel7.frame.maxY, width: CGFloat(80), height: normalHeight))
        lineSpaceLabel.text = "  " + MHTBase.internationalStringWith(str: "行间距")
        self.propertyScrollView.addSubview(lineSpaceLabel)
        
        let lineSpaceTextField = UITextField(frame: CGRect.init(x: lineSpaceLabel.frame.maxX + 16, y: lineSpaceLabel.frame.minY, width: normalWidth - lineSpaceLabel.frame.width - 16 - 16, height: normalHeight))
        lineSpaceTextField.delegate = self
        lineSpaceTextField.placeholder = MHTBase.internationalStringWith(str: "0.0mm")
        lineSpaceTextField.isUserInteractionEnabled = false
        lineSpaceTextField.textAlignment = NSTextAlignment.right
        lineSpaceTextField.textColor = SYS_LIGHT_GREY
        self.propertyScrollView.addSubview(lineSpaceTextField)
        
        let buttonLineSapceGap = CGFloat(10)
        let buttonLineSpaceWidth = (normalWidth - 6 * buttonLineSapceGap) / 5
        let lineSpaceButton1 = UIButton()
        lineSpaceButton1.frame = CGRect.init(x: buttonLineSapceGap, y: lineSpaceLabel.frame.maxY + 5, width: buttonLineSpaceWidth, height: normalHeight - 10)
        lineSpaceButton1.setTitle(MHTBase.internationalStringWith(str: "1.0倍"), for: UIControlState.normal)
        lineSpaceButton1.layer.borderWidth = 1
        lineSpaceButton1.layer.borderColor = SYS_Color.cgColor
        lineSpaceButton1.layer.cornerRadius = 4
        lineSpaceButton1.imageView?.layer.cornerRadius = 4
        lineSpaceButton1.clipsToBounds = true
        lineSpaceButton1.setTitleColor(UIColor.black, for: UIControlState.normal)
        lineSpaceButton1.setTitleColor(UIColor.white, for: UIControlState.selected)
        lineSpaceButton1.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        lineSpaceButton1.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        lineSpaceButton1.isSelected = self.dataSource.printingDirection == 0
        self.propertyScrollView.addSubview(lineSpaceButton1)
        
        let lineSpaceButton2 = UIButton()
        lineSpaceButton2.frame = CGRect.init(x: lineSpaceButton1.frame.maxX + buttonLineSapceGap, y: lineSpaceButton1.frame.minY, width: lineSpaceButton1.frame.width, height: lineSpaceButton1.frame.height)
        lineSpaceButton2.setTitle(MHTBase.internationalStringWith(str: "1.2倍"), for: UIControlState.normal)
        lineSpaceButton2.layer.borderWidth = 1
        lineSpaceButton2.layer.borderColor = SYS_Color.cgColor
        lineSpaceButton2.layer.cornerRadius = 4
        lineSpaceButton2.imageView?.layer.cornerRadius = 4
        lineSpaceButton2.clipsToBounds = true
        lineSpaceButton2.setTitleColor(UIColor.black, for: UIControlState.normal)
        lineSpaceButton2.setTitleColor(UIColor.white, for: UIControlState.selected)
        lineSpaceButton2.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        lineSpaceButton2.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        lineSpaceButton2.isSelected = self.dataSource.printingDirection == 90
        self.propertyScrollView.addSubview(lineSpaceButton2)
        
        let lineSpaceButton3 = UIButton()
        lineSpaceButton3.frame = CGRect.init(x: lineSpaceButton2.frame.maxX + buttonLineSapceGap, y: lineSpaceButton1.frame.minY, width: lineSpaceButton1.frame.width, height: lineSpaceButton1.frame.height)
        lineSpaceButton3.setTitle(MHTBase.internationalStringWith(str: "1.5倍"), for: UIControlState.normal)
        lineSpaceButton3.layer.borderWidth = 1
        lineSpaceButton3.layer.borderColor = SYS_Color.cgColor
        lineSpaceButton3.layer.cornerRadius = 4
        lineSpaceButton3.imageView?.layer.cornerRadius = 4
        lineSpaceButton3.clipsToBounds = true
        lineSpaceButton3.setTitleColor(UIColor.black, for: UIControlState.normal)
        lineSpaceButton3.setTitleColor(UIColor.white, for: UIControlState.selected)
        lineSpaceButton3.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        lineSpaceButton3.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        lineSpaceButton3.isSelected = self.dataSource.printingDirection == 180
        self.propertyScrollView.addSubview(lineSpaceButton3)
        
        let lineSpaceButton4 = UIButton()
        lineSpaceButton4.frame = CGRect.init(x: lineSpaceButton3.frame.maxX + buttonGap, y: lineSpaceButton1.frame.minY, width: lineSpaceButton1.frame.width, height: lineSpaceButton1.frame.height)
        lineSpaceButton4.setTitle(MHTBase.internationalStringWith(str: "2.0倍"), for: UIControlState.normal)
        lineSpaceButton4.layer.borderWidth = 1
        lineSpaceButton4.layer.borderColor = SYS_Color.cgColor
        lineSpaceButton4.layer.cornerRadius = 4
        lineSpaceButton4.imageView?.layer.cornerRadius = 4
        lineSpaceButton4.clipsToBounds = true
        lineSpaceButton4.setTitleColor(UIColor.black, for: UIControlState.normal)
        lineSpaceButton4.setTitleColor(UIColor.white, for: UIControlState.selected)
        lineSpaceButton4.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        lineSpaceButton4.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        lineSpaceButton4.isSelected = self.dataSource.printingDirection == 270
        self.propertyScrollView.addSubview(lineSpaceButton4)
        
        let lineSpaceButton5 = UIButton()
        lineSpaceButton5.frame = CGRect.init(x: lineSpaceButton4.frame.maxX + buttonGap, y: lineSpaceButton1.frame.minY, width: lineSpaceButton1.frame.width, height: lineSpaceButton1.frame.height)
        lineSpaceButton5.setTitle(MHTBase.internationalStringWith(str: "自定义"), for: UIControlState.normal)
        lineSpaceButton5.layer.borderWidth = 1
        lineSpaceButton5.layer.borderColor = SYS_Color.cgColor
        lineSpaceButton5.layer.cornerRadius = 4
        lineSpaceButton5.imageView?.layer.cornerRadius = 4
        lineSpaceButton5.clipsToBounds = true
        lineSpaceButton5.setTitleColor(UIColor.black, for: UIControlState.normal)
        lineSpaceButton5.setTitleColor(UIColor.white, for: UIControlState.selected)
        lineSpaceButton5.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        lineSpaceButton5.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        lineSpaceButton5.isSelected = self.dataSource.printingDirection == 270
        self.propertyScrollView.addSubview(lineSpaceButton5)
        
        let sepLabel8 = UILabel(frame: CGRect.init(x: CGFloat(0), y: lineSpaceButton1.frame.maxY + 5, width: normalWidth, height: CGFloat(0.5)))
        sepLabel8.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel8)
        
        // 字体大小
        let wordSizeLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel8.frame.maxY, width: CGFloat(80), height: normalHeight))
        wordSizeLabel.text = "  " + MHTBase.internationalStringWith(str: "字体大小")
        self.propertyScrollView.addSubview(wordSizeLabel)
        
        let wordSizeTextField = UITextField(frame: CGRect.init(x: wordSizeLabel.frame.maxX + 16, y: wordSizeLabel.frame.minY, width: normalWidth - nameLabel.frame.width - 16 - 16 - 80 - 10, height: normalHeight))
        wordSizeTextField.delegate = self
        wordSizeTextField.text = "60"
        wordSizeTextField.textAlignment = NSTextAlignment.right
        wordSizeTextField.textColor = SYS_LIGHT_GREY
        self.propertyScrollView.addSubview(wordSizeTextField)
        
        let wordSizeAddButton = UIButton()
        wordSizeAddButton.frame = CGRect(x: wordSizeTextField.frame.maxX + 5, y: wordSizeTextField.frame.minY + 5, width: 40, height: 30)
        wordSizeAddButton.setTitle("+", for: UIControlState.normal)
        wordSizeAddButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        wordSizeAddButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        wordSizeAddButton.tintColor = SYS_Color
        wordSizeAddButton.layer.cornerRadius = 4
        wordSizeAddButton.layer.borderColor = SYS_Color.cgColor
        wordSizeAddButton.layer.borderWidth = 1
        self.propertyScrollView.addSubview(wordSizeAddButton)
        
        let wordSizeReduceButton = UIButton()
        wordSizeReduceButton.frame = CGRect(x: wordSizeAddButton.frame.maxX + 5, y: wordSizeAddButton.frame.minY, width: 40, height: 30)
        wordSizeReduceButton.setTitle("-", for: UIControlState.normal)
        wordSizeReduceButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        wordSizeReduceButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        wordSizeReduceButton.tintColor = SYS_Color
        wordSizeReduceButton.layer.cornerRadius = 4
        wordSizeReduceButton.layer.borderColor = SYS_Color.cgColor
        wordSizeReduceButton.layer.borderWidth = 1
        self.propertyScrollView.addSubview(wordSizeReduceButton)
        
        let sepLabel9 = UILabel(frame: CGRect.init(x: CGFloat(0), y: wordSizeLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel9.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel9)
        
        // 序列化
        let serielLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel9.frame.maxY, width: normalWidth, height: normalHeight))
        serielLabel.backgroundColor = SYS_LIGHT_GREY
        serielLabel.text = "  " + MHTBase.internationalStringWith(str: "序列化")
        self.propertyScrollView.addSubview(serielLabel)
        
        // 序列化
        let serielLineLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: serielLabel.frame.maxY, width: CGFloat(80), height: normalHeight))
        serielLineLabel.text = "  " + MHTBase.internationalStringWith(str: "序列化")
        self.propertyScrollView.addSubview(serielLineLabel)
        
        let serielButton1 = UIButton()
        serielButton1.frame = CGRect.init(x: serielLineLabel.frame.maxX + 16, y: serielLineLabel.frame.minY + 5, width: buttonWidth, height: normalHeight - 10)
        serielButton1.setTitle("无", for: UIControlState.normal)
        serielButton1.layer.borderWidth = 1
        serielButton1.layer.borderColor = SYS_Color.cgColor
        serielButton1.layer.cornerRadius = 4
        serielButton1.imageView?.layer.cornerRadius = 4
        serielButton1.clipsToBounds = true
        serielButton1.setTitleColor(UIColor.black, for: UIControlState.normal)
        serielButton1.setTitleColor(UIColor.white, for: UIControlState.selected)
        serielButton1.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        serielButton1.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        serielButton1.isSelected = self.dataSource.printingDirection == 0
        self.propertyScrollView.addSubview(serielButton1)
        
        let serielButton2 = UIButton()
        serielButton2.frame = CGRect.init(x: serielButton1.frame.maxX + buttonGap, y: serielButton1.frame.minY, width: serielButton1.frame.width, height: serielButton1.frame.height)
        serielButton2.setTitle("递变", for: UIControlState.normal)
        serielButton2.layer.borderWidth = 1
        serielButton2.layer.borderColor = SYS_Color.cgColor
        serielButton2.layer.cornerRadius = 4
        serielButton2.imageView?.layer.cornerRadius = 4
        serielButton2.clipsToBounds = true
        serielButton2.setTitleColor(UIColor.black, for: UIControlState.normal)
        serielButton2.setTitleColor(UIColor.white, for: UIControlState.selected)
        serielButton2.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        serielButton2.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        serielButton2.isSelected = self.dataSource.printingDirection == 90
        self.propertyScrollView.addSubview(serielButton2)
        
        let serielButton3 = UIButton()
        serielButton3.frame = CGRect.init(x: serielButton2.frame.maxX + buttonGap, y: serielButton1.frame.minY, width: serielButton1.frame.width, height: serielButton1.frame.height)
        serielButton3.setTitle("文件", for: UIControlState.normal)
        serielButton3.layer.borderWidth = 1
        serielButton3.layer.borderColor = SYS_Color.cgColor
        serielButton3.layer.cornerRadius = 4
        serielButton3.imageView?.layer.cornerRadius = 4
        serielButton3.clipsToBounds = true
        serielButton3.setTitleColor(UIColor.black, for: UIControlState.normal)
        serielButton3.setTitleColor(UIColor.white, for: UIControlState.selected)
        serielButton3.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        serielButton3.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        serielButton3.isSelected = self.dataSource.printingDirection == 180
        self.propertyScrollView.addSubview(serielButton3)
        
        self.propertyScrollView.contentSize = CGSize(width: normalWidth, height: serielLineLabel.frame.maxY)
    }
    
    func createTextElementViewPropertyView(view: TextElementView) -> Void {
        // 保存下标
        self.viewSelectedElement = view
        let model = self.dataSource.textControl![view.controlIndex!]
        
        // 通用高度
        let normalHeight = CGFloat(40)
        let normalWidth = self.propertyScrollView.frame.width
        
        // 名称
        let nameLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: CGFloat(0), width: CGFloat(80), height: normalHeight))
        nameLabel.text = "  " + MHTBase.internationalStringWith(str: "名称")
        self.propertyScrollView.addSubview(nameLabel)
        
        // 名称输入框，不可以编辑
        let nameTextField = UITextField(frame: CGRect.init(x: nameLabel.frame.maxX + 16, y: nameLabel.frame.minY, width: normalWidth - nameLabel.frame.width - 16 - 16, height: normalHeight))
        nameTextField.delegate = self
        nameTextField.placeholder = MHTBase.internationalStringWith(str: "文本")
        nameTextField.isUserInteractionEnabled = false
        nameTextField.textAlignment = NSTextAlignment.right
        nameTextField.textColor = SYS_LIGHT_GREY
        self.propertyScrollView.addSubview(nameTextField)
        
        // 分隔线
        let sepLabel1 = UILabel(frame: CGRect.init(x: CGFloat(0), y: nameLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel1.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel1)
        
        // 旋转角度
        let printDirectLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel1.frame.maxY, width: CGFloat(80), height: normalHeight))
        printDirectLabel.text = "  " + MHTBase.internationalStringWith(str: "旋转角度")
        self.propertyScrollView.addSubview(printDirectLabel)
        
        let buttonGap = CGFloat(10)
        let buttonLeftWidth = normalWidth - 16 - 16
        let buttonWidth = (buttonLeftWidth - printDirectLabel.frame.width - 3 * buttonGap) / 4
        let printDirectButton1 = UIButton()
        printDirectButton1.frame = CGRect.init(x: printDirectLabel.frame.maxX + 16, y: printDirectLabel.frame.minY + 5, width: buttonWidth, height: normalHeight - 10)
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
        printDirectButton1.isSelected = model.rotate! == 0
        printDirectButton1.tag = 4000 + 0
        self.propertyScrollView.addSubview(printDirectButton1)
        printDirectButton1.addTarget(self, action: #selector(rotationalDirectionTextElement(sender:)), for: UIControlEvents.touchUpInside)
        
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
        printDirectButton2.isSelected = model.rotate! == 90
        printDirectButton2.tag = 4000 + 90
        self.propertyScrollView.addSubview(printDirectButton2)
        printDirectButton2.addTarget(self, action: #selector(rotationalDirectionTextElement(sender:)), for: UIControlEvents.touchUpInside)
        
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
        printDirectButton3.isSelected = model.rotate! == 180
        printDirectButton3.tag = 4000 + 180
        self.propertyScrollView.addSubview(printDirectButton3)
        printDirectButton3.addTarget(self, action: #selector(rotationalDirectionTextElement(sender:)), for: UIControlEvents.touchUpInside)
        
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
        printDirectButton4.isSelected = model.rotate! == 270
        printDirectButton4.tag = 4000 + 270
        self.propertyScrollView.addSubview(printDirectButton4)
        printDirectButton4.addTarget(self, action: #selector(rotationalDirectionTextElement(sender:)), for: UIControlEvents.touchUpInside)
        
        // 分隔线
        let sepLabel2 = UILabel(frame: CGRect.init(x: CGFloat(0), y: printDirectLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel2.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel2)
        
        // 位置大小标题
        let titleLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel2.frame.maxY, width: normalWidth, height: normalHeight))
        titleLabel.backgroundColor = SYS_LIGHT_GREY
        titleLabel.text = "  " + MHTBase.internationalStringWith(str: "位置大小")
        self.propertyScrollView.addSubview(titleLabel)
        
        // 分隔线
        let sepLabel3 = UILabel(frame: CGRect.init(x: CGFloat(0), y: titleLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel3.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel3)
        
        // 立平居中
        let widthCenterButton = (normalWidth - 3 * 16) / 2
        let centerHorizontalButton = UIButton()
        centerHorizontalButton.frame = CGRect(x: 16, y: sepLabel3.frame.maxY + 5, width: widthCenterButton, height: printDirectButton1.frame.height)
        centerHorizontalButton.setTitle(MHTBase.internationalStringWith(str: "水平位置居中"), for: UIControlState.normal)
        centerHorizontalButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        centerHorizontalButton.setTitleColor(SYS_Color, for: UIControlState.highlighted)
        centerHorizontalButton.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.normal)
        centerHorizontalButton.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.highlighted)
        centerHorizontalButton.tag = 50
        self.propertyScrollView.addSubview(centerHorizontalButton)
        centerHorizontalButton.addTarget(self, action: #selector(positionChangeElement(sender:)), for: UIControlEvents.touchUpInside)
        
        // 垂直居中
        let centerVaticalButton = UIButton()
        centerVaticalButton.frame = CGRect(x: centerHorizontalButton.frame.maxX + 16, y: centerHorizontalButton.frame.minY, width: widthCenterButton, height: centerHorizontalButton.frame.height)
        centerVaticalButton.setTitle(MHTBase.internationalStringWith(str: "垂直位置居中"), for: UIControlState.normal)
        centerVaticalButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        centerVaticalButton.setTitleColor(SYS_Color, for: UIControlState.highlighted)
        centerVaticalButton.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.normal)
        centerVaticalButton.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.highlighted)
        centerVaticalButton.tag = 55
        self.propertyScrollView.addSubview(centerVaticalButton)
        centerVaticalButton.addTarget(self, action: #selector(positionChangeElement(sender:)), for: UIControlEvents.touchUpInside)
        
        let sepLabel4 = UILabel(frame: CGRect.init(x: CGFloat(0), y: centerHorizontalButton.frame.maxY + 5, width: normalWidth, height: CGFloat(0.5)))
        sepLabel4.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel4)
        
        // 位置上
        let topPositionLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel4.frame.maxY, width: CGFloat(80), height: normalHeight))
        topPositionLabel.text = "  " + MHTBase.internationalStringWith(str: "位置-上")
        self.propertyScrollView.addSubview(topPositionLabel)
        
        let topPositionTextField = UITextField(frame: CGRect.init(x: topPositionLabel.frame.maxX + 16, y: topPositionLabel.frame.minY, width: normalWidth - nameLabel.frame.width - 16 - 16 - 80 - 10, height: normalHeight))
        topPositionTextField.delegate = self
        topPositionTextField.text = view.frame.minY.description
        topPositionTextField.textAlignment = NSTextAlignment.right
        topPositionTextField.textColor = SYS_LIGHT_GREY
        topPositionTextField.tag = 63
        topPositionTextField.isUserInteractionEnabled = false
        self.propertyScrollView.addSubview(topPositionTextField)
        
        let topPositionAddButton = UIButton()
        topPositionAddButton.frame = CGRect(x: topPositionTextField.frame.maxX + 5, y: topPositionTextField.frame.minY + 5, width: 40, height: 30)
        topPositionAddButton.setTitle("+", for: UIControlState.normal)
        topPositionAddButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        topPositionAddButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        topPositionAddButton.tintColor = SYS_Color
        topPositionAddButton.layer.cornerRadius = 4
        topPositionAddButton.layer.borderColor = SYS_Color.cgColor
        topPositionAddButton.layer.borderWidth = 1
        topPositionAddButton.tag = 60
        self.propertyScrollView.addSubview(topPositionAddButton)
        topPositionAddButton.addTarget(self, action: #selector(xypointChangeAction(sender:)), for: UIControlEvents.touchUpInside)
        
        let topPositionReduceButton = UIButton()
        topPositionReduceButton.frame = CGRect(x: topPositionAddButton.frame.maxX + 5, y: topPositionTextField.frame.minY + 5, width: 40, height: 30)
        topPositionReduceButton.setTitle("-", for: UIControlState.normal)
        topPositionReduceButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        topPositionReduceButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        topPositionReduceButton.tintColor = SYS_Color
        topPositionReduceButton.layer.cornerRadius = 4
        topPositionReduceButton.layer.borderColor = SYS_Color.cgColor
        topPositionReduceButton.layer.borderWidth = 1
        topPositionReduceButton.tag = 65
        self.propertyScrollView.addSubview(topPositionReduceButton)
        topPositionReduceButton.addTarget(self, action: #selector(xypointChangeAction(sender:)), for: UIControlEvents.touchUpInside)
        
        let sepLabel5 = UILabel(frame: CGRect.init(x: CGFloat(0), y: topPositionLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel5.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel5)
        
        // 位置左
        let leftPositionLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel5.frame.maxY, width: CGFloat(80), height: normalHeight))
        leftPositionLabel.text = "  " + MHTBase.internationalStringWith(str: "位置-左")
        self.propertyScrollView.addSubview(leftPositionLabel)
        
        let leftPositionTextField = UITextField(frame: CGRect.init(x: leftPositionLabel.frame.maxX + 16, y: leftPositionLabel.frame.minY, width: normalWidth - nameLabel.frame.width - 16 - 16 - 80 - 10, height: normalHeight))
        leftPositionTextField.delegate = self
        leftPositionTextField.text = view.frame.minX.description
        leftPositionTextField.textAlignment = NSTextAlignment.right
        leftPositionTextField.textColor = SYS_LIGHT_GREY
        leftPositionTextField.tag = 73
        leftPositionTextField.isUserInteractionEnabled = false
        self.propertyScrollView.addSubview(leftPositionTextField)
        
        let leftPositionAddButton = UIButton()
        leftPositionAddButton.frame = CGRect(x: leftPositionTextField.frame.maxX + 5, y: leftPositionTextField.frame.minY + 5, width: 40, height: 30)
        leftPositionAddButton.setTitle("+", for: UIControlState.normal)
        leftPositionAddButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        leftPositionAddButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        leftPositionAddButton.tintColor = SYS_Color
        leftPositionAddButton.layer.cornerRadius = 4
        leftPositionAddButton.layer.borderColor = SYS_Color.cgColor
        leftPositionAddButton.layer.borderWidth = 1
        leftPositionAddButton.tag = 70
        self.propertyScrollView.addSubview(leftPositionAddButton)
        leftPositionAddButton.addTarget(self, action: #selector(xypointChangeAction(sender:)), for: UIControlEvents.touchUpInside)
        
        let leftPositionReduceButton = UIButton()
        leftPositionReduceButton.frame = CGRect(x: leftPositionAddButton.frame.maxX + 5, y: leftPositionAddButton.frame.minY, width: 40, height: 30)
        leftPositionReduceButton.setTitle("-", for: UIControlState.normal)
        leftPositionReduceButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        leftPositionReduceButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        leftPositionReduceButton.tintColor = SYS_Color
        leftPositionReduceButton.layer.cornerRadius = 4
        leftPositionReduceButton.layer.borderColor = SYS_Color.cgColor
        leftPositionReduceButton.layer.borderWidth = 1
        leftPositionReduceButton.tag = 75
        self.propertyScrollView.addSubview(leftPositionReduceButton)
        leftPositionReduceButton.addTarget(self, action: #selector(xypointChangeAction(sender:)), for: UIControlEvents.touchUpInside)
        
        let sepLabel6 = UILabel(frame: CGRect.init(x: CGFloat(0), y: leftPositionLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel6.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel6)
        
        // 文本
        let textLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel6.frame.maxY, width: normalWidth, height: normalHeight))
        textLabel.backgroundColor = SYS_LIGHT_GREY
        textLabel.text = "  " + MHTBase.internationalStringWith(str: "文本")
        self.propertyScrollView.addSubview(textLabel)
        
        // 字间距
        let wordSpaceLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: textLabel.frame.maxY, width: CGFloat(80), height: normalHeight))
        wordSpaceLabel.text = "  " + MHTBase.internationalStringWith(str: "字间距")
        self.propertyScrollView.addSubview(wordSpaceLabel)
        
        let wordSpaceTextField = UITextField(frame: CGRect.init(x: wordSpaceLabel.frame.maxX + 16, y: wordSpaceLabel.frame.minY, width: normalWidth - nameLabel.frame.width - 16 - 16 - 80 - 10, height: normalHeight))
        wordSpaceTextField.delegate = self
        wordSpaceTextField.text = "0.01"
        wordSpaceTextField.textAlignment = NSTextAlignment.right
        wordSpaceTextField.textColor = SYS_LIGHT_GREY
        self.propertyScrollView.addSubview(wordSpaceTextField)
        
        let wordSpaceAddButton = UIButton()
        wordSpaceAddButton.frame = CGRect(x: wordSpaceTextField.frame.maxX + 5, y: wordSpaceTextField.frame.minY + 5, width: 40, height: 30)
        wordSpaceAddButton.setTitle("+", for: UIControlState.normal)
        wordSpaceAddButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        wordSpaceAddButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        wordSpaceAddButton.tintColor = SYS_Color
        wordSpaceAddButton.layer.cornerRadius = 4
        wordSpaceAddButton.layer.borderColor = SYS_Color.cgColor
        wordSpaceAddButton.layer.borderWidth = 1
        self.propertyScrollView.addSubview(wordSpaceAddButton)
        
        let wordSpaceReduceButton = UIButton()
        wordSpaceReduceButton.frame = CGRect(x: wordSpaceAddButton.frame.maxX + 5, y: wordSpaceAddButton.frame.minY, width: 40, height: 30)
        wordSpaceReduceButton.setTitle("-", for: UIControlState.normal)
        wordSpaceReduceButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        wordSpaceReduceButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        wordSpaceReduceButton.tintColor = SYS_Color
        wordSpaceReduceButton.layer.cornerRadius = 4
        wordSpaceReduceButton.layer.borderColor = SYS_Color.cgColor
        wordSpaceReduceButton.layer.borderWidth = 1
        self.propertyScrollView.addSubview(wordSpaceReduceButton)
        
        let sepLabel7 = UILabel(frame: CGRect.init(x: CGFloat(0), y: wordSpaceLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel7.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel7)
        
        // 行间距
        let lineSpaceLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel7.frame.maxY, width: CGFloat(80), height: normalHeight))
        lineSpaceLabel.text = "  " + MHTBase.internationalStringWith(str: "行间距")
        self.propertyScrollView.addSubview(lineSpaceLabel)
        
        let lineSpaceTextField = UITextField(frame: CGRect.init(x: lineSpaceLabel.frame.maxX + 16, y: lineSpaceLabel.frame.minY, width: normalWidth - lineSpaceLabel.frame.width - 16 - 16, height: normalHeight))
        lineSpaceTextField.delegate = self
        lineSpaceTextField.placeholder = MHTBase.internationalStringWith(str: "0.0mm")
        lineSpaceTextField.isUserInteractionEnabled = false
        lineSpaceTextField.textAlignment = NSTextAlignment.right
        lineSpaceTextField.textColor = SYS_LIGHT_GREY
        self.propertyScrollView.addSubview(lineSpaceTextField)
        
        let buttonLineSapceGap = CGFloat(10)
        let buttonLineSpaceWidth = (normalWidth - 6 * buttonLineSapceGap) / 5
        let lineSpaceButton1 = UIButton()
        lineSpaceButton1.frame = CGRect.init(x: buttonLineSapceGap, y: lineSpaceLabel.frame.maxY + 5, width: buttonLineSpaceWidth, height: normalHeight - 10)
        lineSpaceButton1.setTitle(MHTBase.internationalStringWith(str: "1.0倍"), for: UIControlState.normal)
        lineSpaceButton1.layer.borderWidth = 1
        lineSpaceButton1.layer.borderColor = SYS_Color.cgColor
        lineSpaceButton1.layer.cornerRadius = 4
        lineSpaceButton1.imageView?.layer.cornerRadius = 4
        lineSpaceButton1.clipsToBounds = true
        lineSpaceButton1.setTitleColor(UIColor.black, for: UIControlState.normal)
        lineSpaceButton1.setTitleColor(UIColor.white, for: UIControlState.selected)
        lineSpaceButton1.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        lineSpaceButton1.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        lineSpaceButton1.isSelected = self.dataSource.printingDirection == 0
        self.propertyScrollView.addSubview(lineSpaceButton1)
        
        let lineSpaceButton2 = UIButton()
        lineSpaceButton2.frame = CGRect.init(x: lineSpaceButton1.frame.maxX + buttonLineSapceGap, y: lineSpaceButton1.frame.minY, width: lineSpaceButton1.frame.width, height: lineSpaceButton1.frame.height)
        lineSpaceButton2.setTitle(MHTBase.internationalStringWith(str: "1.2倍"), for: UIControlState.normal)
        lineSpaceButton2.layer.borderWidth = 1
        lineSpaceButton2.layer.borderColor = SYS_Color.cgColor
        lineSpaceButton2.layer.cornerRadius = 4
        lineSpaceButton2.imageView?.layer.cornerRadius = 4
        lineSpaceButton2.clipsToBounds = true
        lineSpaceButton2.setTitleColor(UIColor.black, for: UIControlState.normal)
        lineSpaceButton2.setTitleColor(UIColor.white, for: UIControlState.selected)
        lineSpaceButton2.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        lineSpaceButton2.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        lineSpaceButton2.isSelected = self.dataSource.printingDirection == 90
        self.propertyScrollView.addSubview(lineSpaceButton2)
        
        let lineSpaceButton3 = UIButton()
        lineSpaceButton3.frame = CGRect.init(x: lineSpaceButton2.frame.maxX + buttonLineSapceGap, y: lineSpaceButton1.frame.minY, width: lineSpaceButton1.frame.width, height: lineSpaceButton1.frame.height)
        lineSpaceButton3.setTitle(MHTBase.internationalStringWith(str: "1.5倍"), for: UIControlState.normal)
        lineSpaceButton3.layer.borderWidth = 1
        lineSpaceButton3.layer.borderColor = SYS_Color.cgColor
        lineSpaceButton3.layer.cornerRadius = 4
        lineSpaceButton3.imageView?.layer.cornerRadius = 4
        lineSpaceButton3.clipsToBounds = true
        lineSpaceButton3.setTitleColor(UIColor.black, for: UIControlState.normal)
        lineSpaceButton3.setTitleColor(UIColor.white, for: UIControlState.selected)
        lineSpaceButton3.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        lineSpaceButton3.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        lineSpaceButton3.isSelected = self.dataSource.printingDirection == 180
        self.propertyScrollView.addSubview(lineSpaceButton3)
        
        let lineSpaceButton4 = UIButton()
        lineSpaceButton4.frame = CGRect.init(x: lineSpaceButton3.frame.maxX + buttonGap, y: lineSpaceButton1.frame.minY, width: lineSpaceButton1.frame.width, height: lineSpaceButton1.frame.height)
        lineSpaceButton4.setTitle(MHTBase.internationalStringWith(str: "2.0倍"), for: UIControlState.normal)
        lineSpaceButton4.layer.borderWidth = 1
        lineSpaceButton4.layer.borderColor = SYS_Color.cgColor
        lineSpaceButton4.layer.cornerRadius = 4
        lineSpaceButton4.imageView?.layer.cornerRadius = 4
        lineSpaceButton4.clipsToBounds = true
        lineSpaceButton4.setTitleColor(UIColor.black, for: UIControlState.normal)
        lineSpaceButton4.setTitleColor(UIColor.white, for: UIControlState.selected)
        lineSpaceButton4.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        lineSpaceButton4.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        lineSpaceButton4.isSelected = self.dataSource.printingDirection == 270
        self.propertyScrollView.addSubview(lineSpaceButton4)
        
        let lineSpaceButton5 = UIButton()
        lineSpaceButton5.frame = CGRect.init(x: lineSpaceButton4.frame.maxX + buttonGap, y: lineSpaceButton1.frame.minY, width: lineSpaceButton1.frame.width, height: lineSpaceButton1.frame.height)
        lineSpaceButton5.setTitle(MHTBase.internationalStringWith(str: "自定义"), for: UIControlState.normal)
        lineSpaceButton5.layer.borderWidth = 1
        lineSpaceButton5.layer.borderColor = SYS_Color.cgColor
        lineSpaceButton5.layer.cornerRadius = 4
        lineSpaceButton5.imageView?.layer.cornerRadius = 4
        lineSpaceButton5.clipsToBounds = true
        lineSpaceButton5.setTitleColor(UIColor.black, for: UIControlState.normal)
        lineSpaceButton5.setTitleColor(UIColor.white, for: UIControlState.selected)
        lineSpaceButton5.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        lineSpaceButton5.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        lineSpaceButton5.isSelected = self.dataSource.printingDirection == 270
        self.propertyScrollView.addSubview(lineSpaceButton5)
        
        let sepLabel8 = UILabel(frame: CGRect.init(x: CGFloat(0), y: lineSpaceButton1.frame.maxY + 5, width: normalWidth, height: CGFloat(0.5)))
        sepLabel8.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel8)
        
        // 字体大小
        let wordSizeLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel8.frame.maxY, width: CGFloat(80), height: normalHeight))
        wordSizeLabel.text = "  " + MHTBase.internationalStringWith(str: "字体大小")
        self.propertyScrollView.addSubview(wordSizeLabel)
        
        let wordSizeTextField = UITextField(frame: CGRect.init(x: wordSizeLabel.frame.maxX + 16, y: wordSizeLabel.frame.minY, width: normalWidth - nameLabel.frame.width - 16 - 16 - 80 - 10, height: normalHeight))
        wordSizeTextField.delegate = self
        wordSizeTextField.text = model.TEXT_SIZE?.description
        wordSizeTextField.textAlignment = NSTextAlignment.right
        wordSizeTextField.textColor = SYS_LIGHT_GREY
        wordSizeTextField.isUserInteractionEnabled = false
        wordSizeTextField.tag = 80
        self.propertyScrollView.addSubview(wordSizeTextField)
        
        let wordSizeAddButton = UIButton()
        wordSizeAddButton.frame = CGRect(x: wordSizeTextField.frame.maxX + 5, y: wordSizeTextField.frame.minY + 5, width: 40, height: 30)
        wordSizeAddButton.setTitle("+", for: UIControlState.normal)
        wordSizeAddButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        wordSizeAddButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        wordSizeAddButton.tintColor = SYS_Color
        wordSizeAddButton.layer.cornerRadius = 4
        wordSizeAddButton.layer.borderColor = SYS_Color.cgColor
        wordSizeAddButton.layer.borderWidth = 1
        wordSizeAddButton.tag = 85
        self.propertyScrollView.addSubview(wordSizeAddButton)
        wordSizeAddButton.addTarget(self, action: #selector(wordSizeChangeAction(sender:)), for: UIControlEvents.touchUpInside)
        
        let wordSizeReduceButton = UIButton()
        wordSizeReduceButton.frame = CGRect(x: wordSizeAddButton.frame.maxX + 5, y: wordSizeAddButton.frame.minY, width: 40, height: 30)
        wordSizeReduceButton.setTitle("-", for: UIControlState.normal)
        wordSizeReduceButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        wordSizeReduceButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        wordSizeReduceButton.tintColor = SYS_Color
        wordSizeReduceButton.layer.cornerRadius = 4
        wordSizeReduceButton.layer.borderColor = SYS_Color.cgColor
        wordSizeReduceButton.layer.borderWidth = 1
        wordSizeReduceButton.tag = 90
        self.propertyScrollView.addSubview(wordSizeReduceButton)
        wordSizeReduceButton.addTarget(self, action: #selector(wordSizeChangeAction(sender:)), for: UIControlEvents.touchUpInside)
        
        let sepLabel9 = UILabel(frame: CGRect.init(x: CGFloat(0), y: wordSizeLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel9.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel9)
        
        // 序列化
        let serielLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel9.frame.maxY, width: normalWidth, height: normalHeight))
        serielLabel.backgroundColor = SYS_LIGHT_GREY
        serielLabel.text = "  " + MHTBase.internationalStringWith(str: "序列化")
        self.propertyScrollView.addSubview(serielLabel)
        
        // 序列化
        let serielLineLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: serielLabel.frame.maxY, width: CGFloat(80), height: normalHeight))
        serielLineLabel.text = "  " + MHTBase.internationalStringWith(str: "序列化")
        self.propertyScrollView.addSubview(serielLineLabel)
        
        let serielButton1 = UIButton()
        serielButton1.frame = CGRect.init(x: serielLineLabel.frame.maxX + 16, y: serielLineLabel.frame.minY + 5, width: buttonWidth, height: normalHeight - 10)
        serielButton1.setTitle("无", for: UIControlState.normal)
        serielButton1.layer.borderWidth = 1
        serielButton1.layer.borderColor = SYS_Color.cgColor
        serielButton1.layer.cornerRadius = 4
        serielButton1.imageView?.layer.cornerRadius = 4
        serielButton1.clipsToBounds = true
        serielButton1.setTitleColor(UIColor.black, for: UIControlState.normal)
        serielButton1.setTitleColor(UIColor.white, for: UIControlState.selected)
        serielButton1.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        serielButton1.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        serielButton1.isSelected = self.dataSource.printingDirection == 0
        self.propertyScrollView.addSubview(serielButton1)
        
        let serielButton2 = UIButton()
        serielButton2.frame = CGRect.init(x: serielButton1.frame.maxX + buttonGap, y: serielButton1.frame.minY, width: serielButton1.frame.width, height: serielButton1.frame.height)
        serielButton2.setTitle("递变", for: UIControlState.normal)
        serielButton2.layer.borderWidth = 1
        serielButton2.layer.borderColor = SYS_Color.cgColor
        serielButton2.layer.cornerRadius = 4
        serielButton2.imageView?.layer.cornerRadius = 4
        serielButton2.clipsToBounds = true
        serielButton2.setTitleColor(UIColor.black, for: UIControlState.normal)
        serielButton2.setTitleColor(UIColor.white, for: UIControlState.selected)
        serielButton2.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        serielButton2.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        serielButton2.isSelected = self.dataSource.printingDirection == 90
        self.propertyScrollView.addSubview(serielButton2)
        
        let serielButton3 = UIButton()
        serielButton3.frame = CGRect.init(x: serielButton2.frame.maxX + buttonGap, y: serielButton1.frame.minY, width: serielButton1.frame.width, height: serielButton1.frame.height)
        serielButton3.setTitle("文件", for: UIControlState.normal)
        serielButton3.layer.borderWidth = 1
        serielButton3.layer.borderColor = SYS_Color.cgColor
        serielButton3.layer.cornerRadius = 4
        serielButton3.imageView?.layer.cornerRadius = 4
        serielButton3.clipsToBounds = true
        serielButton3.setTitleColor(UIColor.black, for: UIControlState.normal)
        serielButton3.setTitleColor(UIColor.white, for: UIControlState.selected)
        serielButton3.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        serielButton3.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        serielButton3.isSelected = self.dataSource.printingDirection == 180
        self.propertyScrollView.addSubview(serielButton3)
        
        self.propertyScrollView.contentSize = CGSize(width: normalWidth, height: serielLineLabel.frame.maxY)
    }
    
    func createQCCodeElementViewPropertyView(view: BarcodeElementView) -> Void {
        // 通用高度
        let normalHeight = CGFloat(40)
        let normalWidth = self.propertyScrollView.frame.width
        
        // 名称
        let nameLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: CGFloat(0), width: CGFloat(80), height: normalHeight))
        nameLabel.text = "  " + MHTBase.internationalStringWith(str: "名称")
        self.propertyScrollView.addSubview(nameLabel)
        
        // 名称输入框，不可以编辑
        let nameTextField = UITextField(frame: CGRect.init(x: nameLabel.frame.maxX + 16, y: nameLabel.frame.minY, width: normalWidth - nameLabel.frame.width - 16 - 16, height: normalHeight))
        nameTextField.delegate = self
        nameTextField.placeholder = MHTBase.internationalStringWith(str: "一维码")
        nameTextField.isUserInteractionEnabled = false
        nameTextField.textAlignment = NSTextAlignment.right
        nameTextField.textColor = SYS_LIGHT_GREY
        self.propertyScrollView.addSubview(nameTextField)
        
        // 分隔线
        let sepLabel1 = UILabel(frame: CGRect.init(x: CGFloat(0), y: nameLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel1.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel1)
        
        // 旋转角度
        let printDirectLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel1.frame.maxY, width: CGFloat(80), height: normalHeight))
        printDirectLabel.text = "  " + MHTBase.internationalStringWith(str: "旋转角度")
        self.propertyScrollView.addSubview(printDirectLabel)
        
        let buttonGap = CGFloat(10)
        let buttonLeftWidth = normalWidth - 16 - 16
        let buttonWidth = (buttonLeftWidth - printDirectLabel.frame.width - 3 * buttonGap) / 4
        let printDirectButton1 = UIButton()
        printDirectButton1.frame = CGRect.init(x: printDirectLabel.frame.maxX + 16, y: printDirectLabel.frame.minY + 5, width: buttonWidth, height: normalHeight - 10)
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
        self.propertyScrollView.addSubview(printDirectButton1)
        
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
        self.propertyScrollView.addSubview(printDirectButton2)
        
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
        self.propertyScrollView.addSubview(printDirectButton3)
        
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
        self.propertyScrollView.addSubview(printDirectButton4)
        
        // 分隔线
        let sepLabel2 = UILabel(frame: CGRect.init(x: CGFloat(0), y: printDirectLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel2.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel2)
        
        // 位置大小标题
        let titleLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel2.frame.maxY, width: normalWidth, height: normalHeight))
        titleLabel.backgroundColor = SYS_LIGHT_GREY
        titleLabel.text = "  " + MHTBase.internationalStringWith(str: "位置大小")
        self.propertyScrollView.addSubview(titleLabel)
        
        // 分隔线
        let sepLabel3 = UILabel(frame: CGRect.init(x: CGFloat(0), y: titleLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel3.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel3)
        
        // 立平居中
        let widthCenterButton = (normalWidth - 3 * 16) / 2
        let centerHorizontalButton = UIButton()
        centerHorizontalButton.frame = CGRect(x: 16, y: sepLabel3.frame.maxY + 5, width: widthCenterButton, height: printDirectButton1.frame.height)
        centerHorizontalButton.setTitle(MHTBase.internationalStringWith(str: "水平位置居中"), for: UIControlState.normal)
        centerHorizontalButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        centerHorizontalButton.setTitleColor(SYS_Color, for: UIControlState.highlighted)
        centerHorizontalButton.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.normal)
        centerHorizontalButton.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.highlighted)
        self.propertyScrollView.addSubview(centerHorizontalButton)
        
        // 垂直居中
        let centerVaticalButton = UIButton()
        centerVaticalButton.frame = CGRect(x: centerHorizontalButton.frame.maxX + 16, y: centerHorizontalButton.frame.minY, width: widthCenterButton, height: centerHorizontalButton.frame.height)
        centerVaticalButton.setTitle(MHTBase.internationalStringWith(str: "垂直位置居中"), for: UIControlState.normal)
        centerVaticalButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        centerVaticalButton.setTitleColor(SYS_Color, for: UIControlState.highlighted)
        centerVaticalButton.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.normal)
        centerVaticalButton.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.highlighted)
        self.propertyScrollView.addSubview(centerVaticalButton)
        
        let sepLabel4 = UILabel(frame: CGRect.init(x: CGFloat(0), y: centerHorizontalButton.frame.maxY + 5, width: normalWidth, height: CGFloat(0.5)))
        sepLabel4.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel4)
        
        // 位置上
        let topPositionLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel4.frame.maxY, width: CGFloat(80), height: normalHeight))
        topPositionLabel.text = "  " + MHTBase.internationalStringWith(str: "位置-上")
        self.propertyScrollView.addSubview(topPositionLabel)
        
        let topPositionTextField = UITextField(frame: CGRect.init(x: topPositionLabel.frame.maxX + 16, y: topPositionLabel.frame.minY, width: normalWidth - nameLabel.frame.width - 16 - 16 - 80 - 10, height: normalHeight))
        topPositionTextField.delegate = self
        topPositionTextField.text = "0"
        topPositionTextField.textAlignment = NSTextAlignment.right
        topPositionTextField.textColor = SYS_LIGHT_GREY
        self.propertyScrollView.addSubview(topPositionTextField)
        
        let topPositionAddButton = UIButton()
        topPositionAddButton.frame = CGRect(x: topPositionTextField.frame.maxX + 5, y: topPositionTextField.frame.minY + 5, width: 40, height: 30)
        topPositionAddButton.setTitle("+", for: UIControlState.normal)
        topPositionAddButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        topPositionAddButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        topPositionAddButton.tintColor = SYS_Color
        topPositionAddButton.layer.cornerRadius = 4
        topPositionAddButton.layer.borderColor = SYS_Color.cgColor
        topPositionAddButton.layer.borderWidth = 1
        self.propertyScrollView.addSubview(topPositionAddButton)
        
        let topPositionReduceButton = UIButton()
        topPositionReduceButton.frame = CGRect(x: topPositionAddButton.frame.maxX + 5, y: topPositionTextField.frame.minY + 5, width: 40, height: 30)
        topPositionReduceButton.setTitle("-", for: UIControlState.normal)
        topPositionReduceButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        topPositionReduceButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        topPositionReduceButton.tintColor = SYS_Color
        topPositionReduceButton.layer.cornerRadius = 4
        topPositionReduceButton.layer.borderColor = SYS_Color.cgColor
        topPositionReduceButton.layer.borderWidth = 1
        self.propertyScrollView.addSubview(topPositionReduceButton)
        
        let sepLabel5 = UILabel(frame: CGRect.init(x: CGFloat(0), y: topPositionLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel5.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel5)
        
        // 位置左
        let leftPositionLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel5.frame.maxY, width: CGFloat(80), height: normalHeight))
        leftPositionLabel.text = "  " + MHTBase.internationalStringWith(str: "位置-左")
        self.propertyScrollView.addSubview(leftPositionLabel)
        
        let leftPositionTextField = UITextField(frame: CGRect.init(x: leftPositionLabel.frame.maxX + 16, y: leftPositionLabel.frame.minY, width: normalWidth - nameLabel.frame.width - 16 - 16 - 80 - 10, height: normalHeight))
        leftPositionTextField.delegate = self
        leftPositionTextField.text = "0"
        leftPositionTextField.textAlignment = NSTextAlignment.right
        leftPositionTextField.textColor = SYS_LIGHT_GREY
        self.propertyScrollView.addSubview(leftPositionTextField)
        
        let leftPositionAddButton = UIButton()
        leftPositionAddButton.frame = CGRect(x: leftPositionTextField.frame.maxX + 5, y: leftPositionTextField.frame.minY + 5, width: 40, height: 30)
        leftPositionAddButton.setTitle("+", for: UIControlState.normal)
        leftPositionAddButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        leftPositionAddButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        leftPositionAddButton.tintColor = SYS_Color
        leftPositionAddButton.layer.cornerRadius = 4
        leftPositionAddButton.layer.borderColor = SYS_Color.cgColor
        leftPositionAddButton.layer.borderWidth = 1
        self.propertyScrollView.addSubview(leftPositionAddButton)
        
        let leftPositionReduceButton = UIButton()
        leftPositionReduceButton.frame = CGRect(x: leftPositionAddButton.frame.maxX + 5, y: leftPositionAddButton.frame.minY, width: 40, height: 30)
        leftPositionReduceButton.setTitle("-", for: UIControlState.normal)
        leftPositionReduceButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        leftPositionReduceButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        leftPositionReduceButton.tintColor = SYS_Color
        leftPositionReduceButton.layer.cornerRadius = 4
        leftPositionReduceButton.layer.borderColor = SYS_Color.cgColor
        leftPositionReduceButton.layer.borderWidth = 1
        self.propertyScrollView.addSubview(leftPositionReduceButton)
        
        let sepLabel6 = UILabel(frame: CGRect.init(x: CGFloat(0), y: leftPositionLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel6.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel6)
        
        // 一维码
        let qrcodeTitleLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel6.frame.maxY, width: normalWidth, height: normalHeight))
        qrcodeTitleLabel.backgroundColor = SYS_LIGHT_GREY
        qrcodeTitleLabel.text = "  " + MHTBase.internationalStringWith(str: "一维码")
        self.propertyScrollView.addSubview(qrcodeTitleLabel)
        
        // 文字位置
        let qrcodeLevelLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: qrcodeTitleLabel.frame.maxY, width: CGFloat(80), height: normalHeight))
        qrcodeLevelLabel.text = "  " + MHTBase.internationalStringWith(str: "文字位置")
        self.propertyScrollView.addSubview(qrcodeLevelLabel)
        
        let qrcodeLevelButton1 = UIButton()
        qrcodeLevelButton1.frame = CGRect.init(x: qrcodeLevelLabel.frame.maxX + 16, y: qrcodeLevelLabel.frame.minY + 5, width: buttonWidth, height: normalHeight - 10)
        qrcodeLevelButton1.setTitle("无文字", for: UIControlState.normal)
        qrcodeLevelButton1.layer.borderWidth = 1
        qrcodeLevelButton1.layer.borderColor = SYS_Color.cgColor
        qrcodeLevelButton1.layer.cornerRadius = 4
        qrcodeLevelButton1.imageView?.layer.cornerRadius = 4
        qrcodeLevelButton1.clipsToBounds = true
        qrcodeLevelButton1.setTitleColor(UIColor.black, for: UIControlState.normal)
        qrcodeLevelButton1.setTitleColor(UIColor.white, for: UIControlState.selected)
        qrcodeLevelButton1.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        qrcodeLevelButton1.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        qrcodeLevelButton1.isSelected = self.dataSource.printingDirection == 0
        self.propertyScrollView.addSubview(qrcodeLevelButton1)
        
        let qrcodeLevelButton2 = UIButton()
        qrcodeLevelButton2.frame = CGRect.init(x: qrcodeLevelButton1.frame.maxX + buttonGap, y: qrcodeLevelButton1.frame.minY, width: qrcodeLevelButton1.frame.width, height: qrcodeLevelButton1.frame.height)
        qrcodeLevelButton2.setTitle("条码码上方", for: UIControlState.normal)
        qrcodeLevelButton2.layer.borderWidth = 1
        qrcodeLevelButton2.layer.borderColor = SYS_Color.cgColor
        qrcodeLevelButton2.layer.cornerRadius = 4
        qrcodeLevelButton2.imageView?.layer.cornerRadius = 4
        qrcodeLevelButton2.clipsToBounds = true
        qrcodeLevelButton2.titleLabel?.adjustsFontSizeToFitWidth = true
        qrcodeLevelButton2.setTitleColor(UIColor.black, for: UIControlState.normal)
        qrcodeLevelButton2.setTitleColor(UIColor.white, for: UIControlState.selected)
        qrcodeLevelButton2.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        qrcodeLevelButton2.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        qrcodeLevelButton2.isSelected = self.dataSource.printingDirection == 90
        self.propertyScrollView.addSubview(qrcodeLevelButton2)
        
        let qrcodeLevelButton3 = UIButton()
        qrcodeLevelButton3.frame = CGRect.init(x: qrcodeLevelButton2.frame.maxX + buttonGap, y: qrcodeLevelButton1.frame.minY, width: qrcodeLevelButton1.frame.width, height: qrcodeLevelButton1.frame.height)
        qrcodeLevelButton3.setTitle("条形码下方", for: UIControlState.normal)
        qrcodeLevelButton3.layer.borderWidth = 1
        qrcodeLevelButton3.layer.borderColor = SYS_Color.cgColor
        qrcodeLevelButton3.layer.cornerRadius = 4
        qrcodeLevelButton3.imageView?.layer.cornerRadius = 4
        qrcodeLevelButton3.clipsToBounds = true
        qrcodeLevelButton3.titleLabel?.adjustsFontSizeToFitWidth = true
        qrcodeLevelButton3.setTitleColor(UIColor.black, for: UIControlState.normal)
        qrcodeLevelButton3.setTitleColor(UIColor.white, for: UIControlState.selected)
        qrcodeLevelButton3.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        qrcodeLevelButton3.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        qrcodeLevelButton3.isSelected = self.dataSource.printingDirection == 180
        self.propertyScrollView.addSubview(qrcodeLevelButton3)
        
        // 字体
        let textLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: qrcodeLevelLabel.frame.maxY, width: normalWidth, height: normalHeight))
        textLabel.backgroundColor = SYS_LIGHT_GREY
        textLabel.text = "  " + MHTBase.internationalStringWith(str: "字体")
        self.propertyScrollView.addSubview(textLabel)
        
        // 字间距
        let wordSpaceLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: textLabel.frame.maxY, width: CGFloat(80), height: normalHeight))
        wordSpaceLabel.text = "  " + MHTBase.internationalStringWith(str: "字间距")
        self.propertyScrollView.addSubview(wordSpaceLabel)
        
        let wordSpaceTextField = UITextField(frame: CGRect.init(x: wordSpaceLabel.frame.maxX + 16, y: wordSpaceLabel.frame.minY, width: normalWidth - nameLabel.frame.width - 16 - 16 - 80 - 10, height: normalHeight))
        wordSpaceTextField.delegate = self
        wordSpaceTextField.text = "0.01"
        wordSpaceTextField.textAlignment = NSTextAlignment.right
        wordSpaceTextField.textColor = SYS_LIGHT_GREY
        self.propertyScrollView.addSubview(wordSpaceTextField)
        
        let wordSpaceAddButton = UIButton()
        wordSpaceAddButton.frame = CGRect(x: wordSpaceTextField.frame.maxX + 5, y: wordSpaceTextField.frame.minY + 5, width: 40, height: 30)
        wordSpaceAddButton.setTitle("+", for: UIControlState.normal)
        wordSpaceAddButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        wordSpaceAddButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        wordSpaceAddButton.tintColor = SYS_Color
        wordSpaceAddButton.layer.cornerRadius = 4
        wordSpaceAddButton.layer.borderColor = SYS_Color.cgColor
        wordSpaceAddButton.layer.borderWidth = 1
        self.propertyScrollView.addSubview(wordSpaceAddButton)
        
        let wordSpaceReduceButton = UIButton()
        wordSpaceReduceButton.frame = CGRect(x: wordSpaceAddButton.frame.maxX + 5, y: wordSpaceAddButton.frame.minY, width: 40, height: 30)
        wordSpaceReduceButton.setTitle("-", for: UIControlState.normal)
        wordSpaceReduceButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        wordSpaceReduceButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        wordSpaceReduceButton.tintColor = SYS_Color
        wordSpaceReduceButton.layer.cornerRadius = 4
        wordSpaceReduceButton.layer.borderColor = SYS_Color.cgColor
        wordSpaceReduceButton.layer.borderWidth = 1
        self.propertyScrollView.addSubview(wordSpaceReduceButton)
        
        let sepLabel7 = UILabel(frame: CGRect.init(x: CGFloat(0), y: wordSpaceLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel7.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel7)
        
        // 字体大小
        let wordSizeLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel7.frame.maxY, width: CGFloat(80), height: normalHeight))
        wordSizeLabel.text = "  " + MHTBase.internationalStringWith(str: "字体大小")
        self.propertyScrollView.addSubview(wordSizeLabel)
        
        let wordSizeTextField = UITextField(frame: CGRect.init(x: wordSizeLabel.frame.maxX + 16, y: wordSizeLabel.frame.minY, width: normalWidth - nameLabel.frame.width - 16 - 16 - 80 - 10, height: normalHeight))
        wordSizeTextField.delegate = self
        wordSizeTextField.text = "0.01"
        wordSizeTextField.textAlignment = NSTextAlignment.right
        wordSizeTextField.textColor = SYS_LIGHT_GREY
        self.propertyScrollView.addSubview(wordSizeTextField)
        
        let wordSizeAddButton = UIButton()
        wordSizeAddButton.frame = CGRect(x: wordSizeTextField.frame.maxX + 5, y: wordSizeTextField.frame.minY + 5, width: 40, height: 30)
        wordSizeAddButton.setTitle("+", for: UIControlState.normal)
        wordSizeAddButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        wordSizeAddButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        wordSizeAddButton.tintColor = SYS_Color
        wordSizeAddButton.layer.cornerRadius = 4
        wordSizeAddButton.layer.borderColor = SYS_Color.cgColor
        wordSizeAddButton.layer.borderWidth = 1
        self.propertyScrollView.addSubview(wordSizeAddButton)
        
        let wordSizeReduceButton = UIButton()
        wordSizeReduceButton.frame = CGRect(x: wordSizeAddButton.frame.maxX + 5, y: wordSizeAddButton.frame.minY, width: 40, height: 30)
        wordSizeReduceButton.setTitle("-", for: UIControlState.normal)
        wordSizeReduceButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        wordSizeReduceButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        wordSizeReduceButton.tintColor = SYS_Color
        wordSizeReduceButton.layer.cornerRadius = 4
        wordSizeReduceButton.layer.borderColor = SYS_Color.cgColor
        wordSizeReduceButton.layer.borderWidth = 1
        self.propertyScrollView.addSubview(wordSizeReduceButton)
        
        let sepLabel8 = UILabel(frame: CGRect.init(x: CGFloat(0), y: wordSizeLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel8.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel8)
        
        // 文本对齐
        let textAliLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel8.frame.maxY, width: CGFloat(80), height: normalHeight))
        textAliLabel.text = "  " + MHTBase.internationalStringWith(str: "文本对齐")
        self.propertyScrollView.addSubview(textAliLabel)
        
        let textAliButton1 = UIButton()
        textAliButton1.frame = CGRect.init(x: textAliLabel.frame.maxX + 16, y: textAliLabel.frame.minY + 5, width: buttonWidth, height: normalHeight - 10)
        textAliButton1.setTitle("居左", for: UIControlState.normal)
        textAliButton1.layer.borderWidth = 1
        textAliButton1.layer.borderColor = SYS_Color.cgColor
        textAliButton1.layer.cornerRadius = 4
        textAliButton1.imageView?.layer.cornerRadius = 4
        textAliButton1.clipsToBounds = true
        textAliButton1.setTitleColor(UIColor.black, for: UIControlState.normal)
        textAliButton1.setTitleColor(UIColor.white, for: UIControlState.selected)
        textAliButton1.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        textAliButton1.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        textAliButton1.isSelected = self.dataSource.printingDirection == 0
        self.propertyScrollView.addSubview(textAliButton1)
        
        let textAliButton2 = UIButton()
        textAliButton2.frame = CGRect.init(x: textAliButton1.frame.maxX + buttonGap, y: textAliButton1.frame.minY, width: textAliButton1.frame.width, height: textAliButton1.frame.height)
        textAliButton2.setTitle("居中", for: UIControlState.normal)
        textAliButton2.layer.borderWidth = 1
        textAliButton2.layer.borderColor = SYS_Color.cgColor
        textAliButton2.layer.cornerRadius = 4
        textAliButton2.imageView?.layer.cornerRadius = 4
        textAliButton2.clipsToBounds = true
        textAliButton2.setTitleColor(UIColor.black, for: UIControlState.normal)
        textAliButton2.setTitleColor(UIColor.white, for: UIControlState.selected)
        textAliButton2.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        textAliButton2.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        textAliButton2.isSelected = self.dataSource.printingDirection == 90
        self.propertyScrollView.addSubview(textAliButton2)
        
        let textAliButton3 = UIButton()
        textAliButton3.frame = CGRect.init(x: textAliButton2.frame.maxX + buttonGap, y: textAliButton1.frame.minY, width: textAliButton1.frame.width, height: textAliButton1.frame.height)
        textAliButton3.setTitle("居右", for: UIControlState.normal)
        textAliButton3.layer.borderWidth = 1
        textAliButton3.layer.borderColor = SYS_Color.cgColor
        textAliButton3.layer.cornerRadius = 4
        textAliButton3.imageView?.layer.cornerRadius = 4
        textAliButton3.clipsToBounds = true
        textAliButton3.setTitleColor(UIColor.black, for: UIControlState.normal)
        textAliButton3.setTitleColor(UIColor.white, for: UIControlState.selected)
        textAliButton3.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        textAliButton3.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        textAliButton3.isSelected = self.dataSource.printingDirection == 180
        self.propertyScrollView.addSubview(textAliButton3)
        
        // 序列化
        let serielLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: textAliLabel.frame.maxY, width: normalWidth, height: normalHeight))
        serielLabel.backgroundColor = SYS_LIGHT_GREY
        serielLabel.text = "  " + MHTBase.internationalStringWith(str: "序列化")
        self.propertyScrollView.addSubview(serielLabel)
        
        // 序列化
        let serielLineLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: serielLabel.frame.maxY, width: CGFloat(80), height: normalHeight))
        serielLineLabel.text = "  " + MHTBase.internationalStringWith(str: "序列化")
        self.propertyScrollView.addSubview(serielLineLabel)
        
        let serielButton1 = UIButton()
        serielButton1.frame = CGRect.init(x: serielLineLabel.frame.maxX + 16, y: serielLineLabel.frame.minY + 5, width: buttonWidth, height: normalHeight - 10)
        serielButton1.setTitle("无", for: UIControlState.normal)
        serielButton1.layer.borderWidth = 1
        serielButton1.layer.borderColor = SYS_Color.cgColor
        serielButton1.layer.cornerRadius = 4
        serielButton1.imageView?.layer.cornerRadius = 4
        serielButton1.clipsToBounds = true
        serielButton1.setTitleColor(UIColor.black, for: UIControlState.normal)
        serielButton1.setTitleColor(UIColor.white, for: UIControlState.selected)
        serielButton1.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        serielButton1.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        serielButton1.isSelected = self.dataSource.printingDirection == 0
        self.propertyScrollView.addSubview(serielButton1)
        
        let serielButton2 = UIButton()
        serielButton2.frame = CGRect.init(x: serielButton1.frame.maxX + buttonGap, y: serielButton1.frame.minY, width: serielButton1.frame.width, height: serielButton1.frame.height)
        serielButton2.setTitle("递变", for: UIControlState.normal)
        serielButton2.layer.borderWidth = 1
        serielButton2.layer.borderColor = SYS_Color.cgColor
        serielButton2.layer.cornerRadius = 4
        serielButton2.imageView?.layer.cornerRadius = 4
        serielButton2.clipsToBounds = true
        serielButton2.setTitleColor(UIColor.black, for: UIControlState.normal)
        serielButton2.setTitleColor(UIColor.white, for: UIControlState.selected)
        serielButton2.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        serielButton2.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        serielButton2.isSelected = self.dataSource.printingDirection == 90
        self.propertyScrollView.addSubview(serielButton2)
        
        let serielButton3 = UIButton()
        serielButton3.frame = CGRect.init(x: serielButton2.frame.maxX + buttonGap, y: serielButton1.frame.minY, width: serielButton1.frame.width, height: serielButton1.frame.height)
        serielButton3.setTitle("文件", for: UIControlState.normal)
        serielButton3.layer.borderWidth = 1
        serielButton3.layer.borderColor = SYS_Color.cgColor
        serielButton3.layer.cornerRadius = 4
        serielButton3.imageView?.layer.cornerRadius = 4
        serielButton3.clipsToBounds = true
        serielButton3.setTitleColor(UIColor.black, for: UIControlState.normal)
        serielButton3.setTitleColor(UIColor.white, for: UIControlState.selected)
        serielButton3.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        serielButton3.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        serielButton3.isSelected = self.dataSource.printingDirection == 180
        self.propertyScrollView.addSubview(serielButton3)
        
        self.propertyScrollView.contentSize = CGSize(width: normalWidth, height: serielLineLabel.frame.maxY)
    }
    
    func createImageElementViewPropertyView(view: ImageElementView) -> Void {
        // 通用高度
        let normalHeight = CGFloat(40)
        let normalWidth = self.propertyScrollView.frame.width
        
        // 名称
        let nameLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: CGFloat(0), width: CGFloat(80), height: normalHeight))
        nameLabel.text = "  " + MHTBase.internationalStringWith(str: "名称")
        self.propertyScrollView.addSubview(nameLabel)
        
        // 名称输入框，不可以编辑
        let nameTextField = UITextField(frame: CGRect.init(x: nameLabel.frame.maxX + 16, y: nameLabel.frame.minY, width: normalWidth - nameLabel.frame.width - 16 - 16, height: normalHeight))
        nameTextField.delegate = self
        nameTextField.placeholder = MHTBase.internationalStringWith(str: "图片")
        nameTextField.isUserInteractionEnabled = false
        nameTextField.textAlignment = NSTextAlignment.right
        nameTextField.textColor = SYS_LIGHT_GREY
        self.propertyScrollView.addSubview(nameTextField)
        
        // 分隔线
        let sepLabel1 = UILabel(frame: CGRect.init(x: CGFloat(0), y: nameLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel1.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel1)
        
        // 旋转角度
        let printDirectLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel1.frame.maxY, width: CGFloat(80), height: normalHeight))
        printDirectLabel.text = "  " + MHTBase.internationalStringWith(str: "旋转角度")
        self.propertyScrollView.addSubview(printDirectLabel)
        
        let buttonGap = CGFloat(10)
        let buttonLeftWidth = normalWidth - 16 - 16
        let buttonWidth = (buttonLeftWidth - printDirectLabel.frame.width - 3 * buttonGap) / 4
        let printDirectButton1 = UIButton()
        printDirectButton1.frame = CGRect.init(x: printDirectLabel.frame.maxX + 16, y: printDirectLabel.frame.minY + 5, width: buttonWidth, height: normalHeight - 10)
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
        self.propertyScrollView.addSubview(printDirectButton1)
        
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
        self.propertyScrollView.addSubview(printDirectButton2)
        
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
        self.propertyScrollView.addSubview(printDirectButton3)
        
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
        self.propertyScrollView.addSubview(printDirectButton4)
        
        // 分隔线
        let sepLabel2 = UILabel(frame: CGRect.init(x: CGFloat(0), y: printDirectLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel2.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel2)
        
        // 位置大小标题
        let titleLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel2.frame.maxY, width: normalWidth, height: normalHeight))
        titleLabel.backgroundColor = SYS_LIGHT_GREY
        titleLabel.text = "  " + MHTBase.internationalStringWith(str: "位置大小")
        self.propertyScrollView.addSubview(titleLabel)
        
        // 分隔线
        let sepLabel3 = UILabel(frame: CGRect.init(x: CGFloat(0), y: titleLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel3.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel3)
        
        // 立平居中
        let widthCenterButton = (normalWidth - 3 * 16) / 2
        let centerHorizontalButton = UIButton()
        centerHorizontalButton.frame = CGRect(x: 16, y: sepLabel3.frame.maxY + 5, width: widthCenterButton, height: printDirectButton1.frame.height)
        centerHorizontalButton.setTitle(MHTBase.internationalStringWith(str: "水平位置居中"), for: UIControlState.normal)
        centerHorizontalButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        centerHorizontalButton.setTitleColor(SYS_Color, for: UIControlState.highlighted)
        centerHorizontalButton.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.normal)
        centerHorizontalButton.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.highlighted)
        self.propertyScrollView.addSubview(centerHorizontalButton)
        
        // 垂直居中
        let centerVaticalButton = UIButton()
        centerVaticalButton.frame = CGRect(x: centerHorizontalButton.frame.maxX + 16, y: centerHorizontalButton.frame.minY, width: widthCenterButton, height: centerHorizontalButton.frame.height)
        centerVaticalButton.setTitle(MHTBase.internationalStringWith(str: "垂直位置居中"), for: UIControlState.normal)
        centerVaticalButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        centerVaticalButton.setTitleColor(SYS_Color, for: UIControlState.highlighted)
        centerVaticalButton.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.normal)
        centerVaticalButton.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.highlighted)
        self.propertyScrollView.addSubview(centerVaticalButton)
        
        let sepLabel4 = UILabel(frame: CGRect.init(x: CGFloat(0), y: centerHorizontalButton.frame.maxY + 5, width: normalWidth, height: CGFloat(0.5)))
        sepLabel4.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel4)
        
        // 位置上
        let topPositionLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel4.frame.maxY, width: CGFloat(80), height: normalHeight))
        topPositionLabel.text = "  " + MHTBase.internationalStringWith(str: "位置-上")
        self.propertyScrollView.addSubview(topPositionLabel)
        
        let topPositionTextField = UITextField(frame: CGRect.init(x: topPositionLabel.frame.maxX + 16, y: topPositionLabel.frame.minY, width: normalWidth - nameLabel.frame.width - 16 - 16 - 80 - 10, height: normalHeight))
        topPositionTextField.delegate = self
        topPositionTextField.text = "0"
        topPositionTextField.textAlignment = NSTextAlignment.right
        topPositionTextField.textColor = SYS_LIGHT_GREY
        self.propertyScrollView.addSubview(topPositionTextField)
        
        let topPositionAddButton = UIButton()
        topPositionAddButton.frame = CGRect(x: topPositionTextField.frame.maxX + 5, y: topPositionTextField.frame.minY + 5, width: 40, height: 30)
        topPositionAddButton.setTitle("+", for: UIControlState.normal)
        topPositionAddButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        topPositionAddButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        topPositionAddButton.tintColor = SYS_Color
        topPositionAddButton.layer.cornerRadius = 4
        topPositionAddButton.layer.borderColor = SYS_Color.cgColor
        topPositionAddButton.layer.borderWidth = 1
        self.propertyScrollView.addSubview(topPositionAddButton)
        
        let topPositionReduceButton = UIButton()
        topPositionReduceButton.frame = CGRect(x: topPositionAddButton.frame.maxX + 5, y: topPositionTextField.frame.minY + 5, width: 40, height: 30)
        topPositionReduceButton.setTitle("-", for: UIControlState.normal)
        topPositionReduceButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        topPositionReduceButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        topPositionReduceButton.tintColor = SYS_Color
        topPositionReduceButton.layer.cornerRadius = 4
        topPositionReduceButton.layer.borderColor = SYS_Color.cgColor
        topPositionReduceButton.layer.borderWidth = 1
        self.propertyScrollView.addSubview(topPositionReduceButton)
        
        let sepLabel5 = UILabel(frame: CGRect.init(x: CGFloat(0), y: topPositionLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel5.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel5)
        
        // 位置左
        let leftPositionLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel5.frame.maxY, width: CGFloat(80), height: normalHeight))
        leftPositionLabel.text = "  " + MHTBase.internationalStringWith(str: "位置-左")
        self.propertyScrollView.addSubview(leftPositionLabel)
        
        let leftPositionTextField = UITextField(frame: CGRect.init(x: leftPositionLabel.frame.maxX + 16, y: leftPositionLabel.frame.minY, width: normalWidth - nameLabel.frame.width - 16 - 16 - 80 - 10, height: normalHeight))
        leftPositionTextField.delegate = self
        leftPositionTextField.text = "0"
        leftPositionTextField.textAlignment = NSTextAlignment.right
        leftPositionTextField.textColor = SYS_LIGHT_GREY
        self.propertyScrollView.addSubview(leftPositionTextField)
        
        let leftPositionAddButton = UIButton()
        leftPositionAddButton.frame = CGRect(x: leftPositionTextField.frame.maxX + 5, y: leftPositionTextField.frame.minY + 5, width: 40, height: 30)
        leftPositionAddButton.setTitle("+", for: UIControlState.normal)
        leftPositionAddButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        leftPositionAddButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        leftPositionAddButton.tintColor = SYS_Color
        leftPositionAddButton.layer.cornerRadius = 4
        leftPositionAddButton.layer.borderColor = SYS_Color.cgColor
        leftPositionAddButton.layer.borderWidth = 1
        self.propertyScrollView.addSubview(leftPositionAddButton)
        
        let leftPositionReduceButton = UIButton()
        leftPositionReduceButton.frame = CGRect(x: leftPositionAddButton.frame.maxX + 5, y: leftPositionAddButton.frame.minY, width: 40, height: 30)
        leftPositionReduceButton.setTitle("-", for: UIControlState.normal)
        leftPositionReduceButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        leftPositionReduceButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        leftPositionReduceButton.tintColor = SYS_Color
        leftPositionReduceButton.layer.cornerRadius = 4
        leftPositionReduceButton.layer.borderColor = SYS_Color.cgColor
        leftPositionReduceButton.layer.borderWidth = 1
        self.propertyScrollView.addSubview(leftPositionReduceButton)
        
        let sepLabel6 = UILabel(frame: CGRect.init(x: CGFloat(0), y: leftPositionLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel6.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel6)
        
        self.propertyScrollView.contentSize = CGSize(width: normalWidth, height: sepLabel6.frame.maxY)
    }
    
    func createQRCodeElementViewPropertyView(view: QRCodeElementView) -> Void {
        // 通用高度
        let normalHeight = CGFloat(40)
        let normalWidth = self.propertyScrollView.frame.width
        
        // 名称
        let nameLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: CGFloat(0), width: CGFloat(80), height: normalHeight))
        nameLabel.text = "  " + MHTBase.internationalStringWith(str: "名称")
        self.propertyScrollView.addSubview(nameLabel)
        
        // 名称输入框，不可以编辑
        let nameTextField = UITextField(frame: CGRect.init(x: nameLabel.frame.maxX + 16, y: nameLabel.frame.minY, width: normalWidth - nameLabel.frame.width - 16 - 16, height: normalHeight))
        nameTextField.delegate = self
        nameTextField.placeholder = MHTBase.internationalStringWith(str: "二维码")
        nameTextField.isUserInteractionEnabled = false
        nameTextField.textAlignment = NSTextAlignment.right
        nameTextField.textColor = SYS_LIGHT_GREY
        self.propertyScrollView.addSubview(nameTextField)
        
        // 分隔线
        let sepLabel1 = UILabel(frame: CGRect.init(x: CGFloat(0), y: nameLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel1.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel1)
        
        // 旋转角度
        let printDirectLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel1.frame.maxY, width: CGFloat(80), height: normalHeight))
        printDirectLabel.text = "  " + MHTBase.internationalStringWith(str: "旋转角度")
        self.propertyScrollView.addSubview(printDirectLabel)
        
        let buttonGap = CGFloat(10)
        let buttonLeftWidth = normalWidth - 16 - 16
        let buttonWidth = (buttonLeftWidth - printDirectLabel.frame.width - 3 * buttonGap) / 4
        let printDirectButton1 = UIButton()
        printDirectButton1.frame = CGRect.init(x: printDirectLabel.frame.maxX + 16, y: printDirectLabel.frame.minY + 5, width: buttonWidth, height: normalHeight - 10)
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
        self.propertyScrollView.addSubview(printDirectButton1)
        
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
        self.propertyScrollView.addSubview(printDirectButton2)
        
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
        self.propertyScrollView.addSubview(printDirectButton3)
        
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
        self.propertyScrollView.addSubview(printDirectButton4)
        
        // 分隔线
        let sepLabel2 = UILabel(frame: CGRect.init(x: CGFloat(0), y: printDirectLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel2.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel2)
        
        // 位置大小标题
        let titleLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel2.frame.maxY, width: normalWidth, height: normalHeight))
        titleLabel.backgroundColor = SYS_LIGHT_GREY
        titleLabel.text = "  " + MHTBase.internationalStringWith(str: "位置大小")
        self.propertyScrollView.addSubview(titleLabel)
        
        // 分隔线
        let sepLabel3 = UILabel(frame: CGRect.init(x: CGFloat(0), y: titleLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel3.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel3)
        
        // 立平居中
        let widthCenterButton = (normalWidth - 3 * 16) / 2
        let centerHorizontalButton = UIButton()
        centerHorizontalButton.frame = CGRect(x: 16, y: sepLabel3.frame.maxY + 5, width: widthCenterButton, height: printDirectButton1.frame.height)
        centerHorizontalButton.setTitle(MHTBase.internationalStringWith(str: "水平位置居中"), for: UIControlState.normal)
        centerHorizontalButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        centerHorizontalButton.setTitleColor(SYS_Color, for: UIControlState.highlighted)
        centerHorizontalButton.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.normal)
        centerHorizontalButton.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.highlighted)
        self.propertyScrollView.addSubview(centerHorizontalButton)
        
        // 垂直居中
        let centerVaticalButton = UIButton()
        centerVaticalButton.frame = CGRect(x: centerHorizontalButton.frame.maxX + 16, y: centerHorizontalButton.frame.minY, width: widthCenterButton, height: centerHorizontalButton.frame.height)
        centerVaticalButton.setTitle(MHTBase.internationalStringWith(str: "垂直位置居中"), for: UIControlState.normal)
        centerVaticalButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        centerVaticalButton.setTitleColor(SYS_Color, for: UIControlState.highlighted)
        centerVaticalButton.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.normal)
        centerVaticalButton.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.highlighted)
        self.propertyScrollView.addSubview(centerVaticalButton)
        
        let sepLabel4 = UILabel(frame: CGRect.init(x: CGFloat(0), y: centerHorizontalButton.frame.maxY + 5, width: normalWidth, height: CGFloat(0.5)))
        sepLabel4.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel4)
        
        // 位置上
        let topPositionLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel4.frame.maxY, width: CGFloat(80), height: normalHeight))
        topPositionLabel.text = "  " + MHTBase.internationalStringWith(str: "位置-上")
        self.propertyScrollView.addSubview(topPositionLabel)
        
        let topPositionTextField = UITextField(frame: CGRect.init(x: topPositionLabel.frame.maxX + 16, y: topPositionLabel.frame.minY, width: normalWidth - nameLabel.frame.width - 16 - 16 - 80 - 10, height: normalHeight))
        topPositionTextField.delegate = self
        topPositionTextField.text = "0"
        topPositionTextField.textAlignment = NSTextAlignment.right
        topPositionTextField.textColor = SYS_LIGHT_GREY
        self.propertyScrollView.addSubview(topPositionTextField)
        
        let topPositionAddButton = UIButton()
        topPositionAddButton.frame = CGRect(x: topPositionTextField.frame.maxX + 5, y: topPositionTextField.frame.minY + 5, width: 40, height: 30)
        topPositionAddButton.setTitle("+", for: UIControlState.normal)
        topPositionAddButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        topPositionAddButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        topPositionAddButton.tintColor = SYS_Color
        topPositionAddButton.layer.cornerRadius = 4
        topPositionAddButton.layer.borderColor = SYS_Color.cgColor
        topPositionAddButton.layer.borderWidth = 1
        self.propertyScrollView.addSubview(topPositionAddButton)
        
        let topPositionReduceButton = UIButton()
        topPositionReduceButton.frame = CGRect(x: topPositionAddButton.frame.maxX + 5, y: topPositionTextField.frame.minY + 5, width: 40, height: 30)
        topPositionReduceButton.setTitle("-", for: UIControlState.normal)
        topPositionReduceButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        topPositionReduceButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        topPositionReduceButton.tintColor = SYS_Color
        topPositionReduceButton.layer.cornerRadius = 4
        topPositionReduceButton.layer.borderColor = SYS_Color.cgColor
        topPositionReduceButton.layer.borderWidth = 1
        self.propertyScrollView.addSubview(topPositionReduceButton)
        
        let sepLabel5 = UILabel(frame: CGRect.init(x: CGFloat(0), y: topPositionLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel5.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel5)
        
        // 位置左
        let leftPositionLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel5.frame.maxY, width: CGFloat(80), height: normalHeight))
        leftPositionLabel.text = "  " + MHTBase.internationalStringWith(str: "位置-左")
        self.propertyScrollView.addSubview(leftPositionLabel)
        
        let leftPositionTextField = UITextField(frame: CGRect.init(x: leftPositionLabel.frame.maxX + 16, y: leftPositionLabel.frame.minY, width: normalWidth - nameLabel.frame.width - 16 - 16 - 80 - 10, height: normalHeight))
        leftPositionTextField.delegate = self
        leftPositionTextField.text = "0"
        leftPositionTextField.textAlignment = NSTextAlignment.right
        leftPositionTextField.textColor = SYS_LIGHT_GREY
        self.propertyScrollView.addSubview(leftPositionTextField)
        
        let leftPositionAddButton = UIButton()
        leftPositionAddButton.frame = CGRect(x: leftPositionTextField.frame.maxX + 5, y: leftPositionTextField.frame.minY + 5, width: 40, height: 30)
        leftPositionAddButton.setTitle("+", for: UIControlState.normal)
        leftPositionAddButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        leftPositionAddButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        leftPositionAddButton.tintColor = SYS_Color
        leftPositionAddButton.layer.cornerRadius = 4
        leftPositionAddButton.layer.borderColor = SYS_Color.cgColor
        leftPositionAddButton.layer.borderWidth = 1
        self.propertyScrollView.addSubview(leftPositionAddButton)
        
        let leftPositionReduceButton = UIButton()
        leftPositionReduceButton.frame = CGRect(x: leftPositionAddButton.frame.maxX + 5, y: leftPositionAddButton.frame.minY, width: 40, height: 30)
        leftPositionReduceButton.setTitle("-", for: UIControlState.normal)
        leftPositionReduceButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        leftPositionReduceButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        leftPositionReduceButton.tintColor = SYS_Color
        leftPositionReduceButton.layer.cornerRadius = 4
        leftPositionReduceButton.layer.borderColor = SYS_Color.cgColor
        leftPositionReduceButton.layer.borderWidth = 1
        self.propertyScrollView.addSubview(leftPositionReduceButton)
        
        let sepLabel6 = UILabel(frame: CGRect.init(x: CGFloat(0), y: leftPositionLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel6.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel6)
        
        // 二维码
        let qrcodeTitleLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel6.frame.maxY, width: normalWidth, height: normalHeight))
        qrcodeTitleLabel.backgroundColor = SYS_LIGHT_GREY
        qrcodeTitleLabel.text = "  " + MHTBase.internationalStringWith(str: "二维码")
        self.propertyScrollView.addSubview(qrcodeTitleLabel)
        
        // 纠错级别
        let qrcodeLevelLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: qrcodeTitleLabel.frame.maxY, width: CGFloat(80), height: normalHeight))
        qrcodeLevelLabel.text = "  " + MHTBase.internationalStringWith(str: "纠错级别")
        self.propertyScrollView.addSubview(qrcodeLevelLabel)
        
        let qrcodeLevelButton1 = UIButton()
        qrcodeLevelButton1.frame = CGRect.init(x: qrcodeLevelLabel.frame.maxX + 16, y: qrcodeLevelLabel.frame.minY + 5, width: buttonWidth, height: normalHeight - 10)
        qrcodeLevelButton1.setTitle("低", for: UIControlState.normal)
        qrcodeLevelButton1.layer.borderWidth = 1
        qrcodeLevelButton1.layer.borderColor = SYS_Color.cgColor
        qrcodeLevelButton1.layer.cornerRadius = 4
        qrcodeLevelButton1.imageView?.layer.cornerRadius = 4
        qrcodeLevelButton1.clipsToBounds = true
        qrcodeLevelButton1.setTitleColor(UIColor.black, for: UIControlState.normal)
        qrcodeLevelButton1.setTitleColor(UIColor.white, for: UIControlState.selected)
        qrcodeLevelButton1.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        qrcodeLevelButton1.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        qrcodeLevelButton1.isSelected = self.dataSource.printingDirection == 0
        self.propertyScrollView.addSubview(qrcodeLevelButton1)
        
        let qrcodeLevelButton2 = UIButton()
        qrcodeLevelButton2.frame = CGRect.init(x: qrcodeLevelButton1.frame.maxX + buttonGap, y: qrcodeLevelButton1.frame.minY, width: qrcodeLevelButton1.frame.width, height: qrcodeLevelButton1.frame.height)
        qrcodeLevelButton2.setTitle("中", for: UIControlState.normal)
        qrcodeLevelButton2.layer.borderWidth = 1
        qrcodeLevelButton2.layer.borderColor = SYS_Color.cgColor
        qrcodeLevelButton2.layer.cornerRadius = 4
        qrcodeLevelButton2.imageView?.layer.cornerRadius = 4
        qrcodeLevelButton2.clipsToBounds = true
        qrcodeLevelButton2.setTitleColor(UIColor.black, for: UIControlState.normal)
        qrcodeLevelButton2.setTitleColor(UIColor.white, for: UIControlState.selected)
        qrcodeLevelButton2.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        qrcodeLevelButton2.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        qrcodeLevelButton2.isSelected = self.dataSource.printingDirection == 90
        self.propertyScrollView.addSubview(qrcodeLevelButton2)
        
        let qrcodeLevelButton3 = UIButton()
        qrcodeLevelButton3.frame = CGRect.init(x: qrcodeLevelButton2.frame.maxX + buttonGap, y: qrcodeLevelButton1.frame.minY, width: qrcodeLevelButton1.frame.width, height: qrcodeLevelButton1.frame.height)
        qrcodeLevelButton3.setTitle("高", for: UIControlState.normal)
        qrcodeLevelButton3.layer.borderWidth = 1
        qrcodeLevelButton3.layer.borderColor = SYS_Color.cgColor
        qrcodeLevelButton3.layer.cornerRadius = 4
        qrcodeLevelButton3.imageView?.layer.cornerRadius = 4
        qrcodeLevelButton3.clipsToBounds = true
        qrcodeLevelButton3.setTitleColor(UIColor.black, for: UIControlState.normal)
        qrcodeLevelButton3.setTitleColor(UIColor.white, for: UIControlState.selected)
        qrcodeLevelButton3.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        qrcodeLevelButton3.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        qrcodeLevelButton3.isSelected = self.dataSource.printingDirection == 180
        self.propertyScrollView.addSubview(qrcodeLevelButton3)
        
        let qrcodeLevelButton4 = UIButton()
        qrcodeLevelButton4.frame = CGRect.init(x: qrcodeLevelButton3.frame.maxX + buttonGap, y: qrcodeLevelButton1.frame.minY, width: qrcodeLevelButton1.frame.width, height: qrcodeLevelButton1.frame.height)
        qrcodeLevelButton4.setTitle("强", for: UIControlState.normal)
        qrcodeLevelButton4.layer.borderWidth = 1
        qrcodeLevelButton4.layer.borderColor = SYS_Color.cgColor
        qrcodeLevelButton4.layer.cornerRadius = 4
        qrcodeLevelButton4.imageView?.layer.cornerRadius = 4
        qrcodeLevelButton4.clipsToBounds = true
        qrcodeLevelButton4.setTitleColor(UIColor.black, for: UIControlState.normal)
        qrcodeLevelButton4.setTitleColor(UIColor.white, for: UIControlState.selected)
        qrcodeLevelButton4.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        qrcodeLevelButton4.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        qrcodeLevelButton4.isSelected = self.dataSource.printingDirection == 270
        self.propertyScrollView.addSubview(qrcodeLevelButton4)
        
        // 序列化
        let serielLineLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: qrcodeLevelButton4.frame.maxY, width: CGFloat(80), height: normalHeight))
        serielLineLabel.text = "  " + MHTBase.internationalStringWith(str: "序列化")
        self.propertyScrollView.addSubview(serielLineLabel)
        
        let serielButton1 = UIButton()
        serielButton1.frame = CGRect.init(x: serielLineLabel.frame.maxX + 16, y: serielLineLabel.frame.minY + 5, width: buttonWidth, height: normalHeight - 10)
        serielButton1.setTitle("无", for: UIControlState.normal)
        serielButton1.layer.borderWidth = 1
        serielButton1.layer.borderColor = SYS_Color.cgColor
        serielButton1.layer.cornerRadius = 4
        serielButton1.imageView?.layer.cornerRadius = 4
        serielButton1.clipsToBounds = true
        serielButton1.setTitleColor(UIColor.black, for: UIControlState.normal)
        serielButton1.setTitleColor(UIColor.white, for: UIControlState.selected)
        serielButton1.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        serielButton1.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        serielButton1.isSelected = self.dataSource.printingDirection == 0
        self.propertyScrollView.addSubview(serielButton1)
        
        let serielButton2 = UIButton()
        serielButton2.frame = CGRect.init(x: serielButton1.frame.maxX + buttonGap, y: serielButton1.frame.minY, width: serielButton1.frame.width, height: serielButton1.frame.height)
        serielButton2.setTitle("递变", for: UIControlState.normal)
        serielButton2.layer.borderWidth = 1
        serielButton2.layer.borderColor = SYS_Color.cgColor
        serielButton2.layer.cornerRadius = 4
        serielButton2.imageView?.layer.cornerRadius = 4
        serielButton2.clipsToBounds = true
        serielButton2.setTitleColor(UIColor.black, for: UIControlState.normal)
        serielButton2.setTitleColor(UIColor.white, for: UIControlState.selected)
        serielButton2.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        serielButton2.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        serielButton2.isSelected = self.dataSource.printingDirection == 90
        self.propertyScrollView.addSubview(serielButton2)
        
        let serielButton3 = UIButton()
        serielButton3.frame = CGRect.init(x: serielButton2.frame.maxX + buttonGap, y: serielButton1.frame.minY, width: serielButton1.frame.width, height: serielButton1.frame.height)
        serielButton3.setTitle("文件", for: UIControlState.normal)
        serielButton3.layer.borderWidth = 1
        serielButton3.layer.borderColor = SYS_Color.cgColor
        serielButton3.layer.cornerRadius = 4
        serielButton3.imageView?.layer.cornerRadius = 4
        serielButton3.clipsToBounds = true
        serielButton3.setTitleColor(UIColor.black, for: UIControlState.normal)
        serielButton3.setTitleColor(UIColor.white, for: UIControlState.selected)
        serielButton3.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.normal)
        serielButton3.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.selected)
        serielButton3.isSelected = self.dataSource.printingDirection == 180
        self.propertyScrollView.addSubview(serielButton3)
        
        self.propertyScrollView.contentSize = CGSize(width: normalWidth, height: serielLineLabel.frame.maxY)
    }
    
    func createLineElementViewPropertyView(view: LineElementView) -> Void {
        // 通用高度
        let normalHeight = CGFloat(40)
        let normalWidth = self.propertyScrollView.frame.width
        
        // 名称
        let nameLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: CGFloat(0), width: CGFloat(80), height: normalHeight))
        nameLabel.text = "  " + MHTBase.internationalStringWith(str: "名称")
        self.propertyScrollView.addSubview(nameLabel)
        
        // 名称输入框，不可以编辑
        let nameTextField = UITextField(frame: CGRect.init(x: nameLabel.frame.maxX + 16, y: nameLabel.frame.minY, width: normalWidth - nameLabel.frame.width - 16 - 16, height: normalHeight))
        nameTextField.delegate = self
        nameTextField.placeholder = MHTBase.internationalStringWith(str: "线条")
        nameTextField.isUserInteractionEnabled = false
        nameTextField.textAlignment = NSTextAlignment.right
        nameTextField.textColor = SYS_LIGHT_GREY
        self.propertyScrollView.addSubview(nameTextField)
        
        // 分隔线
        let sepLabel1 = UILabel(frame: CGRect.init(x: CGFloat(0), y: nameLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel1.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel1)
        
        // 旋转角度
        let printDirectLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel1.frame.maxY, width: CGFloat(80), height: normalHeight))
        printDirectLabel.text = "  " + MHTBase.internationalStringWith(str: "旋转角度")
        self.propertyScrollView.addSubview(printDirectLabel)
        
        let buttonGap = CGFloat(10)
        let buttonLeftWidth = normalWidth - 16 - 16
        let buttonWidth = (buttonLeftWidth - printDirectLabel.frame.width - 3 * buttonGap) / 4
        let printDirectButton1 = UIButton()
        printDirectButton1.frame = CGRect.init(x: printDirectLabel.frame.maxX + 16, y: printDirectLabel.frame.minY + 5, width: buttonWidth, height: normalHeight - 10)
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
        self.propertyScrollView.addSubview(printDirectButton1)
        
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
        self.propertyScrollView.addSubview(printDirectButton2)
        
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
        self.propertyScrollView.addSubview(printDirectButton3)
        
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
        self.propertyScrollView.addSubview(printDirectButton4)
        
        // 分隔线
        let sepLabel2 = UILabel(frame: CGRect.init(x: CGFloat(0), y: printDirectLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel2.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel2)
        
        // 位置大小标题
        let titleLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel2.frame.maxY, width: normalWidth, height: normalHeight))
        titleLabel.backgroundColor = SYS_LIGHT_GREY
        titleLabel.text = "  " + MHTBase.internationalStringWith(str: "位置大小")
        self.propertyScrollView.addSubview(titleLabel)
        
        // 分隔线
        let sepLabel3 = UILabel(frame: CGRect.init(x: CGFloat(0), y: titleLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel3.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel3)
        
        // 立平居中
        let widthCenterButton = (normalWidth - 3 * 16) / 2
        let centerHorizontalButton = UIButton()
        centerHorizontalButton.frame = CGRect(x: 16, y: sepLabel3.frame.maxY + 5, width: widthCenterButton, height: printDirectButton1.frame.height)
        centerHorizontalButton.setTitle(MHTBase.internationalStringWith(str: "水平位置居中"), for: UIControlState.normal)
        centerHorizontalButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        centerHorizontalButton.setTitleColor(SYS_Color, for: UIControlState.highlighted)
        centerHorizontalButton.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.normal)
        centerHorizontalButton.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.highlighted)
        self.propertyScrollView.addSubview(centerHorizontalButton)
        
        // 垂直居中
        let centerVaticalButton = UIButton()
        centerVaticalButton.frame = CGRect(x: centerHorizontalButton.frame.maxX + 16, y: centerHorizontalButton.frame.minY, width: widthCenterButton, height: centerHorizontalButton.frame.height)
        centerVaticalButton.setTitle(MHTBase.internationalStringWith(str: "垂直位置居中"), for: UIControlState.normal)
        centerVaticalButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        centerVaticalButton.setTitleColor(SYS_Color, for: UIControlState.highlighted)
        centerVaticalButton.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.normal)
        centerVaticalButton.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.highlighted)
        self.propertyScrollView.addSubview(centerVaticalButton)
        
        let sepLabel4 = UILabel(frame: CGRect.init(x: CGFloat(0), y: centerHorizontalButton.frame.maxY + 5, width: normalWidth, height: CGFloat(0.5)))
        sepLabel4.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel4)
        
        // 位置上
        let topPositionLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel4.frame.maxY, width: CGFloat(80), height: normalHeight))
        topPositionLabel.text = "  " + MHTBase.internationalStringWith(str: "位置-上")
        self.propertyScrollView.addSubview(topPositionLabel)
        
        let topPositionTextField = UITextField(frame: CGRect.init(x: topPositionLabel.frame.maxX + 16, y: topPositionLabel.frame.minY, width: normalWidth - nameLabel.frame.width - 16 - 16 - 80 - 10, height: normalHeight))
        topPositionTextField.delegate = self
        topPositionTextField.text = "0"
        topPositionTextField.textAlignment = NSTextAlignment.right
        topPositionTextField.textColor = SYS_LIGHT_GREY
        self.propertyScrollView.addSubview(topPositionTextField)
        
        let topPositionAddButton = UIButton()
        topPositionAddButton.frame = CGRect(x: topPositionTextField.frame.maxX + 5, y: topPositionTextField.frame.minY + 5, width: 40, height: 30)
        topPositionAddButton.setTitle("+", for: UIControlState.normal)
        topPositionAddButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        topPositionAddButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        topPositionAddButton.tintColor = SYS_Color
        topPositionAddButton.layer.cornerRadius = 4
        topPositionAddButton.layer.borderColor = SYS_Color.cgColor
        topPositionAddButton.layer.borderWidth = 1
        self.propertyScrollView.addSubview(topPositionAddButton)
        
        let topPositionReduceButton = UIButton()
        topPositionReduceButton.frame = CGRect(x: topPositionAddButton.frame.maxX + 5, y: topPositionTextField.frame.minY + 5, width: 40, height: 30)
        topPositionReduceButton.setTitle("-", for: UIControlState.normal)
        topPositionReduceButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        topPositionReduceButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        topPositionReduceButton.tintColor = SYS_Color
        topPositionReduceButton.layer.cornerRadius = 4
        topPositionReduceButton.layer.borderColor = SYS_Color.cgColor
        topPositionReduceButton.layer.borderWidth = 1
        self.propertyScrollView.addSubview(topPositionReduceButton)
        
        let sepLabel5 = UILabel(frame: CGRect.init(x: CGFloat(0), y: topPositionLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel5.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel5)
        
        // 位置左
        let leftPositionLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel5.frame.maxY, width: CGFloat(80), height: normalHeight))
        leftPositionLabel.text = "  " + MHTBase.internationalStringWith(str: "位置-左")
        self.propertyScrollView.addSubview(leftPositionLabel)
        
        let leftPositionTextField = UITextField(frame: CGRect.init(x: leftPositionLabel.frame.maxX + 16, y: leftPositionLabel.frame.minY, width: normalWidth - nameLabel.frame.width - 16 - 16 - 80 - 10, height: normalHeight))
        leftPositionTextField.delegate = self
        leftPositionTextField.text = "0"
        leftPositionTextField.textAlignment = NSTextAlignment.right
        leftPositionTextField.textColor = SYS_LIGHT_GREY
        self.propertyScrollView.addSubview(leftPositionTextField)
        
        let leftPositionAddButton = UIButton()
        leftPositionAddButton.frame = CGRect(x: leftPositionTextField.frame.maxX + 5, y: leftPositionTextField.frame.minY + 5, width: 40, height: 30)
        leftPositionAddButton.setTitle("+", for: UIControlState.normal)
        leftPositionAddButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        leftPositionAddButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        leftPositionAddButton.tintColor = SYS_Color
        leftPositionAddButton.layer.cornerRadius = 4
        leftPositionAddButton.layer.borderColor = SYS_Color.cgColor
        leftPositionAddButton.layer.borderWidth = 1
        self.propertyScrollView.addSubview(leftPositionAddButton)
        
        let leftPositionReduceButton = UIButton()
        leftPositionReduceButton.frame = CGRect(x: leftPositionAddButton.frame.maxX + 5, y: leftPositionAddButton.frame.minY, width: 40, height: 30)
        leftPositionReduceButton.setTitle("-", for: UIControlState.normal)
        leftPositionReduceButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        leftPositionReduceButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        leftPositionReduceButton.tintColor = SYS_Color
        leftPositionReduceButton.layer.cornerRadius = 4
        leftPositionReduceButton.layer.borderColor = SYS_Color.cgColor
        leftPositionReduceButton.layer.borderWidth = 1
        self.propertyScrollView.addSubview(leftPositionReduceButton)
        
        let sepLabel6 = UILabel(frame: CGRect.init(x: CGFloat(0), y: leftPositionLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel6.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel6)
        
        self.propertyScrollView.contentSize = CGSize(width: normalWidth, height: sepLabel6.frame.maxY)
    }
    
    func createRectElementViewPropertyView(view: RectElementView) -> Void {
        // 通用高度
        let normalHeight = CGFloat(40)
        let normalWidth = self.propertyScrollView.frame.width
        
        // 名称
        let nameLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: CGFloat(0), width: CGFloat(80), height: normalHeight))
        nameLabel.text = "  " + MHTBase.internationalStringWith(str: "名称")
        self.propertyScrollView.addSubview(nameLabel)
        
        // 名称输入框，不可以编辑
        let nameTextField = UITextField(frame: CGRect.init(x: nameLabel.frame.maxX + 16, y: nameLabel.frame.minY, width: normalWidth - nameLabel.frame.width - 16 - 16, height: normalHeight))
        nameTextField.delegate = self
        nameTextField.placeholder = MHTBase.internationalStringWith(str: "距形")
        nameTextField.isUserInteractionEnabled = false
        nameTextField.textAlignment = NSTextAlignment.right
        nameTextField.textColor = SYS_LIGHT_GREY
        self.propertyScrollView.addSubview(nameTextField)
        
        // 分隔线
        let sepLabel1 = UILabel(frame: CGRect.init(x: CGFloat(0), y: nameLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel1.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel1)
        
        // 旋转角度
        let printDirectLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel1.frame.maxY, width: CGFloat(80), height: normalHeight))
        printDirectLabel.text = "  " + MHTBase.internationalStringWith(str: "旋转角度")
        self.propertyScrollView.addSubview(printDirectLabel)
        
        let buttonGap = CGFloat(10)
        let buttonLeftWidth = normalWidth - 16 - 16
        let buttonWidth = (buttonLeftWidth - printDirectLabel.frame.width - 3 * buttonGap) / 4
        let printDirectButton1 = UIButton()
        printDirectButton1.frame = CGRect.init(x: printDirectLabel.frame.maxX + 16, y: printDirectLabel.frame.minY + 5, width: buttonWidth, height: normalHeight - 10)
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
        self.propertyScrollView.addSubview(printDirectButton1)
        
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
        self.propertyScrollView.addSubview(printDirectButton2)
        
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
        self.propertyScrollView.addSubview(printDirectButton3)
        
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
        self.propertyScrollView.addSubview(printDirectButton4)
        
        // 分隔线
        let sepLabel2 = UILabel(frame: CGRect.init(x: CGFloat(0), y: printDirectLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel2.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel2)
        
        // 位置大小标题
        let titleLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel2.frame.maxY, width: normalWidth, height: normalHeight))
        titleLabel.backgroundColor = SYS_LIGHT_GREY
        titleLabel.text = "  " + MHTBase.internationalStringWith(str: "位置大小")
        self.propertyScrollView.addSubview(titleLabel)
        
        // 分隔线
        let sepLabel3 = UILabel(frame: CGRect.init(x: CGFloat(0), y: titleLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel3.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel3)
        
        // 立平居中
        let widthCenterButton = (normalWidth - 3 * 16) / 2
        let centerHorizontalButton = UIButton()
        centerHorizontalButton.frame = CGRect(x: 16, y: sepLabel3.frame.maxY + 5, width: widthCenterButton, height: printDirectButton1.frame.height)
        centerHorizontalButton.setTitle(MHTBase.internationalStringWith(str: "水平位置居中"), for: UIControlState.normal)
        centerHorizontalButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        centerHorizontalButton.setTitleColor(SYS_Color, for: UIControlState.highlighted)
        centerHorizontalButton.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.normal)
        centerHorizontalButton.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.highlighted)
        self.propertyScrollView.addSubview(centerHorizontalButton)
        
        // 垂直居中
        let centerVaticalButton = UIButton()
        centerVaticalButton.frame = CGRect(x: centerHorizontalButton.frame.maxX + 16, y: centerHorizontalButton.frame.minY, width: widthCenterButton, height: centerHorizontalButton.frame.height)
        centerVaticalButton.setTitle(MHTBase.internationalStringWith(str: "垂直位置居中"), for: UIControlState.normal)
        centerVaticalButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        centerVaticalButton.setTitleColor(SYS_Color, for: UIControlState.highlighted)
        centerVaticalButton.setBackgroundImage(UIImage(named: "BlueButton"), for: UIControlState.normal)
        centerVaticalButton.setBackgroundImage(UIImage(named: "WhiteButton"), for: UIControlState.highlighted)
        self.propertyScrollView.addSubview(centerVaticalButton)
        
        let sepLabel4 = UILabel(frame: CGRect.init(x: CGFloat(0), y: centerHorizontalButton.frame.maxY + 5, width: normalWidth, height: CGFloat(0.5)))
        sepLabel4.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel4)
        
        // 位置上
        let topPositionLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel4.frame.maxY, width: CGFloat(80), height: normalHeight))
        topPositionLabel.text = "  " + MHTBase.internationalStringWith(str: "位置-上")
        self.propertyScrollView.addSubview(topPositionLabel)
        
        let topPositionTextField = UITextField(frame: CGRect.init(x: topPositionLabel.frame.maxX + 16, y: topPositionLabel.frame.minY, width: normalWidth - nameLabel.frame.width - 16 - 16 - 80 - 10, height: normalHeight))
        topPositionTextField.delegate = self
        topPositionTextField.text = "0"
        topPositionTextField.textAlignment = NSTextAlignment.right
        topPositionTextField.textColor = SYS_LIGHT_GREY
        self.propertyScrollView.addSubview(topPositionTextField)
        
        let topPositionAddButton = UIButton()
        topPositionAddButton.frame = CGRect(x: topPositionTextField.frame.maxX + 5, y: topPositionTextField.frame.minY + 5, width: 40, height: 30)
        topPositionAddButton.setTitle("+", for: UIControlState.normal)
        topPositionAddButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        topPositionAddButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        topPositionAddButton.tintColor = SYS_Color
        topPositionAddButton.layer.cornerRadius = 4
        topPositionAddButton.layer.borderColor = SYS_Color.cgColor
        topPositionAddButton.layer.borderWidth = 1
        self.propertyScrollView.addSubview(topPositionAddButton)
        
        let topPositionReduceButton = UIButton()
        topPositionReduceButton.frame = CGRect(x: topPositionAddButton.frame.maxX + 5, y: topPositionTextField.frame.minY + 5, width: 40, height: 30)
        topPositionReduceButton.setTitle("-", for: UIControlState.normal)
        topPositionReduceButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        topPositionReduceButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        topPositionReduceButton.tintColor = SYS_Color
        topPositionReduceButton.layer.cornerRadius = 4
        topPositionReduceButton.layer.borderColor = SYS_Color.cgColor
        topPositionReduceButton.layer.borderWidth = 1
        self.propertyScrollView.addSubview(topPositionReduceButton)
        
        let sepLabel5 = UILabel(frame: CGRect.init(x: CGFloat(0), y: topPositionLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel5.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel5)
        
        // 位置左
        let leftPositionLabel = UILabel(frame: CGRect.init(x: CGFloat(0), y: sepLabel5.frame.maxY, width: CGFloat(80), height: normalHeight))
        leftPositionLabel.text = "  " + MHTBase.internationalStringWith(str: "位置-左")
        self.propertyScrollView.addSubview(leftPositionLabel)
        
        let leftPositionTextField = UITextField(frame: CGRect.init(x: leftPositionLabel.frame.maxX + 16, y: leftPositionLabel.frame.minY, width: normalWidth - nameLabel.frame.width - 16 - 16 - 80 - 10, height: normalHeight))
        leftPositionTextField.delegate = self
        leftPositionTextField.text = "0"
        leftPositionTextField.textAlignment = NSTextAlignment.right
        leftPositionTextField.textColor = SYS_LIGHT_GREY
        self.propertyScrollView.addSubview(leftPositionTextField)
        
        let leftPositionAddButton = UIButton()
        leftPositionAddButton.frame = CGRect(x: leftPositionTextField.frame.maxX + 5, y: leftPositionTextField.frame.minY + 5, width: 40, height: 30)
        leftPositionAddButton.setTitle("+", for: UIControlState.normal)
        leftPositionAddButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        leftPositionAddButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        leftPositionAddButton.tintColor = SYS_Color
        leftPositionAddButton.layer.cornerRadius = 4
        leftPositionAddButton.layer.borderColor = SYS_Color.cgColor
        leftPositionAddButton.layer.borderWidth = 1
        self.propertyScrollView.addSubview(leftPositionAddButton)
        
        let leftPositionReduceButton = UIButton()
        leftPositionReduceButton.frame = CGRect(x: leftPositionAddButton.frame.maxX + 5, y: leftPositionAddButton.frame.minY, width: 40, height: 30)
        leftPositionReduceButton.setTitle("-", for: UIControlState.normal)
        leftPositionReduceButton.setTitleColor(SYS_Color, for: UIControlState.normal)
        leftPositionReduceButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        leftPositionReduceButton.tintColor = SYS_Color
        leftPositionReduceButton.layer.cornerRadius = 4
        leftPositionReduceButton.layer.borderColor = SYS_Color.cgColor
        leftPositionReduceButton.layer.borderWidth = 1
        self.propertyScrollView.addSubview(leftPositionReduceButton)
        
        let sepLabel6 = UILabel(frame: CGRect.init(x: CGFloat(0), y: leftPositionLabel.frame.maxY, width: normalWidth, height: CGFloat(0.5)))
        sepLabel6.backgroundColor = UIColor.black
        self.propertyScrollView.addSubview(sepLabel6)
        
        self.propertyScrollView.contentSize = CGSize(width: normalWidth, height: sepLabel6.frame.maxY)
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
    
    // 文本框旋转方向变动
    @objc func rotationalDirectionTextElement(sender: UIButton) -> Void {
        // 判断是否已选择
        if sender.isSelected {
            return
        }
        
        // 原来的按钮取消选择状态
        let originTag = self.dataSource.textControl![(self.viewSelectedElement?.controlIndex)!].rotate! + 4000
        let originButton = self.propertyScrollView.viewWithTag(originTag) as! UIButton
        originButton.isSelected = false
        sender.isSelected = true
        
        // 旋转角度
        let rotation = sender.tag - 4000
        
        // 保存数据
        self.dataSource.textControl![(self.viewSelectedElement?.controlIndex)!].rotate = rotation
        
        // 元素旋转
        let transform = CGAffineTransform(rotationAngle: CGFloat(rotation) * CGFloat.pi / 180.0)
        self.viewSelectedElement!.transform = transform
    }
    
    // 位置变化
    @objc func positionChangeElement(sender: UIButton) {
        if 50 == sender.tag {
            self.viewSelectedElement?.frame = CGRect(
                x: (self.editView.frame.width - (self.viewSelectedElement?.frame.width)!) / 2,
                y: (self.viewSelectedElement?.frame.minY)!,
                width: (self.viewSelectedElement?.frame.width)!,
                height: (self.viewSelectedElement?.frame.height)!)
            self.resetModelRectWithView(view: self.viewSelectedElement!)
            return
        }
        
        if 55 == sender.tag {
            self.viewSelectedElement?.frame = CGRect(
                x: (self.viewSelectedElement?.frame.minX)!,
                y: (self.editView.frame.height - (self.viewSelectedElement?.frame.height)!) / 2,
                width: (self.viewSelectedElement?.frame.width)!,
                height: (self.viewSelectedElement?.frame.height)!)
            self.resetModelRectWithView(view: self.viewSelectedElement!)
            return
        }
    }
    
    // x/y坐标变化
    @objc func xypointChangeAction(sender: UIButton) -> Void {
        // 增加y坐标
        if 60 == sender.tag {
            var newYPoint = (self.viewSelectedElement?.frame.minY)! + 1
            let maxYPoint = self.editView.frame.height - (self.viewSelectedElement?.frame.height)!
            if newYPoint > maxYPoint {
                newYPoint = maxYPoint
            }
            self.viewSelectedElement?.frame.origin.y = newYPoint
            let textField = self.propertyScrollView.viewWithTag(63) as! UITextField
            textField.text = newYPoint.description
            self.resetModelRectWithView(view: self.viewSelectedElement!)
            return
        }
        
        // 减少y坐标
        if 65 == sender.tag {
            var newYPoint = (self.viewSelectedElement?.frame.minY)! - 1
            if newYPoint < 0 {
                newYPoint = 0
            }
            self.viewSelectedElement?.frame.origin.y = newYPoint
            let textField = self.propertyScrollView.viewWithTag(63) as! UITextField
            textField.text = newYPoint.description
            self.resetModelRectWithView(view: self.viewSelectedElement!)
            return
        }
        
        // 增加x坐标
        if 70 == sender.tag {
            var newXPoint = (self.viewSelectedElement?.frame.minX)! + 1
            let maxXPoint = self.editView.frame.width - (self.viewSelectedElement?.frame.width)!
            if newXPoint > maxXPoint {
                newXPoint = maxXPoint
            }
            self.viewSelectedElement?.frame.origin.x = newXPoint
            let textField = self.propertyScrollView.viewWithTag(73) as! UITextField
            textField.text = newXPoint.description
            self.resetModelRectWithView(view: self.viewSelectedElement!)
            return
        }
        
        // 减少x坐标
        if 75 == sender.tag {
            var newXPoint = (self.viewSelectedElement?.frame.minX)! - 1
            if newXPoint < 0 {
                newXPoint = 0
            }
            self.viewSelectedElement?.frame.origin.x = newXPoint
            let textField = self.propertyScrollView.viewWithTag(73) as! UITextField
            textField.text = newXPoint.description
            self.resetModelRectWithView(view: self.viewSelectedElement!)
            return
        }
    }
    
    // 字体变大事件
    @objc func wordSizeChangeAction(sender: UIButton) -> Void {
        if 85 == sender.tag {
            let newFontSize = self.dataSource.textControl![(self.viewSelectedElement?.controlIndex)!].TEXT_SIZE! + 1
            let textField = self.propertyScrollView.viewWithTag(80) as! UITextField
            textField.text = newFontSize.description
            return
        }
        
        if 90 == sender.tag {
            var newFontSize = self.dataSource.textControl![(self.viewSelectedElement?.controlIndex)!].TEXT_SIZE! - 1
            newFontSize = newFontSize < 8 ? 8 : newFontSize
            let textField = self.propertyScrollView.viewWithTag(80) as! UITextField
            textField.text = newFontSize.description
            return
        }
    }
}

// 属性窗口的输入框代理
extension AddLabelViewController: UITextFieldDelegate {
    // 结束输入事件
    func textFieldDidEndEditing(_ textField: UITextField) {
        let textInput = textField.text
        if nil == textInput || 0 >= (textInput! as NSString).length {
            return
        }
        
        // 编辑窗口的名称编辑
        if textField.tag == 100 {
            self.dataSource.labelName = textInput
            return
        }
    }
}
