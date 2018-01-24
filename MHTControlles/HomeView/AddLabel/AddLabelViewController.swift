//
//  AddLabelViewController.swift
//  MHTLabelPrinter
//
//  Created by 程骋 on 2018/1/4.
//  Copyright © 2018年 MHT. All rights reserved.
//

import UIKit

class AddLabelViewController: UIViewController {
    fileprivate var editView: UIView!
    fileprivate var pageView: UIView!
    fileprivate var mainScrollView: UIScrollView!
    fileprivate var pageScrollView: mapleScroollView!
    
    // 是否多选
    fileprivate var isMultSelected = false
    fileprivate var multSelectedBarButton: UIBarButtonItem!
    fileprivate var multSelectedImageViewLabelPage: UIImageView!
    
    // 是否剪辑图片
    fileprivate var isEditPickedImage = false
    
    // 当前编辑的数据
    var dataSource: TemplateModel = TemplateModel()
    
    // 界面加载后，创建自定义的UI
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setAddLabellUI()
    }
    
    // 创建自自定义UI
    func setAddLabellUI() -> Void {
        let navMaxY = self.navigationController?.navigationBar.frame.maxY
        let navRBtn1 = UIBarButtonItem.init(image: UIImage.init(named: "navDeleting"), style: .plain, target: self, action: #selector(deleteElementAction(sender:)))
        let navRBtn2 = UIBarButtonItem.init(image: UIImage.init(named: "navPrint"), style: .done, target: self, action: nil)
        let navRBtn3 = UIBarButtonItem.init(image: UIImage.init(named: "navMSelect"), style: .done, target: self, action: #selector(multSelectedChangeAction(sender:)))
        self.multSelectedBarButton = navRBtn3

        let navSpace = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: self, action: nil)
        navSpace.width = -50
        self.navigationItem.rightBarButtonItems = [navRBtn1,navSpace,navRBtn2,navSpace,navRBtn3]
        
        let addLBI = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_width, height: SCREEN_height))
        addLBI.image = UIImage.init(named: "homeMainIV")
        self.view.addSubview(addLBI)
        
        // 当前编辑区
        self.editView = UIView.init(frame: CGRect.init(x: 10, y: navMaxY! + 80, width: SCREEN_width-20, height: (SCREEN_width - 20) * 5 / 8))
        self.editView.backgroundColor = UIColor.white
        self.editView.layer.borderWidth = 0.5
        self.editView.layer.borderColor = UIColor.black.cgColor
        self.view.addSubview(self.editView)
        
        let tapSingle = UITapGestureRecognizer(target: self, action: #selector(elementEditViewTapAction(gesture:)))
        tapSingle.numberOfTapsRequired = 1
        tapSingle.numberOfTouchesRequired = 1
        self.editView.addGestureRecognizer(tapSingle)
        
        let aLBottomStrY = self.editView.frame.maxY + 79
        pageView = UIView.init(frame: CGRect.init(x: 0, y: aLBottomStrY, width: SCREEN_width, height: SCREEN_height - aLBottomStrY))
        pageView.backgroundColor = UIColor.white
        self.view.addSubview(pageView)
        addPageScrollView()
    }
    
    // 添加底部分页滚动内容
    func addPageScrollView() -> Void {
        let pageTA1 = [MHTBase.internationalStringWith(str: "标签"),MHTBase.internationalStringWith(str: "插入"),MHTBase.internationalStringWith(str: "属性")]
        self.pageScrollView = mapleScroollView.init()
        self.pageScrollView.lineColor = UIColor.clear
        self.pageScrollView.setData(pageTA1, normalColor: UIColor.black, select: UIColor.red, font: UIFont.systemFont(ofSize: 14), selectedIndex: 1)

        pageView.addSubview(self.pageScrollView)
        self.pageScrollView.getIndex({ (title, index) in
            UIView.animate(withDuration: 0.3, animations: {
                self.mainScrollView.contentOffset = CGPoint.init(x: CGFloat(index) * SCREEN_width, y: 0)
            })
        })
        self.mainScrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 40, width: SCREEN_width, height: pageView.bounds.height - 40))
        self.mainScrollView.delegate = self
        self.mainScrollView.isPagingEnabled = true
        self.mainScrollView.bounces = false
        self.mainScrollView.showsHorizontalScrollIndicator = false
        self.mainScrollView.contentSize = CGSize.init(width: CGFloat(pageTA1.count) * SCREEN_width ,height: 0)
        pageView.addSubview(mainScrollView!)
        
        for m in 0..<pageTA1.count {
            let mapleView = UIView.init(frame: CGRect.init(x: CGFloat(m) * SCREEN_width, y: 0, width: SCREEN_width, height: pageView.bounds.height - 40))
            switch m {
            case 0 :
                let btnImage = ["AddNew","AddOpen","AddSave","AddSaveas","AddCopy","AddLock","AddDate","AddUpload","AddSelectMult"]
                let btnTitle = [MHTBase.internationalStringWith(str: "新建"),MHTBase.internationalStringWith(str: "打开"),MHTBase.internationalStringWith(str: "保存"),MHTBase.internationalStringWith(str: "另存为"),MHTBase.internationalStringWith(str: "拷贝"),MHTBase.internationalStringWith(str: "锁定"),MHTBase.internationalStringWith(str: "打印"),MHTBase.internationalStringWith(str: "上传"),MHTBase.internationalStringWith(str: "多选")]
                for i in 0...2 {
                    for j in 0...3 {
                        if i == 2 && j == 1 {
                            break
                        }
                        let addBtnV = self.createmapleViewButton(imageName: btnImage[4*i+j], title: btnTitle[4*i+j], frame: CGRect.init(x: 0 + CGFloat(j)*SCREEN_width/4, y: CGFloat(i)*mapleView.bounds.height/3, width: SCREEN_width/4, height: mapleView.bounds.height/3))
                        let tap = UITapGestureRecognizer(target: self, action: #selector(labelTabButtonAction(_:)))
                        tap.numberOfTapsRequired = 1
                        tap.numberOfTouchesRequired = 1
                        addBtnV.tag = 4*i+j
                        addBtnV.addGestureRecognizer(tap)
                        mapleView.addSubview(addBtnV)
                    }
                }
            case 1:
                let btnImage = ["AddText","AddBarcode","AddTDcode","AddImage","Addlogo","AddLine","AddRectangle","AddTable","AddDate"]
                let btnTitle = [MHTBase.internationalStringWith(str: "文本"),
                                MHTBase.internationalStringWith(str: "一维码"),
                                MHTBase.internationalStringWith(str: "二维码"),
                                MHTBase.internationalStringWith(str: "图片"),
                                MHTBase.internationalStringWith(str: "Logo"),
                                MHTBase.internationalStringWith(str: "线条"),
                                MHTBase.internationalStringWith(str: "矩形"),
                                MHTBase.internationalStringWith(str: "表格"),
                                MHTBase.internationalStringWith(str: "日期")]
                for i in 0...2 {
                    for j in 0...3 {
                        if i == 2 && j == 1 {
                            break
                        }
                        let addBtnV = self.createmapleViewButton(imageName: btnImage[4*i+j], title: btnTitle[4*i+j], frame: CGRect.init(x: 0 + CGFloat(j)*SCREEN_width/4, y: CGFloat(i)*mapleView.bounds.height/3, width: SCREEN_width/4, height: mapleView.bounds.height/3))
                        let tap = UITapGestureRecognizer(target: self, action: #selector(insertElementTabButtonAction(_:)))
                        tap.numberOfTapsRequired = 1
                        tap.numberOfTouchesRequired = 1
                        addBtnV.tag = 4*i+j
                        addBtnV.addGestureRecognizer(tap)
                        mapleView.addSubview(addBtnV)
                    }
                }
            case 2:
                print(2)
            default:
                print(4)
            }
            mainScrollView.addSubview(mapleView)
        }
        self.mainScrollView.contentOffset = CGPoint.init(x: SCREEN_width, y: 0)
    }
    
    // 分页的按钮统一创建函数
    func createmapleViewButton(imageName: String, title: String, frame: CGRect) -> UIView {
        let addBtnV = UIView.init(frame: frame)
        
        // 图片
        let tempImageSize = addBtnV.bounds.height - CGFloat((5 + 6 + 16) * MHTBase.autoScreen());
        let tempImageY = CGFloat(5 * MHTBase.autoScreen());
        let tempImageX = (addBtnV.bounds.width - tempImageSize) / 2;
        let addImageView = UIImageView(frame: CGRect.init(x: tempImageX, y: tempImageY, width: tempImageSize, height: tempImageSize));
        addImageView.isUserInteractionEnabled = true;
        addImageView.image = UIImage(named: imageName);
        addBtnV.addSubview(addImageView)
        
        // 保存多选按钮对象
        if("多选" == title) {
            self.multSelectedImageViewLabelPage = addImageView
        }
        
        // 按钮标题
        let addBtn = UIButton.init(frame: CGRect.init(x: tempImageY, y: addImageView.frame.maxY + CGFloat(3 * MHTBase.autoScreen()), width: addBtnV.bounds.width - 2 * tempImageY, height: CGFloat(16 * MHTBase.autoScreen())))
        addBtn.setTitle(title, for: .normal)
        addBtn.setTitleColor(UIColor.black, for: .normal)
        addBtn.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(14 * MHTBase.autoScreen()))
        addBtnV.addSubview(addBtn)
        
        return addBtnV
    }
    
    func addPanActionForElement(elementView: ElementView) -> Void {
        let pan = UIPanGestureRecognizer(target:self, action:#selector(elementPanAction(gesture:)))
        pan.maximumNumberOfTouches = 1
        if let gesturesArray = elementView.gestureRecognizers {
            for oriGesture in gesturesArray {
                if oriGesture.isKind(of: UITapGestureRecognizer.self) {
                    oriGesture.require(toFail: pan)
                }
            }
        }
        elementView.addGestureRecognizer(pan)
    }
    
    func addTapActionForElementView(elementView: ElementView) -> Void {
        // 添加单击事件
        let tapSingle = UITapGestureRecognizer(target: self, action: #selector(elementSingleTapAction(_:)))
        tapSingle.numberOfTapsRequired = 1
        tapSingle.numberOfTouchesRequired = 1
        elementView.addGestureRecognizer(tapSingle)
        
        // 添加双击事件
        let tapDouble = UITapGestureRecognizer(target: self, action: #selector(elementDoubleTapAction(gesture:)))
        tapDouble.numberOfTapsRequired = 2
        tapDouble.numberOfTouchesRequired = 1
        tapSingle.require(toFail: tapDouble)
        elementView.addGestureRecognizer(tapDouble)
    }
}

/**
 * 控制器中的按钮事件
 */
extension AddLabelViewController {
    // 清空元素的选择状态
    func clearElementSelected() -> Void {
        for subView in self.editView.subviews {
            let subElementView = subView as! ElementView
            subElementView.setIsSelected(isSelected: false)
            subElementView.resignKeyboardAction()
        }
    }
    
    // 删除元素按钮事件
    @objc func deleteElementAction(sender: UIBarButtonItem) -> Void {
        for subView in self.editView.subviews {
            let subElementView = subView as! ElementView
            if(subElementView.getIsSelected()) {
                subElementView.removeFromSuperview()
            }
        }
    }
    
    // 多选，单选切换事件
    @objc func multSelectedChangeAction(sender: UIBarButtonItem?) -> Void {
        self.isMultSelected = !self.isMultSelected
        if(self.isMultSelected) {
            self.multSelectedBarButton.image = UIImage(named: "navSSelect")
            self.multSelectedImageViewLabelPage.image = UIImage(named: "AddSelectSingle")
        } else {
            self.multSelectedBarButton.image = UIImage(named: "navMSelect")
            self.multSelectedImageViewLabelPage.image = UIImage(named: "AddSelectMult")
            
            // 多选变成单选后，必须将所有已选择的元素控件变为未选择
            self.clearElementSelected()
        }
     }
    
    // 插入分页中的按钮事件处理
    @objc func insertElementTabButtonAction(_ gesture: UIGestureRecognizer) -> Void {
        let tag = gesture.view?.tag ?? -1
        let subViewNum = self.editView.subviews.count
        let xPoint = CGFloat(5 + subViewNum * 16)
        let yPoint = CGFloat(5 + subViewNum * 16)
        switch tag {
            case 0:
                let width = CGFloat(12 * 8)
                let height = CGFloat(30)
                let xPointResize = ((xPoint + width) > self.editView.frame.size.width) ? (self.editView.frame.size.width - width) : xPoint
                let yPointResize = ((yPoint + height) > self.editView.frame.size.height) ? (self.editView.frame.size.height - width) : yPoint
                let tempView = TextElementView.init(frame: CGRect(x: xPointResize, y: yPointResize, width: width, height: height))
                tempView.setTextString(text: "请输入内容")
                self.editView.addSubview(tempView)
                
                // 添加单击和双击事件
                self.addTapActionForElementView(elementView: tempView)
                
                // 添加拖动事件，必须放在点击手势之后，因为拖动手势需要让点击手势无效，避免冲突
                self.addPanActionForElement(elementView: tempView)
            
                // 绑定变宽回调
                tempView.widthChangeClosure = self.elementWidthChangeClosureAction(view: translation: status:)
            case 1:
                let width = CGFloat(20 * 8)
                let height = CGFloat(10 * 8)
                let xPointResize = ((xPoint + width) > self.editView.frame.size.width) ? (self.editView.frame.size.width - width) : xPoint
                let yPointResize = ((yPoint + height) > self.editView.frame.size.height) ? (self.editView.frame.size.height - width) : yPoint
                let barcodeView = BarcodeElementView.init(frame: CGRect(x: xPointResize, y: yPointResize, width: width, height: height))
                let barcodeString = "双击编辑"
                let barcodeImage = MHTBase.creatBarCodeImage(content: barcodeString, size: barcodeView.frame.size)
                barcodeView.imageView!.image = barcodeImage
                barcodeView.titleLabel!.text = barcodeString
                self.editView.addSubview(barcodeView)
            
                // 添加单击和双击事件
                self.addTapActionForElementView(elementView: barcodeView)
            
                // 添加拖动事件，必须放在点击手势之后，因为拖动手势需要让点击手势无效，避免冲突
                self.addPanActionForElement(elementView: barcodeView)
            
                // 绑定回调
                barcodeView.widthChangeClosure = self.elementWidthChangeClosureAction(view: translation: status:)
                barcodeView.heightChangeClosure = self.elementHeightChangeClosureAction(view: translation: status:)
            case 2:
                let width = CGFloat(10 * 8)
                let xPointResize = ((xPoint + width) > self.editView.frame.size.width) ? (self.editView.frame.size.width - width) : xPoint
                let yPointResize = ((yPoint + width) > self.editView.frame.size.height) ? (self.editView.frame.size.height - width) : yPoint
                let barcodeView = QRCodeElementView.init(frame: CGRect(x: xPointResize, y: yPointResize, width: width, height: width))
                let barcodeString = "双击编辑"
                let barcodeImage = MHTBase.creatQRCodeImage(content: barcodeString, iconName: nil, size: barcodeView.frame.size)
                barcodeView.imageView!.image = barcodeImage
                barcodeView.title = barcodeString
                self.editView.addSubview(barcodeView)
            
                // 添加单击和双击事件
                self.addTapActionForElementView(elementView: barcodeView)
            
                // 添加拖动事件，必须放在点击手势之后，因为拖动手势需要让点击手势无效，避免冲突
                self.addPanActionForElement(elementView: barcodeView)
            
                // 绑定回调
                barcodeView.widthChangeClosure = self.elementWidthChangeClosureAction(view: translation: status:)
                barcodeView.heightChangeClosure = self.elementHeightChangeClosureAction(view: translation: status:)
            case 3:
                let alertController = UIAlertController(title: "提示",
                                                        message: "是否要剪辑图片？", preferredStyle: .actionSheet)
                let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                let noAction = UIAlertAction(title: "不要剪辑", style: .default, handler: {
                    action in
                    self.isEditPickedImage = false
                    self.pickImageFromAlbum()
                })
                let yesAction = UIAlertAction(title: "剪辑", style: .default, handler: {
                    action in
                    self.isEditPickedImage = true
                    self.pickImageFromAlbum()
                })
                alertController.addAction(cancelAction)
                alertController.addAction(noAction)
                alertController.addAction(yesAction)
                self.present(alertController, animated: true, completion: nil)
            case 4:
                ToastView.instance.showToast(content: "敬请期待")
            case 5:
                let width = CGFloat(16 * 8)
                let xPointResize = ((xPoint + width) > self.editView.frame.size.width) ? (self.editView.frame.size.width - width) : xPoint
                let yPointResize = ((yPoint + width) > self.editView.frame.size.height) ? (self.editView.frame.size.height - width) : yPoint
                let barcodeView = LineElementView.init(frame: CGRect(x: xPointResize, y: yPointResize, width: width, height: 4))
                self.editView.addSubview(barcodeView)
                
                // 添加单击和双击事件
                self.addTapActionForElementView(elementView: barcodeView)
                
                // 添加拖动事件，必须放在点击手势之后，因为拖动手势需要让点击手势无效，避免冲突
                self.addPanActionForElement(elementView: barcodeView)
            
                // 绑定回调
                barcodeView.widthChangeClosure = self.elementWidthChangeClosureAction(view: translation: status:)
                barcodeView.heightChangeClosure = self.elementHeightChangeClosureAction(view: translation: status:)
            case 6:
                let width = CGFloat(20 * 8)
                let xPointResize = ((xPoint + width) > self.editView.frame.size.width) ? (self.editView.frame.size.width - width) : xPoint
                let yPointResize = ((yPoint + width) > self.editView.frame.size.height) ? (self.editView.frame.size.height - width) : yPoint
                let barcodeView = RectElementView.init(frame: CGRect(x: xPointResize, y: yPointResize, width: width, height: width / 2))
                self.editView.addSubview(barcodeView)
                
                // 添加单击和双击事件
                self.addTapActionForElementView(elementView: barcodeView)
                
                // 添加拖动事件，必须放在点击手势之后，因为拖动手势需要让点击手势无效，避免冲突
                self.addPanActionForElement(elementView: barcodeView)
            
                // 绑定回调
                barcodeView.widthChangeClosure = self.elementWidthChangeClosureAction(view: translation: status:)
                barcodeView.heightChangeClosure = self.elementHeightChangeClosureAction(view: translation: status:)
            case 7:
                ToastView.instance.showToast(content: "敬请期待")
            case 8:
                let width = CGFloat(25 * 8)
                let height = CGFloat(30)
                let xPointResize = ((xPoint + width) > self.editView.frame.size.width) ? (self.editView.frame.size.width - width) : xPoint
                let yPointResize = ((yPoint + height) > self.editView.frame.size.height) ? (self.editView.frame.size.height - width) : yPoint
                let tempView = DateElementView.init(frame: CGRect(x: xPointResize, y: yPointResize, width: width, height: height))
                let currentdate = Date()
                let dateformatter = DateFormatter()
                dateformatter.dateFormat = " YYYY-MM-dd HH:mm:ss"
                let dateString = dateformatter.string(from: currentdate)
                tempView.setTextString(text: dateString)
                self.editView.addSubview(tempView)
                
                // 添加单击和双击事件
                self.addTapActionForElementView(elementView: tempView)
                
                // 添加拖动事件，必须放在点击手势之后，因为拖动手势需要让点击手势无效，避免冲突
                self.addPanActionForElement(elementView: tempView)
            
                // 绑定回调
                tempView.widthChangeClosure = self.elementWidthChangeClosureAction(view: translation: status:)
            default:
                print("insertElementTabButtonAction -1")
        }
    }
    
    // 标签分页中的按钮事件处理
    @objc func labelTabButtonAction(_ gesture: UIGestureRecognizer) -> Void {
        let tag = gesture.view?.tag ?? -1
        switch tag {
        case 0:
            print("labelTabButtonAction tag = \(tag)")
        case 1:
            print("labelTabButtonAction tag = \(tag)")
        case 2:
            print("labelTabButtonAction tag = \(tag)")
        case 3:
            print("labelTabButtonAction tag = \(tag)")
        case 4:
            print("labelTabButtonAction tag = \(tag)")
        case 5:
            print("labelTabButtonAction tag = \(tag)")
        case 6:
            print("labelTabButtonAction tag = \(tag)")
        case 7:
            ToastView.instance.showToast(content: "敬请期待")
        case 8:
            self.multSelectedChangeAction(sender: nil)
        default:
            print("labelTabButtonAction tag = \(tag)")
        }
    }
    
    // 属性分页事件
    @objc func propertyTabAction() -> Void {
        
    }
    
    // 编辑view的单击，主要是将已选择的元素取消选择状态
    @objc func elementEditViewTapAction(gesture: UIGestureRecognizer) -> Void {
        self.clearElementSelected()
    }
    
    // 编辑窗口中的元素单击事件
    @objc func elementSingleTapAction(_ gesture: UIGestureRecognizer) -> Void {
        let tempView = gesture.view! as! ElementView
        
        // 判断当前是单选还是多选
        if(!self.isMultSelected) {
            self.clearElementSelected()
        }
        
        tempView.setIsSelected(isSelected: true)
    }
    
    // 元素拖动
    @objc func elementPanAction(gesture: UIGestureRecognizer) -> Void {
        let point = gesture.location(in: self.editView)
        
        //设置矩形的位置
        let changeX = point.x - (gesture.view?.center.x)!
        let changeY = point.y - (gesture.view?.center.y)!
        gesture.view?.center = point
        
        // 多选时，需要将其他已选择的View也拖动
        for subView in self.editView.subviews {
            if subView != gesture.view && subView.isKind(of: ElementView.self) {
                let subElementView = subView as! ElementView
                if(subElementView.isSelected) {
                    subElementView.center = CGPoint(x: subElementView.center.x + changeX, y: subElementView.center.y + changeY)
                }
            }
        }
    }
    
    /**
     * 元素高度改变时的统一处理
     */
    func elementWidthChangeClosureAction(view: ElementView, translation: CGPoint, status: UIGestureRecognizerState) -> Void {
        for subView in self.editView.subviews {
            if subView != view && subView.isKind(of: ElementView.self) {
                let subElementView = subView as! ElementView
                if(subElementView.isSelected) {
                    subElementView.widthChangeAction(translation: translation, status: status)
                }
            }
        }
    }
    
    /**
     * 元素高度改变时的统一处理
     */
    func elementHeightChangeClosureAction(view: ElementView, translation: CGPoint, status: UIGestureRecognizerState) -> Void {
        for subView in self.editView.subviews {
            if subView != view && subView.isKind(of: ElementView.self) && !subView.isKind(of: TextElementView.self) {
                let subElementView = subView as! ElementView
                if(subElementView.isSelected) {
                    subElementView.heightChangeAction(translation: translation, status: status)
                }
            }
        }
    }
    
    // 编辑窗口中的元素双击事件
    @objc func elementDoubleTapAction(gesture: UIGestureRecognizer) -> Void {
        let tempView = gesture.view! as! ElementView
        
        // 判断当前是单选还是多选
        if(!self.isMultSelected) {
            self.clearElementSelected()
        }
        
        tempView.setIsSelected(isSelected: true)
        
        // 如果是多选，则没有双击输入内容的事件
        if(self.isMultSelected) {
            return
        }
        
        // 日期控件
        if(tempView.isKind(of: DateElementView.self)) {
            let alertController = UIAlertController(title: "请输入新的日期", message: nil, preferredStyle: .alert)
            
            let dateElementView = tempView as! DateElementView
            alertController.addTextField {
                (textField: UITextField!) -> Void in
                textField.text = dateElementView.textLabel?.text
            }
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "确定", style: .default, handler: {
                action in
                let textField = alertController.textFields!.first!
                let tempInputText = textField.text
                if(nil == tempInputText || (tempInputText?.isEmpty)!) {
                    
                } else {
                    // 重新生成条形码
                    dateElementView.textLabel?.text = tempInputText
                }
            })
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        // 文本框
        if(tempView.isKind(of: TextElementView.self)) {
            let textElementView = tempView as! TextElementView
            textElementView.setTextEdit(isEdit: true)
            return
        }
        
        // 一维码
        if(tempView.isKind(of: BarcodeElementView.self)) {
            let alertController = UIAlertController(title: "请输入内容", message: nil, preferredStyle: .alert)
            
            let barcodeElementView = tempView as! BarcodeElementView
            alertController.addTextField {
                (textField: UITextField!) -> Void in
                textField.text = barcodeElementView.titleLabel?.text
            }
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "确定", style: .default, handler: {
                action in
                let textField = alertController.textFields!.first!
                let tempInputText = textField.text
                if(nil == tempInputText || (tempInputText?.isEmpty)!) {
                    barcodeElementView.titleLabel?.text = "双击编辑"
                } else {
                    // 重新生成条形码
                    let barcodeImage = MHTBase.creatBarCodeImage(content: tempInputText, size: barcodeElementView.frame.size)
                    barcodeElementView.imageView!.image = barcodeImage
                     barcodeElementView.titleLabel?.text = tempInputText
                }
            })
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        // 二维码
        if(tempView.isKind(of: QRCodeElementView.self)) {
            let alertController = UIAlertController(title: "请输入内容", message: "", preferredStyle: .alert)
            
            let qrcodeElementView = tempView as! QRCodeElementView
            alertController.addTextField {
                (textField: UITextField!) -> Void in
                textField.text = qrcodeElementView.title
            }
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "确定", style: .default, handler: {
                action in
                let textField = alertController.textFields!.first!
                let tempInputText = textField.text
                if(nil == tempInputText || (tempInputText?.isEmpty)!) {
                    qrcodeElementView.title = "双击编辑"
                } else {
                    // 重新生成二维码
                    let qrcodeImage = MHTBase.creatQRCodeImage(content: tempInputText, iconName: nil, size: qrcodeElementView.frame.size)
                    qrcodeElementView.imageView!.image = qrcodeImage
                    qrcodeElementView.title = tempInputText
                }
            })
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
    }
    
    // 选择相册图片事件
    func pickImageFromAlbum() {
        //判断设置是否支持图片库
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            //初始化图片控制器
            let picker = UIImagePickerController()
            
            //设置代理
            picker.delegate = self
            
            //指定图片控制器类型
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            
            //设置是否允许编辑
            picker.allowsEditing = false
            
            //弹出控制器，显示界面
            self.present(picker, animated: true, completion: {
                () -> Void in
            })
        } else {
            print("读取相册错误")
        }
    }
}

/**
 * 滚动事件代理
 */
extension AddLabelViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = mainScrollView.contentOffset.x / SCREEN_width
        self.pageScrollView.setViewIndex(Int(index))
    }
}

