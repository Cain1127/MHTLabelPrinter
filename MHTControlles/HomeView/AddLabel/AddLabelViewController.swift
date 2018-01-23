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

        let navSpace = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: self, action: nil)
        navSpace.width = -50
        self.navigationItem.rightBarButtonItems = [navRBtn1,navSpace,navRBtn2,navSpace,navRBtn3]
        
        let addLBI = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_width, height: SCREEN_height))
        addLBI.image = UIImage.init(named: "homeMainIV")
        self.view.addSubview(addLBI)
        
        // 当前编辑区
        editView = UIView.init(frame: CGRect.init(x: 10, y: navMaxY! + 80, width: SCREEN_width-20, height: (SCREEN_width - 20) * 5 / 8))
        editView.backgroundColor = UIColor.white
        editView.layer.borderWidth = 0.5
        editView.layer.borderColor = UIColor.black.cgColor
        self.view.addSubview(editView)
        
        let tapSingle = UITapGestureRecognizer(target: self, action: #selector(elementEditViewTapAction(gesture:)))
        tapSingle.numberOfTapsRequired = 1
        tapSingle.numberOfTouchesRequired = 1
        editView.addGestureRecognizer(tapSingle)
        
        let aLBottomStrY = editView.frame.maxY + 79
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
                        mapleView.addSubview(addBtnV)
                    }
                }
            case 1:
                let btnImage = ["AddText","AddBarcode","AddTDcode","AddImage","Addlogo","AddLine","AddRectangle","AddTable","AddDate"]
                let btnTitle = [MHTBase.internationalStringWith(str: "文本"),MHTBase.internationalStringWith(str: "一维码"),MHTBase.internationalStringWith(str: "二维码"),MHTBase.internationalStringWith(str: "图片"),MHTBase.internationalStringWith(str: "Logo"),MHTBase.internationalStringWith(str: "线条"),MHTBase.internationalStringWith(str: "矩形"),MHTBase.internationalStringWith(str: "表格"),MHTBase.internationalStringWith(str: "日期")]
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
                    pan.require(toFail: oriGesture)
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
        tapDouble.require(toFail: tapSingle)
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
    @objc func multSelectedChangeAction(sender: UIBarButtonItem) -> Void {
        self.isMultSelected = !self.isMultSelected
        if(self.isMultSelected) {
            sender.image = UIImage(named: "navSSelect")
        } else {
            sender.image = UIImage(named: "navMSelect")
            
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
                print("insertElementTabButtonAction 0")
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
            case 3:
                print("insertElementTabButtonAction 3")
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
            case 7:
                ToastView.instance.showToast(content: "敬请期待")
            case 8:
                print("insertElementTabButtonAction 8")
            default:
                print("insertElementTabButtonAction -1")
        }
    }
    
    // 标签分页中的按钮事件处理
    @objc func labelTabButtonAction(_ gesture: UIGestureRecognizer) -> Void {
        
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
        gesture.view?.center = point
    }
    
    // 编辑窗口中的元素双击事件
    @objc func elementDoubleTapAction(gesture: UIGestureRecognizer) -> Void {
        let tempView = gesture.view! as! ElementView
        
        // 判断当前是单选还是多选
        if(!self.isMultSelected) {
            self.clearElementSelected()
        }
        
        tempView.setIsSelected(isSelected: true)
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
