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
    
    // 是否允许返回
    fileprivate var isSaved: Bool = true
    
    // 是否多选
    fileprivate var countMultSelected = 0
    fileprivate var isMultSelected = false
    fileprivate var multSelectedBarButton: UIBarButtonItem!
    fileprivate var multSelectedImageViewLabelPage: UIImageView!
    
    // 是否剪辑图片
    fileprivate var isEditPickedImage = false
    
    // 当前编辑的数据
    var dataSource = TemplateModel()
    
    // 可以选择保存的文件夹数据源
    var documentDataSource: Array<SystemTemplateConfigModel>?
    
    // 界面加载后，创建自定义的UI
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setAddLabellUI()
        self.getUserTemplateDataSourceService()
    }
    
    // 创建自自定义UI
    func setAddLabellUI() -> Void {
        let navMaxY = self.navigationController?.navigationBar.frame.maxY
        let navRBtn1 = UIBarButtonItem.init(image: UIImage.init(named: "navDeleting"), style: .plain, target: self, action: #selector(deleteElementAction(sender:)))
        let navRBtn2 = UIBarButtonItem.init(image: UIImage.init(named: "navPrint"), style: .done, target: self, action: #selector(printCurrentPage))
        let navRBtn3 = UIBarButtonItem.init(image: UIImage.init(named: "navMSelect"), style: .done, target: self, action: #selector(multSelectedChangeAction(sender:)))
        self.multSelectedBarButton = navRBtn3

        let navSpace = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: self, action: nil)
        navSpace.width = -50
        self.navigationItem.rightBarButtonItems = [navRBtn1, navSpace, navRBtn2, navSpace, navRBtn3]
        
        let addLBI = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_width, height: SCREEN_height))
        addLBI.image = UIImage.init(named: "homeMainIV")
        self.view.addSubview(addLBI)
        
        let editViewWidth = (SCREEN_width - 20)
        let pageViewHeight = (SCREEN_height - navMaxY!) * 2 / 5
        pageView = UIView.init(frame: CGRect.init(x: 0, y: SCREEN_height - pageViewHeight, width: SCREEN_width, height: pageViewHeight))
        pageView.backgroundColor = UIColor.white
        self.view.addSubview(pageView)
        
        // 当前编辑区
        self.editView = UIView.init()
        self.editView.bounds = CGRect.init(x: 0, y: 0, width: editViewWidth, height: editViewWidth * 5 / 8)
        self.editView.center = CGPoint(x: SCREEN_width / 2, y: (navMaxY! + pageView.frame.minY) / 2)
        self.editView.backgroundColor = UIColor.white
        self.editView.layer.borderWidth = 1
        self.editView.layer.borderColor = UIColor.black.cgColor
        self.view.addSubview(self.editView)
        self.createEditViewWithDataSource()
        
        let tapSingle = UITapGestureRecognizer(target: self, action: #selector(elementEditViewTapAction(gesture:)))
        tapSingle.numberOfTapsRequired = 1
        tapSingle.numberOfTouchesRequired = 1
        self.editView.addGestureRecognizer(tapSingle)
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
                        let addBtnV = self.createmapleViewButton(imageName: btnImage[4*i+j], title: btnTitle[4*i+j], frame: CGRect.init(x: 0 + CGFloat(j) * SCREEN_width/4, y: CGFloat(i)*mapleView.bounds.height/3, width: SCREEN_width/4, height: mapleView.bounds.height/3))
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
    
    // 根据数据源创建编辑窗口
    func createEditViewWithDataSource() -> Void {
        // 清空原数据
        for subView in self.editView.subviews {
            subView.removeFromSuperview()
        }
        
        // 判断数据源
        if nil == self.dataSource.labelName || (self.dataSource.labelName?.isEmpty)! {
            return
        }
        
        // 获取保存比率
        var proportion = Float(0)
        let proportionOld = self.dataSource.proportion! > Float(0) ? self.dataSource.proportion : 1
        var proportionNew = Float(0)
        
        // 重新设置编辑窗口尺寸
        let pageWidth = self.dataSource.width! > Float(0) ? self.dataSource.width : 48
        let pageHeight = self.dataSource.height! > Float(0) ? self.dataSource.height : 30
        
        // 判断宽高哪个占满
        if(pageWidth! > pageHeight!) {
            let width = Float(SCREEN_width - 20)
            let height = width * pageHeight! / pageWidth!
            self.editView.bounds.size.height = CGFloat(height)
            self.editView.bounds.size.width = CGFloat(width)
            
            // 计算新比率
            proportionNew = width / PRO_MM_PX / pageWidth!
            proportion = proportionOld! / proportionNew
        } else {
            let width = Float(SCREEN_width - 20)
            let height = width
            let widthNew = height * pageWidth! / pageHeight!
            self.editView.bounds.size.height = CGFloat(height)
            self.editView.bounds.size.width = CGFloat(widthNew)
            
            // 计算新比率
            proportionNew = height / PRO_MM_PX / pageHeight!
            proportion = proportionOld! / proportionNew
        }
        
        // 更新本地数据源的比率
        self.dataSource.proportion = proportion
        
        // 创建背景图片
        if(nil != self.dataSource.backgroundBitmap && !self.dataSource.backgroundBitmap!.isEmpty) {
            let tempImageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: self.editView.frame.width, height: self.editView.frame.height))
            var imageString = self.dataSource.backgroundBitmap!
            imageString = imageString.replacingOccurrences(of: "\n", with: "")
            let base64 = Data(base64Encoded: imageString)
            tempImageView.image = UIImage(data: base64!)
            
            self.editView.addSubview(tempImageView)
            self.editView.sendSubview(toBack: tempImageView)
        }
        
        // 创建文本框
        if(nil != self.dataSource.textControl && 0 < (self.dataSource.textControl?.count)!) {
            for i in 0 ..< (self.dataSource.textControl?.count)! {
                let model = self.dataSource.textControl![i]
                
                // 判断是否是日期类型
                let datePattern = "^\\d{4}-\\d{1,2}-\\d{1,2}\\s\\d{1,2}:\\d{1,2}:\\d{1,2}$"
                let predicate = NSPredicate(format: "SELF MATCHES %@", datePattern)
                let isDate = predicate.evaluate(with: model.text!)
                if(isDate) {
                    let rectString = model.selectRect!
                    let sizeStringArray = MHTBase.getDecodeRectArray(rectString: rectString)
                    let tempView = DateElementView.init(frame: CGRect(x: CGFloat(Float(sizeStringArray[0])! / proportion),
                                                                      y: CGFloat(Float(sizeStringArray[1])! / proportion),
                                                                      width: CGFloat(model.W! / proportion) + 5,
                                                                      height: CGFloat(model.H! / proportion)))
                    tempView.updateDateUIWithModel(model: model, pro: proportion)
                    self.editView.addSubview(tempView)
                    tempView.controlIndex = i
                    tempView.tag = 1000 + i
                    
                    // 旋转
                    if(nil != model.rotate && 0 < model.rotate!) {
                        let transform = CGAffineTransform(rotationAngle: CGFloat(model.rotate!) * CGFloat.pi / 180.0)
                        tempView.transform = transform
                    }
                    
                    // 添加单击和双击事件
                    self.addTapActionForElementView(elementView: tempView)
                    
                    // 添加拖动事件，必须放在点击手势之后，因为拖动手势需要让点击手势无效，避免冲突
                    self.addPanActionForElement(elementView: tempView)
                    
                    // 绑定变宽回调
                    tempView.widthChangeClosure = self.elementWidthChangeClosureAction(view: translation: status:)
                    tempView.heightChangeClosure = {(_ view: ElementView) -> Void in
                        self.resetModelRectWithView(view: view)
                    }
                } else {
                    let rectString = model.selectRect!
                    let sizeStringArray = MHTBase.getDecodeRectArray(rectString: rectString)
                    let tempView = TextElementView.init(frame: CGRect(x: CGFloat(Float(sizeStringArray[0])! / proportion),
                                                                      y: CGFloat(Float(sizeStringArray[1])! / proportion),
                                                                      width: CGFloat(model.W! / proportion) + 5,
                                                                      height: CGFloat(model.H! / proportion)))
                    tempView.updateUIWithModel(model: model, pro: proportion)
                    self.editView.addSubview(tempView)
                    tempView.controlIndex = i
                    tempView.tag = 1000 + i
                    
                    // 旋转
                    if(nil != model.rotate && 0 < model.rotate!) {
                        let transform = CGAffineTransform(rotationAngle: CGFloat(model.rotate!) * CGFloat.pi / 180.0)
                        tempView.transform = transform
                    }
                    
                    // 添加单击和双击事件
                    self.addTapActionForElementView(elementView: tempView)
                    
                    // 添加拖动事件，必须放在点击手势之后，因为拖动手势需要让点击手势无效，避免冲突
                    self.addPanActionForElement(elementView: tempView)
                    
                    // 绑定变宽回调
                    tempView.widthChangeClosure = self.elementWidthChangeClosureAction(view: translation: status:)
                    tempView.heightChangeClosure = {(_ view: ElementView) -> Void in
                        self.resetModelRectWithView(view: view)
                    }
                }
            }
        }
        
        // 创建一维码
        if(nil != self.dataSource.qcControls && 0 < (self.dataSource.qcControls?.count)!) {
            for i in 0 ..< (self.dataSource.qcControls?.count)! {
                let model = self.dataSource.qcControls![i]
                
                let rectString = model.selectRect!
                let sizeStringArray = MHTBase.getDecodeRectArray(rectString: rectString)
                let tempView = BarcodeElementView.init(frame: CGRect(x: CGFloat(Float(sizeStringArray[0])! / proportion),
                                                                        y: CGFloat(Float(sizeStringArray[1])! / proportion),
                                                                        width: CGFloat(model.W! / proportion),
                                                                        height: CGFloat(model.H! / proportion)))
                let barcodeString = model.text
                let barcodeImage = MHTBase.creatBarCodeImage(content: barcodeString, size: tempView.frame.size)
                tempView.imageView!.image = barcodeImage
                tempView.titleLabel!.text = barcodeString
                self.editView.addSubview(tempView)
                tempView.controlIndex = i
                tempView.tag = 2000 + i
                
                // 旋转
                if(nil != model.rotate && 0 < model.rotate!) {
                    let transform = CGAffineTransform(rotationAngle: CGFloat(model.rotate!) * CGFloat.pi / 180.0)
                    tempView.transform = transform
                }

                // 添加单击和双击事件
                self.addTapActionForElementView(elementView: tempView)

                // 添加拖动事件，必须放在点击手势之后，因为拖动手势需要让点击手势无效，避免冲突
                self.addPanActionForElement(elementView: tempView)

                // 绑定回调
                tempView.widthChangeClosure = self.elementWidthChangeClosureAction(view: translation: status:)
                tempView.heightChangeClosure = self.elementHeightChangeClosureAction(view: translation: status:)
            }
        }

        // 创建二维码
        if(nil != self.dataSource.qrControls && 0 < (self.dataSource.qrControls?.count)!) {
            for i in 0 ..< (self.dataSource.qrControls?.count)! {
                let model = self.dataSource.qrControls![i]
                
                let rectString = model.selectRect!
                let sizeStringArray = MHTBase.getDecodeRectArray(rectString: rectString)
                let tempView = QRCodeElementView.init(frame: CGRect(x: CGFloat(Float(sizeStringArray[0])! / proportion),
                                                                       y: CGFloat(Float(sizeStringArray[1])! / proportion),
                                                                       width: CGFloat(model.W! / proportion),
                                                                       height: CGFloat(model.H! / proportion)))
                let barcodeString = model.text
                let barcodeImage = MHTBase.creatQRCodeImage(content: barcodeString, iconName: nil, size: tempView.frame.size)
                tempView.imageView!.image = barcodeImage
                tempView.title = barcodeString
                self.editView.addSubview(tempView)
                tempView.controlIndex = i
                tempView.tag = 3000 + i
                
                // 旋转
                if(nil != model.rotate && 0 < model.rotate!) {
                    let transform = CGAffineTransform(rotationAngle: CGFloat(model.rotate!) * CGFloat.pi / 180.0)
                    tempView.transform = transform
                }
                
                // 添加单击和双击事件
                self.addTapActionForElementView(elementView: tempView)
                
                // 添加拖动事件，必须放在点击手势之后，因为拖动手势需要让点击手势无效，避免冲突
                self.addPanActionForElement(elementView: tempView)
                
                // 绑定回调
                tempView.widthChangeClosure = self.elementWidthChangeClosureAction(view: translation: status:)
                tempView.heightChangeClosure = self.elementHeightChangeClosureAction(view: translation: status:)
            }
        }

        // 图片
        if(nil != self.dataSource.bitmapControls && 0 < (self.dataSource.bitmapControls?.count)!) {
            for i in 0 ..< (self.dataSource.bitmapControls?.count)! {
                let model = self.dataSource.bitmapControls![i]
                let rectString = model.selectRect!
                let sizeStringArray = MHTBase.getDecodeRectArray(rectString: rectString)
                let tempView = ImageElementView.init(frame: CGRect(x: CGFloat(Float(sizeStringArray[0])! / proportion),
                                                                       y: CGFloat(Float(sizeStringArray[1])! / proportion),
                                                                       width: CGFloat(model.W! / proportion),
                                                                       height: CGFloat(model.H! / proportion)))
                var imageString = model.bitmap!
                imageString = imageString.replacingOccurrences(of: "\n", with: "")
                let base64 = Data(base64Encoded: imageString)
                tempView.imageView!.image = UIImage(data: base64!)
                tempView.title = "图片"
                self.editView.addSubview(tempView)
                tempView.controlIndex = i
                tempView.tag = 4000 + i
                
                // 旋转
                if(nil != model.rotate && 0 < model.rotate!) {
                    let transform = CGAffineTransform(rotationAngle: CGFloat(model.rotate!) * CGFloat.pi / 180.0)
                    tempView.transform = transform
                }

                // 添加单击和双击事件
                self.addTapActionForElementView(elementView: tempView)

                // 添加拖动事件，必须放在点击手势之后，因为拖动手势需要让点击手势无效，避免冲突
                self.addPanActionForElement(elementView: tempView)

                // 绑定回调
                tempView.widthChangeClosure = self.elementWidthChangeClosureAction(view: translation: status:)
                tempView.heightChangeClosure = self.elementHeightChangeClosureAction(view: translation: status:)
            }
        }

        // 创建线条
        if(nil != self.dataSource.lineControls && 0 < (self.dataSource.lineControls?.count)!) {
            for i in 0 ..< (self.dataSource.lineControls?.count)! {
                let model = self.dataSource.lineControls![i]
                let rectString = model.selectRect!
                let sizeStringArray = MHTBase.getDecodeRectArray(rectString: rectString)
                let tempView = LineElementView.init(frame: CGRect(x: CGFloat(Float(sizeStringArray[0])! / proportion),
                                                                     y: CGFloat(Float(sizeStringArray[1])! / proportion),
                                                                     width: CGFloat(model.W! / proportion),
                                                                     height: CGFloat(model.H! / proportion)))
                
                self.editView.addSubview(tempView)
                tempView.controlIndex = i
                tempView.tag = 5000 + i
                
                // 旋转
                if(nil != model.rotate && 0 < model.rotate!) {
                    let transform = CGAffineTransform(rotationAngle: CGFloat(model.rotate!) * CGFloat.pi / 180.0)
                    tempView.transform = transform
                }

                // 添加单击和双击事件
                self.addTapActionForElementView(elementView: tempView)

                // 添加拖动事件，必须放在点击手势之后，因为拖动手势需要让点击手势无效，避免冲突
                self.addPanActionForElement(elementView: tempView)

                // 绑定回调
                tempView.widthChangeClosure = self.elementWidthChangeClosureAction(view: translation: status:)
                tempView.heightChangeClosure = self.elementHeightChangeClosureAction(view: translation: status:)
            }
        }

        // 创建矩形
        if(nil != self.dataSource.rectangleControls && 0 < (self.dataSource.rectangleControls?.count)!) {
            for i in 0 ..< (self.dataSource.rectangleControls?.count)! {
                let model = self.dataSource.rectangleControls![i]
                let rectString = model.selectRect!
                let sizeStringArray = MHTBase.getDecodeRectArray(rectString: rectString)
                let tempView = RectElementView.init(frame: CGRect(x: CGFloat(Float(sizeStringArray[0])! / proportion),
                                                                     y: CGFloat(Float(sizeStringArray[1])! / proportion),
                                                                     width: CGFloat(model.W! / proportion),
                                                                     height: CGFloat(model.H! / proportion)))
                self.editView.addSubview(tempView)
                tempView.controlIndex = i
                tempView.tag = 6000 + i
                
                // 旋转
                if(nil != model.rotate && 0 < model.rotate!) {
                    let transform = CGAffineTransform(rotationAngle: CGFloat(model.rotate!) * CGFloat.pi / 180.0)
                    tempView.transform = transform
                }

                // 添加单击和双击事件
                self.addTapActionForElementView(elementView: tempView)

                // 添加拖动事件，必须放在点击手势之后，因为拖动手势需要让点击手势无效，避免冲突
                self.addPanActionForElement(elementView: tempView)

                // 绑定回调
                tempView.widthChangeClosure = self.elementWidthChangeClosureAction(view: translation: status:)
                tempView.heightChangeClosure = self.elementHeightChangeClosureAction(view: translation: status:)
            }
        }
    }
    
    // 分页的按钮统一创建函数
    func createmapleViewButton(imageName: String, title: String, frame: CGRect) -> UIView {
        let addBtnV = UIView.init(frame: frame)
        
        // 图片
        let tempImageSize = addBtnV.bounds.height - CGFloat((5 + 6 + 16) * MHTBase.autoScreen());
        let tempImageY = CGFloat(5 * MHTBase.autoScreen());
        let tempImageX = (addBtnV.bounds.width - tempImageSize) / 2;
        let addImageView = UIImageView(frame: CGRect(x: tempImageX,
                                                     y: tempImageY,
                                                     width: tempImageSize,
                                                     height: tempImageSize));
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
    func turnBackAction() {
        if(self.isSaved) {
            self.navigationController?.popViewController(animated: true)
        } else {
            let alertController = UIAlertController(title: "提示", message: "是否需要保存？", preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "再想想", style: .default, handler: nil)
            let waitAction = UIAlertAction(title: "不保存", style: .default, handler: {
                action in
                self.navigationController?.popViewController(animated: true)
            })
            let okAction = UIAlertAction(title: "保存", style: .default, handler: {
                action in
                self.saveButtonAction()
            })
            alertController.addAction(cancelAction)
            alertController.addAction(waitAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    // 清空元素的选择状态
    func clearElementSelected() -> Void {
        for subView in self.editView.subviews {
            if(subView.isKind(of: ElementView.self)) {
                let subElementView = subView as! ElementView
                subElementView.setIsSelected(isSelected: false)
                subElementView.resignKeyboardAction()
            }
        }
    }
    
    // 清空所有元素
    func clearElements() -> Void {
        for subView in self.editView.subviews {
            subView.removeFromSuperview()
        }
        
        let tempDataSource = self.dataSource
        self.dataSource = TemplateModel()
        self.dataSource.width = tempDataSource.width!
        self.dataSource.height = tempDataSource.height!
        self.dataSource.proportion = tempDataSource.proportion!
        self.dataSource.concentration = tempDataSource.concentration!
        self.dataSource.printingDirection = tempDataSource.printingDirection!
    }
    
    // 删除元素按钮事件
    @objc func deleteElementAction(sender: UIBarButtonItem) -> Void {
        for subView in self.editView.subviews {
            if(subView.isKind(of: ElementView.self)) {
                let subElementView = subView as! ElementView
                if(subElementView.getIsSelected()) {
                    // 删除保存的数据
                    self.deleteViewModel(view: subElementView)
                    
                    subElementView.removeFromSuperview()
                }
            }
        }
    }
    
    // 删除视图对应的数据源
    func deleteViewModel(view: ElementView) -> Void {
        // 更新数据源保存的坐标
        let controlIndex: Int = view.controlIndex!
        
        if(view.isKind(of: DateElementView.self)) {
            self.dataSource.textControl!.remove(at: controlIndex)
            
            // 整理其他的文本框下标
            self.resetViewControlIndex(deleteIndex: controlIndex, type: DateElementView.self)
            return
        }
        
        if(view.isKind(of: TextElementView.self)) {
            self.dataSource.textControl!.remove(at: controlIndex)
            
            // 整理其他的文本框下标
            self.resetViewControlIndex(deleteIndex: controlIndex, type: TextElementView.self)
            return
        }
        
        if(view.isKind(of: BarcodeElementView.self)) {
            self.dataSource.qcControls!.remove(at: controlIndex)
            
            // 整理其他的文本框下标
            self.resetViewControlIndex(deleteIndex: controlIndex, type: BarcodeElementView.self)
            return
        }
        
        if(view.isKind(of: ImageElementView.self)) {
            self.dataSource.bitmapControls!.remove(at: controlIndex)
            
            // 整理其他的文本框下标
            self.resetViewControlIndex(deleteIndex: controlIndex, type: ImageElementView.self)
            return
        }
        
        if(view.isKind(of: QRCodeElementView.self)) {
            self.dataSource.qrControls!.remove(at: controlIndex)
            
            // 整理其他的标
            self.resetViewControlIndex(deleteIndex: controlIndex, type: QRCodeElementView.self)
            return
        }
        
        if(view.isKind(of: LineElementView.self)) {
            self.dataSource.lineControls!.remove(at: controlIndex)
            
            // 整理其他的标
            self.resetViewControlIndex(deleteIndex: controlIndex, type: LineElementView.self)
            return
        }
        
        if(view.isKind(of: RectElementView.self)) {
            self.dataSource.rectangleControls!.remove(at: controlIndex)
            
            // 整理其他的标
            self.resetViewControlIndex(deleteIndex: controlIndex, type: RectElementView.self)
            return
        }
    }
    
    // 删除一个元素后，整理相同元素的下标
    func resetViewControlIndex(deleteIndex: Int, type: Swift.AnyClass) -> Void {
        if(type == DateElementView.self) {
            if deleteIndex >= (self.dataSource.textControl?.count)! {
                return
            }
            
            for i in deleteIndex ..< (self.dataSource.textControl?.count)! {
                let view = self.editView.viewWithTag(1000 + i) as! ElementView
                view.controlIndex = i
            }
            
            return
        }
        
        if(type == TextElementView.self) {
            if deleteIndex >= (self.dataSource.textControl?.count)! {
                return
            }
            
            for i in deleteIndex ..< (self.dataSource.textControl?.count)! {
                let view = self.editView.viewWithTag(1000 + i) as! ElementView
                view.controlIndex = i
            }
            
            return
        }
        
        if(type == BarcodeElementView.self) {
            if deleteIndex >= (self.dataSource.qcControls?.count)! {
                return
            }
            
            for i in deleteIndex ..< (self.dataSource.qcControls?.count)! {
                let view = self.editView.viewWithTag(2000 + i) as! ElementView
                view.controlIndex = i
            }
            
            return
        }
        
        if(type == ImageElementView.self) {
            if deleteIndex >= (self.dataSource.bitmapControls?.count)! {
                return
            }
            
            for i in deleteIndex ..< (self.dataSource.bitmapControls?.count)! {
                let view = self.editView.viewWithTag(4000 + i) as! ElementView
                view.controlIndex = i
            }
            
            return
        }
        
        if(type == QRCodeElementView.self) {
            if deleteIndex >= (self.dataSource.qrControls?.count)! {
                return
            }
            
            for i in deleteIndex ..< (self.dataSource.qrControls?.count)! {
                let view = self.editView.viewWithTag(3000 + i) as! ElementView
                view.controlIndex = i
            }
            
            return
        }
        
        if(type == LineElementView.self) {
            if deleteIndex >= (self.dataSource.lineControls?.count)! {
                return
            }
            
            for i in deleteIndex ..< (self.dataSource.lineControls?.count)! {
                let view = self.editView.viewWithTag(5000 + i) as! ElementView
                view.controlIndex = i
            }
            
            return
        }
        
        if(type == RectElementView.self) {
            if deleteIndex >= (self.dataSource.rectangleControls?.count)! {
                return
            }
            
            for i in deleteIndex ..< (self.dataSource.rectangleControls?.count)! {
                let view = self.editView.viewWithTag(6000 + i) as! ElementView
                view.controlIndex = i
            }
            
            return
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
                // 创建数据模板
                var tempModel = TemplateTextModel()
                self.isSaved = false
                let width = CGFloat(tempModel.W! / PROPORTION_LOCAL / self.dataSource.proportion!)
                let height = CGFloat(tempModel.H! / PROPORTION_LOCAL / self.dataSource.proportion!)
                let xPointResize = ((xPoint + width) > self.editView.frame.size.width) ? (self.editView.frame.size.width - width) : xPoint
                let yPointResize = ((yPoint + height) > self.editView.frame.size.height) ? (self.editView.frame.size.height - width) : yPoint
                let tempView = TextElementView.init(frame: CGRect(x: xPointResize, y: yPointResize, width: width, height: height), pro: self.dataSource.proportion!)
                
                // 设置保存的坐标系
                let saveFrame = CGRect(x: xPointResize * CGFloat(self.dataSource.proportion!),
                                       y: yPointResize * CGFloat(self.dataSource.proportion!),
                                       width: CGFloat(tempModel.W!),
                                       height: CGFloat(tempModel.H!))
                tempModel.selectRect = MHTBase.getSaveContentRect(frame: saveFrame)
                tempModel.contentRect = tempModel.selectRect!
                
                tempView.updateUIWithModel(model: tempModel, pro: self.dataSource.proportion!)
                self.editView.addSubview(tempView)
                
                // 保存数据模型
                if(nil == self.dataSource.textControl) {
                    self.dataSource.textControl = [tempModel]
                    tempView.tag = 1000
                    tempView.controlIndex = 0
                } else {
                    self.dataSource.textControl?.append(tempModel)
                    tempView.tag = 1000 + (self.dataSource.textControl?.count)!
                    tempView.controlIndex = (self.dataSource.textControl?.count)! - 1
                }
                
                // 添加单击和双击事件
                self.addTapActionForElementView(elementView: tempView)
                
                // 添加拖动事件，必须放在点击手势之后，因为拖动手势需要让点击手势无效，避免冲突
                self.addPanActionForElement(elementView: tempView)
            
                // 绑定变宽回调
                tempView.widthChangeClosure = self.elementWidthChangeClosureAction(view: translation: status:)
                tempView.heightChangeClosure = {(_ view: ElementView) -> Void in
                    self.resetModelRectWithView(view: view)
                }
            case 1:
                // 创建数据模板
                var tempModel = TemplateQCModel()
                self.isSaved = false
                let width = CGFloat(tempModel.W! / PROPORTION_LOCAL / self.dataSource.proportion!)
                let height = CGFloat(tempModel.H! / PROPORTION_LOCAL / self.dataSource.proportion!)
                let xPointResize = ((xPoint + width) > self.editView.frame.size.width) ? (self.editView.frame.size.width - width) : xPoint
                let yPointResize = ((yPoint + height) > self.editView.frame.size.height) ? (self.editView.frame.size.height - width) : yPoint
                let tempView = BarcodeElementView.init(frame: CGRect(x: xPointResize, y: yPointResize, width: width, height: height), pro: self.dataSource.proportion!)
                let tempString = tempModel.text!
                let tempImage = MHTBase.creatBarCodeImage(content: tempString, size: tempView.frame.size)
                
                // 设置保存的坐标系
                let saveFrame = CGRect(x: xPointResize * CGFloat(self.dataSource.proportion!),
                                       y: yPointResize * CGFloat(self.dataSource.proportion!),
                                       width: CGFloat(tempModel.W!),
                                       height: CGFloat(tempModel.H!))
                tempModel.selectRect = MHTBase.getSaveContentRect(frame: saveFrame)
                tempModel.contentRect = tempModel.selectRect!
                
                tempView.updateUIWithModel(image: tempImage!, model: tempModel, pro: self.dataSource.proportion!)
                self.editView.addSubview(tempView)
                
                // 保存数据模型
                if(nil == self.dataSource.qcControls) {
                    self.dataSource.qcControls = [tempModel]
                    tempView.tag = 2000
                    tempView.controlIndex = 0
                } else {
                    self.dataSource.qcControls?.append(tempModel)
                    tempView.tag = 2000 + (self.dataSource.qcControls?.count)!
                    tempView.controlIndex = (self.dataSource.qcControls?.count)! - 1
                }
            
                // 添加单击和双击事件
                self.addTapActionForElementView(elementView: tempView)
            
                // 添加拖动事件，必须放在点击手势之后，因为拖动手势需要让点击手势无效，避免冲突
                self.addPanActionForElement(elementView: tempView)
            
                // 绑定回调
                tempView.widthChangeClosure = self.elementWidthChangeClosureAction(view: translation: status:)
                tempView.heightChangeClosure = self.elementHeightChangeClosureAction(view: translation: status:)
            case 2:
                // 创建数据模板
                var tempModel = TemplateQRModel()
                self.isSaved = false
                let width = CGFloat(tempModel.W! / PROPORTION_LOCAL / self.dataSource.proportion!)
                let xPointResize = ((xPoint + width) > self.editView.frame.size.width) ? (self.editView.frame.size.width - width) : xPoint
                let yPointResize = ((yPoint + width) > self.editView.frame.size.height) ? (self.editView.frame.size.height - width) : yPoint
                let tempView = QRCodeElementView.init(frame: CGRect(x: xPointResize, y: yPointResize, width: width, height: width), pro: self.dataSource.proportion!)
                let tempString = tempModel.text!
                let tempImage = MHTBase.creatQRCodeImage(content: tempString, iconName: nil, size: tempView.frame.size)
                
                // 设置保存的坐标系
                let saveFrame = CGRect(x: xPointResize * CGFloat(self.dataSource.proportion!),
                                       y: yPointResize * CGFloat(self.dataSource.proportion!),
                                       width: CGFloat(tempModel.W!),
                                       height: CGFloat(tempModel.H!))
                tempModel.selectRect = MHTBase.getSaveContentRect(frame: saveFrame)
                tempModel.contentRect = tempModel.selectRect!
                
                tempView.updateUIWithModel(image: tempImage!, model: tempModel, pro: self.dataSource.proportion!)
                self.editView.addSubview(tempView)
                
                // 保存数据模型
                if(nil == self.dataSource.qrControls) {
                    self.dataSource.qrControls = [tempModel]
                    tempView.tag = 3000
                    tempView.controlIndex = 0
                } else {
                    self.dataSource.qrControls?.append(tempModel)
                    tempView.tag = 3000 + (self.dataSource.qrControls?.count)!
                    tempView.controlIndex = (self.dataSource.qrControls?.count)! - 1
                }
            
                // 添加单击和双击事件
                self.addTapActionForElementView(elementView: tempView)
            
                // 添加拖动事件，必须放在点击手势之后，因为拖动手势需要让点击手势无效，避免冲突
                self.addPanActionForElement(elementView: tempView)
            
                // 绑定回调
                tempView.widthChangeClosure = self.elementWidthChangeClosureAction(view: translation: status:)
                tempView.heightChangeClosure = self.elementHeightChangeClosureAction(view: translation: status:)
            case 3:
                let alertController = UIAlertController(title: "提示", message: "是否要剪辑图片？", preferredStyle: .actionSheet)
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
                // 创建数据模板
                var tempModel = TemplateLineControlModel()
                
                self.isSaved = false
                let width = CGFloat(tempModel.W! / PROPORTION_LOCAL / self.dataSource.proportion!)
                let height = CGFloat(tempModel.H! / PROPORTION_LOCAL / self.dataSource.proportion!)
                let xPointResize = ((xPoint + width) > self.editView.frame.size.width) ? (self.editView.frame.size.width - width) : xPoint
                let yPointResize = ((yPoint + width) > self.editView.frame.size.height) ? (self.editView.frame.size.height - width) : yPoint
                let tempView = LineElementView.init(frame: CGRect(x: xPointResize, y: yPointResize, width: width, height: height), pro: self.dataSource.proportion!)
                
                // 设置保存的坐标系
                let saveFrame = CGRect(x: xPointResize * CGFloat(self.dataSource.proportion!),
                                       y: yPointResize * CGFloat(self.dataSource.proportion!),
                                       width: CGFloat(tempModel.W!),
                                       height: CGFloat(tempModel.H!))
                tempModel.selectRect = MHTBase.getSaveContentRect(frame: saveFrame)
                tempModel.contentRect = tempModel.selectRect!
                
                tempView.updateUIWithModel(model: tempModel, pro: self.dataSource.proportion!)
                self.editView.addSubview(tempView)
                
                if(nil == self.dataSource.lineControls) {
                    self.dataSource.lineControls = [tempModel]
                    tempView.tag = 5000
                    tempView.controlIndex = 0
                } else {
                    self.dataSource.lineControls?.append(tempModel)
                    tempView.tag = 5000 + (self.dataSource.lineControls?.count)!
                    tempView.controlIndex = (self.dataSource.lineControls?.count)! - 1
                }
                
                // 添加单击和双击事件
                self.addTapActionForElementView(elementView: tempView)
                
                // 添加拖动事件，必须放在点击手势之后，因为拖动手势需要让点击手势无效，避免冲突
                self.addPanActionForElement(elementView: tempView)
            
                // 绑定回调
                tempView.widthChangeClosure = self.elementWidthChangeClosureAction(view: translation: status:)
                tempView.heightChangeClosure = self.elementHeightChangeClosureAction(view: translation: status:)
            case 6:
                var tempModel = TemplateRectModel()
                
                self.isSaved = false
                let width = CGFloat(tempModel.W! / PROPORTION_LOCAL / self.dataSource.proportion!)
                let height = CGFloat(tempModel.H! / PROPORTION_LOCAL / self.dataSource.proportion!)
                let xPointResize = ((xPoint + width) > self.editView.frame.size.width) ? (self.editView.frame.size.width - width) : xPoint
                let yPointResize = ((yPoint + width) > self.editView.frame.size.height) ? (self.editView.frame.size.height - width) : yPoint
                let tempView = RectElementView.init(frame: CGRect(x: xPointResize, y: yPointResize, width: width, height: height), pro: self.dataSource.proportion!)
                
                // 设置保存的坐标系
                let saveFrame = CGRect(x: xPointResize * CGFloat(self.dataSource.proportion!),
                                       y: yPointResize * CGFloat(self.dataSource.proportion!),
                                       width: CGFloat(tempModel.W!),
                                       height: CGFloat(tempModel.H!))
                tempModel.selectRect = MHTBase.getSaveContentRect(frame: saveFrame)
                tempModel.contentRect = tempModel.selectRect!
                
                tempView.updateUIWithModel(model: tempModel, pro: self.dataSource.proportion!)
                self.editView.addSubview(tempView)
                
                if(nil == self.dataSource.rectangleControls) {
                    self.dataSource.rectangleControls = [tempModel]
                    tempView.tag = 6000
                    tempView.controlIndex = 0
                } else {
                    self.dataSource.rectangleControls?.append(tempModel)
                    tempView.tag = 6000 + (self.dataSource.rectangleControls?.count)!
                    tempView.controlIndex = (self.dataSource.rectangleControls?.count)! - 1
                }
                
                // 添加单击和双击事件
                self.addTapActionForElementView(elementView: tempView)
                
                // 添加拖动事件，必须放在点击手势之后，因为拖动手势需要让点击手势无效，避免冲突
                self.addPanActionForElement(elementView: tempView)
            
                // 绑定回调
                tempView.widthChangeClosure = self.elementWidthChangeClosureAction(view: translation: status:)
                tempView.heightChangeClosure = self.elementHeightChangeClosureAction(view: translation: status:)
            case 7:
                ToastView.instance.showToast(content: "敬请期待")
            case 8:
                var tempModel = TemplateTextModel()
                self.isSaved = false
                tempModel.W = 16 * 8 * self.dataSource.proportion!
                let width = CGFloat(tempModel.W! / PROPORTION_LOCAL / self.dataSource.proportion!)
                let height = CGFloat(tempModel.H! / PROPORTION_LOCAL / self.dataSource.proportion!)
                let xPointResize = ((xPoint + width) > self.editView.frame.size.width) ? (self.editView.frame.size.width - width) : xPoint
                let yPointResize = ((yPoint + height) > self.editView.frame.size.height) ? (self.editView.frame.size.height - width) : yPoint
                let tempView = DateElementView.init(frame: CGRect(x: xPointResize, y: yPointResize, width: width, height: height), pro: self.dataSource.proportion!)
                
                // 设置保存的坐标系
                let saveFrame = CGRect(x: xPointResize * CGFloat(self.dataSource.proportion!),
                                       y: yPointResize * CGFloat(self.dataSource.proportion!),
                                       width: CGFloat(tempModel.W!),
                                       height: CGFloat(tempModel.H!))
                tempModel.selectRect = MHTBase.getSaveContentRect(frame: saveFrame)
                tempModel.contentRect = tempModel.selectRect!
                
                let currentdate = Date()
                let dateformatter = DateFormatter()
                dateformatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
                let dateString = dateformatter.string(from: currentdate)
                tempModel.text = dateString
                tempView.updateDateUIWithModel(model: tempModel, pro: self.dataSource.proportion!)
                self.editView.addSubview(tempView)
                
                if(nil == self.dataSource.textControl) {
                    self.dataSource.textControl = [tempModel]
                    tempView.tag = 1000
                    tempView.controlIndex = 0
                } else {
                    self.dataSource.textControl?.append(tempModel)
                    tempView.tag = 1000 + (self.dataSource.textControl?.count)!
                    tempView.controlIndex = (self.dataSource.textControl?.count)! - 1
                }
                
                // 添加单击和双击事件
                self.addTapActionForElementView(elementView: tempView)
                
                // 添加拖动事件，必须放在点击手势之后，因为拖动手势需要让点击手势无效，避免冲突
                self.addPanActionForElement(elementView: tempView)
            
                // 绑定回调
                tempView.widthChangeClosure = self.elementWidthChangeClosureAction(view: translation: status:)
                tempView.heightChangeClosure = {(_ view: ElementView) -> Void in
                    self.resetModelRectWithView(view: view)
                }
            default:
                print("insertElementTabButtonAction -1")
        }
    }
    
    // 标签分页中的按钮事件处理
    @objc func labelTabButtonAction(_ gesture: UIGestureRecognizer) -> Void {
        let tag = gesture.view?.tag ?? -1
        switch tag {
        case 0:
            // 清空选择样式
            self.clearElementSelected()
            
            if(self.isSaved) {
                self.clearElements()
            } else {
                let alertController = UIAlertController(title: "提示", message: "是否需要保存？", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                let okAction = UIAlertAction(title: "确定", style: .default, handler: {
                    action in
                    self.clearElements()
                })
                alertController.addAction(cancelAction)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        case 1:
            // 清空选择样式
            self.clearElementSelected()
            
            if(self.isSaved) {
                let labelModelViewController = LabelModelViewController()
                labelModelViewController.selectedTemplateClosure = self.pickedTempateAction(model: isUser: )
                self.navigationController?.pushViewController(labelModelViewController, animated: true)
            } else {
                let alertController = UIAlertController(title: "提示", message: "选择模板后将清空原来内容，是否确认选择模板？", preferredStyle: .actionSheet)
                let cancelAction = UIAlertAction(title: "再想想", style: .default, handler: nil)
                let okAction = UIAlertAction(title: "确定", style: .default, handler: {
                    action in
                    let labelModelViewController = LabelModelViewController()
                    labelModelViewController.selectedTemplateClosure = self.pickedTempateAction(model: isUser: )
                    self.navigationController?.pushViewController(labelModelViewController, animated: true)
                })
                alertController.addAction(cancelAction)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        case 2:
            self.saveButtonAction()
        case 3:
            // 清空选择样式
            self.clearElementSelected()
            
            let pickerView = DocumentPickerView.init()
            pickerView.dataSource = self.documentDataSource
            pickerView.closeClosure = self.pickedDocumentAction(model: )
            ToastView.instance.showPopCustomView(view: pickerView)
        case 4:
            print("labelTabButtonAction tag = \(tag)")
        case 5:
            print("labelTabButtonAction tag = \(tag)")
        case 6:
            self.printCurrentPage()
        case 7:
            ToastView.instance.showToast(content: "敬请期待")
        case 8:
            self.multSelectedChangeAction(sender: nil)
        default:
            print("labelTabButtonAction tag = \(tag)")
        }
    }
    
    // 选择保存的目录后回调事件
    func pickedDocumentAction(model: SystemTemplateConfigModel?) -> Void {
        // 回收
        ToastView.instance.hidePopCustomView()
        
        if(nil == model) {
            return
        }
        
        self.dataSource.saveDocument = model!.name!
        self.dataSource.fileName = MHTBase.idGenerator()
        let alertController = UIAlertController(title: "提示", message: "请输入名称", preferredStyle: .alert)
        
        // 文件名输入框
        alertController.addTextField(configurationHandler: {
            (textField) in
            if(nil == self.dataSource.labelName || (self.dataSource.labelName?.isEmpty)!) {
                textField.placeholder = "请输入名称"
            } else {
                textField.text = self.dataSource.labelName!
            }
            textField.keyboardType = .asciiCapable
        })
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: {
            action in
            let textField = alertController.textFields?.first
            if(nil == textField?.text || (textField?.text?.isEmpty)!) {
                ToastView.instance.showToast(content: "请填写名称")
            } else {
                self.dataSource.labelName = textField?.text!
                self.saveCurrentFileWithFileName(fileName: self.dataSource.fileName!)
            }
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // 属性分页事件
    @objc func propertyTabAction() -> Void {
        
    }
    
    // 保存按钮统一处理，主要是判断是否有模板名
    func saveButtonAction() -> Void {
        // 清空选择样式
        self.clearElementSelected()
        
        // 判断是否已有文件名
        if(nil != self.dataSource.labelName && !(self.dataSource.labelName?.isEmpty)!) {
            self.saveCurrentFileWithFileName(fileName: (self.dataSource.fileName)!)
        } else {
            let alertController = UIAlertController(title: "提示", message: "请输入名称", preferredStyle: .alert)
            
            // 文件名输入框
            alertController.addTextField(configurationHandler: {
                (textField) in
                textField.placeholder = "请输入名称"
                textField.keyboardType = .asciiCapable
            })
            
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "确定", style: .default, handler: {
                action in
                let textField = alertController.textFields?.first
                if(nil == textField?.text || (textField?.text?.isEmpty)!) {
                    ToastView.instance.showToast(content: "请填写名称")
                } else {
                    self.dataSource.labelName = textField?.text!
                    self.saveCurrentFileWithFileName(fileName: self.dataSource.fileName!)
                }
            })
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    // 保存文件
    func saveCurrentFileWithFileName(fileName: String) -> Void {
        // 设置整个界面的图片base64
        let viewImage = MHTBase.getImageFromView(view: self.editView)
        
        // 将图片转为base64
        let imageData = UIImagePNGRepresentation(viewImage)
        let base64String = imageData!.base64EncodedString()
        self.dataSource.labelViewBack = base64String
        
        let encoder = JSONEncoder()
        let jsonData = try! encoder.encode(self.dataSource) as Data
        
        // 保存的路径
        let templatePath = MHTBase.getTemplateDocumentPath()
        var filePath = templatePath + "/" + self.dataSource.saveDocument!
        
        // 判断文件夹是否存在
        let fileManager = FileManager.default
        let isDocumentExit = fileManager.fileExists(atPath: filePath)
        if(!isDocumentExit) {
            try! fileManager.createDirectory(atPath: filePath, withIntermediateDirectories: true, attributes: nil)
        }
        filePath = filePath + "/" + fileName + SAVE_SUFFIX_FILE_DEFAULT
        let fileURL = URL(fileURLWithPath: filePath)
        do {
            try jsonData.write(to: fileURL)
            ToastView.instance.showToast(content: "保存成功！")
            self.isSaved = true
            
            // 保存最后编辑的模板
            let userDefault = UserDefaults.standard
            let userDefaultPath = filePath.replacingOccurrences(of: templatePath, with: "")
            userDefault.set(userDefaultPath, forKey: SAVE_LATEST_FILE_PATH_KEY_NAME)
            userDefault.synchronize()
        } catch {
            print("save error: \(error)")
            ToastView.instance.showToast(content: "保存失败！")
        }
    }
    
    // 打印事件
    @objc func printCurrentPage() {
        self.navigationController?.pushViewController(bluetoothMVC(), animated: true)
    }
    
    // 选择模板编辑
    func pickedTempateAction(model: TemplateModel, isUser: Bool) -> Void {
        self.clearElementSelected()
        self.dataSource = model
        self.dataSource.saveDocument = SAVE_DOCUMENT_DEFAULT
        if(!isUser) {
            self.dataSource.fileName = MHTBase.idGenerator()
        }
        self.createEditViewWithDataSource()
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
        
        if(gesture.state == .ended) {
            // 重置view保存坐标
            self.resetModelRectWithView(view: gesture.view as! ElementView)
        }
        
        // 多选时，需要将其他已选择的View也拖动
        for subView in self.editView.subviews {
            if subView != gesture.view && subView.isKind(of: ElementView.self) {
                let subElementView = subView as! ElementView
                if(subElementView.isSelected) {
                    subElementView.center = CGPoint(x: subElementView.center.x + changeX, y: subElementView.center.y + changeY)
                    
                    if(gesture.state == .ended) {
                        // 重置view保存坐标
                        self.resetModelRectWithView(view: subElementView)
                    }
                }
            }
        }
    }
    
    // 重新保存view的坐标
    func resetModelRectWithView(view: ElementView) -> Void {
        // 更新数据源保存的坐标
        let controlIndex: Int = view.controlIndex!
        let rectString = MHTBase.getSaveContentRect(frame: view.frame)
        
        if(view.isKind(of: DateElementView.self)) {
            self.dataSource.textControl![controlIndex].selectRect = rectString
            self.dataSource.textControl![controlIndex].contentRect = rectString
            self.dataSource.textControl![controlIndex].W = Float(view.frame.width)
            self.dataSource.textControl![controlIndex].H = Float(view.frame.height)
            return
        }
        
        if(view.isKind(of: TextElementView.self)) {
            self.dataSource.textControl![controlIndex].selectRect = rectString
            self.dataSource.textControl![controlIndex].contentRect = rectString
            self.dataSource.textControl![controlIndex].W = Float(view.frame.width)
            self.dataSource.textControl![controlIndex].H = Float(view.frame.height)
            return
        }
        
        if(view.isKind(of: BarcodeElementView.self)) {
            self.dataSource.qcControls![controlIndex].selectRect = rectString
            self.dataSource.qcControls![controlIndex].contentRect = rectString
            self.dataSource.qcControls![controlIndex].W = Float(view.frame.width)
            self.dataSource.qcControls![controlIndex].H = Float(view.frame.height)
            return
        }
        
        if(view.isKind(of: ImageElementView.self)) {
            self.dataSource.bitmapControls![controlIndex].selectRect = rectString
            self.dataSource.bitmapControls![controlIndex].contentRect = rectString
            self.dataSource.bitmapControls![controlIndex].W = Float(view.frame.width)
            self.dataSource.bitmapControls![controlIndex].H = Float(view.frame.height)
            return
        }
        
        if(view.isKind(of: QRCodeElementView.self)) {
            self.dataSource.qrControls![controlIndex].selectRect = rectString
            self.dataSource.qrControls![controlIndex].contentRect = rectString
            self.dataSource.qrControls![controlIndex].W = Float(view.frame.width)
            self.dataSource.qrControls![controlIndex].H = Float(view.frame.height)
            return
        }
        
        if(view.isKind(of: LineElementView.self)) {
            self.dataSource.lineControls![controlIndex].selectRect = rectString
            self.dataSource.lineControls![controlIndex].contentRect = rectString
            self.dataSource.lineControls![controlIndex].W = Float(view.frame.width)
            self.dataSource.lineControls![controlIndex].H = Float(view.frame.height)
            return
        }
        
        if(view.isKind(of: RectElementView.self)) {
            self.dataSource.rectangleControls![controlIndex].selectRect = rectString
            self.dataSource.rectangleControls![controlIndex].contentRect = rectString
            self.dataSource.rectangleControls![controlIndex].W = Float(view.frame.width)
            self.dataSource.rectangleControls![controlIndex].H = Float(view.frame.height)
            return
        }
    }
    
    /**
     * 元素高度改变时的统一处理
     */
    func elementWidthChangeClosureAction(view: ElementView, translation: CGPoint, status: UIGestureRecognizerState) -> Void {
        for subView in self.editView.subviews {
            if subView.isKind(of: ElementView.self) {
                let subElementView = subView as! ElementView
                if subElementView == view {
                    self.resetModelRectWithView(view: subElementView)
                    continue
                }
                
                if(subElementView.isSelected) {
                    subElementView.widthChangeAction(translation: translation, status: status)
                    self.resetModelRectWithView(view: subElementView)
                }
            }
        }
    }
    
    /**
     * 元素高度改变时的统一处理
     */
    func elementHeightChangeClosureAction(view: ElementView, translation: CGPoint, status: UIGestureRecognizerState) -> Void {
        for subView in self.editView.subviews {
            if subView.isKind(of: ElementView.self) &&
                !subView.isKind(of: TextElementView.self) {
                let subElementView = subView as! ElementView
                if subElementView == view {
                    self.resetModelRectWithView(view: subElementView)
                    continue
                }
                
                if(subElementView.isSelected) {
                    subElementView.heightChangeAction(translation: translation, status: status)
                    self.resetModelRectWithView(view: subElementView)
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
        if(tempView.isKind(of: QRCodeElementView.self) && !tempView.isKind(of: ImageElementView.self)) {
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
        //显示的图片 UIImagePickerControllerOriginalImage UIImagePickerControllerEditedImage
        var image: UIImage! = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // 判断是否需要压缩
        if(self.isEditPickedImage) {
            let imageData = UIImageJPEGRepresentation(image, 0.4)
            image = UIImage.init(data: imageData!)
        }
        
        // 创建数据模板
        var tempModel = TemplateImageModel()
        
        // 保存图片的base64
        let saveImageData = UIImagePNGRepresentation(image)
        tempModel.bitmap = saveImageData!.base64EncodedString()
        
        self.isSaved = false
        let subViewNum = self.editView.subviews.count
        let xPoint = CGFloat(5 + subViewNum * 16)
        let yPoint = CGFloat(5 + subViewNum * 16)
        let width = CGFloat(tempModel.W! / PROPORTION_LOCAL / self.dataSource.proportion!)
        let xPointResize = ((xPoint + width) > self.editView.frame.size.width) ? (self.editView.frame.size.width - width) : xPoint
        let yPointResize = ((yPoint + width) > self.editView.frame.size.height) ? (self.editView.frame.size.height - width) : yPoint
        let tempView = ImageElementView.init(frame: CGRect(x: xPointResize, y: yPointResize, width: width, height: width), pro: self.dataSource.proportion!)
        
        // 设置保存的坐标系
        let saveFrame = CGRect(x: xPointResize * CGFloat(self.dataSource.proportion!),
                               y: yPointResize * CGFloat(self.dataSource.proportion!),
                               width: CGFloat(tempModel.W!),
                               height: CGFloat(tempModel.H!))
        tempModel.selectRect = MHTBase.getSaveContentRect(frame: saveFrame)
        tempModel.contentRect = tempModel.selectRect!
        
        tempView.updateUIWithModel(image: image, imageModel: tempModel, pro: self.dataSource.proportion!)
        self.editView.addSubview(tempView)
        
        if(nil == self.dataSource.bitmapControls) {
            self.dataSource.bitmapControls = [tempModel]
            tempView.tag = 4000
            tempView.controlIndex = 0
        } else {
            self.dataSource.bitmapControls?.append(tempModel)
            tempView.tag = 4000 + (self.dataSource.bitmapControls?.count)!
            tempView.controlIndex = (self.dataSource.bitmapControls?.count)! - 1
        }
        
        // 添加单击和双击事件
        self.addTapActionForElementView(elementView: tempView)
        
        // 添加拖动事件，必须放在点击手势之后，因为拖动手势需要让点击手势无效，避免冲突
        self.addPanActionForElement(elementView: tempView)
        
        // 绑定回调
        tempView.widthChangeClosure = self.elementWidthChangeClosureAction(view: translation: status:)
        tempView.heightChangeClosure = self.elementHeightChangeClosureAction(view: translation: status:)
        
        //图片控制器退出
        picker.dismiss(animated: true, completion: {
            () -> Void in
        })
    }
}

/**
 * 数据初始化
 */
extension AddLabelViewController {
    // 用户保存的模板
    func getUserTemplateDataSourceService() -> Void {
        // 1.获取文件路径
        let path = Bundle.main.path(forResource: "UserTemplateConfigJSON", ofType: "geojson")
        
        // 2.通过文件路径创建NSData
        if let jsonPath = path {
            let jsonData = NSData.init(contentsOfFile: jsonPath)
            let decoder = JSONDecoder()
            self.documentDataSource = try! decoder.decode(Array<SystemTemplateConfigModel>.self, from: jsonData! as Data)
        }
    }
}