/**
 * 相册代理
 */
extension AddLabelViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //选择图片成功后代理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        //显示的图片 UIImagePickerControllerOriginalImage UIImagePickerControllerEditedImage
        var image: UIImage! = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // 判断是否需要压缩
        if(self.isEditPickedImage) {
            let imageData = UIImageJPEGRepresentation(image, 0.4)
            image = UIImage.init(data: imageData!)
        }
        
        let subViewNum = self.editView.subviews.count
        let xPoint = CGFloat(5 + subViewNum * 16)
        let yPoint = CGFloat(5 + subViewNum * 16)
        let width = CGFloat(10 * 8)
        let xPointResize = ((xPoint + width) > self.editView.frame.size.width) ? (self.editView.frame.size.width - width) : xPoint
        let yPointResize = ((yPoint + width) > self.editView.frame.size.height) ? (self.editView.frame.size.height - width) : yPoint
        let barcodeView = QRCodeElementView.init(frame: CGRect(x: xPointResize, y: yPointResize, width: width, height: width))
        barcodeView.imageView!.image = image
        barcodeView.title = "图片"
        self.editView.addSubview(barcodeView)
        
        // 添加单击和双击事件
        self.addTapActionForElementView(elementView: barcodeView)
        
        // 添加拖动事件，必须放在点击手势之后，因为拖动手势需要让点击手势无效，避免冲突
        self.addPanActionForElement(elementView: barcodeView)
        
        // 绑定回调
        barcodeView.widthChangeClosure = self.elementWidthChangeClosureAction(view: translation: status:)
        barcodeView.heightChangeClosure = self.elementHeightChangeClosureAction(view: translation: status:)
        
        //图片控制器退出
        picker.dismiss(animated: true, completion: {
            () -> Void in
        })
    }
}
