//
//  quickPrintVC.swift
//  MHTLabelPrinter
//
//  Created by 程骋 on 2018/1/8.
//  Copyright © 2018年 MHT. All rights reserved.
//

import UIKit

class QuickPrintVC: UIViewController {
    var editView: UIView!
    
    // 打印方式
    var dataSource: QuickPrintDataModel = QuickPrintDataModel()
    
    // 预览按包缓存
    var buttonDataSource: Array<UIButton>! = []
    
    // 真正的数据对象
    var modelDataSource: Array<TemplateModel>? = []
    
    // 是否有编辑状态
    var isSave: Bool = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // 请求数据
        self.getQuickPrintDataSource()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setQuickPrintUI()
    }

    func setQuickPrintUI() -> Void {
        self.title = MHTBase.internationalStringWith(str: "快速打印")
        let navMaxY = self.navigationController?.navigationBar.frame.maxY
        
        let navRBtn = UIBarButtonItem.init(title: "删除", style: .plain, target: self, action: #selector(self.quickPNavB(sender:)))
        navRBtn.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: CGFloat(13 * MHTBase.autoScreen())),NSAttributedStringKey.foregroundColor:UIColor.white], for: UIControlState.normal)
        navRBtn.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: CGFloat(13 * MHTBase.autoScreen())),NSAttributedStringKey.foregroundColor:UIColor.white], for: UIControlState.highlighted)
        navRBtn.tag = 10
        self.navigationItem.rightBarButtonItem = navRBtn
        
        let addLBI = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_width, height: SCREEN_height))
        addLBI.image = UIImage.init(named: "homeMainIV")
        self.view.addSubview(addLBI)
        
        // 打印方式和纸张信息底view
        let channelView = UIView(frame: CGRect(x: 0, y: navMaxY!, width: SCREEN_width, height: 40))
        channelView.backgroundColor = UIColor.white
        self.view.addSubview(channelView)
        
        // 打印方式
        let channelButtonWidth = (SCREEN_width - 48) / 2
        let printStyleButton = UIButton()
        printStyleButton.frame = CGRect(x: 16, y: 0, width: channelButtonWidth, height: channelView.frame.height)
        printStyleButton.addTarget(self, action: #selector(printStyleAction(sender:)), for: UIControlEvents.touchUpInside)
        printStyleButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        channelView.addSubview(printStyleButton)
        printStyleButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.resetPrintStyleButtonTitle(sender: printStyleButton)
        
        // 打印张数
        let printPageNumberButton = UIButton()
        printPageNumberButton.frame = CGRect(x: printStyleButton.frame.maxX + 16, y: 0, width: channelButtonWidth, height: channelView.frame.height)
        printPageNumberButton.addTarget(self, action: #selector(printNumberAction(sender:)), for: UIControlEvents.touchUpInside)
        printPageNumberButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        channelView.addSubview(printPageNumberButton)
        printPageNumberButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.resetPrintNumberButtonTitle(sender: printPageNumberButton)
        
        // 底部按钮的宽高
        let widthSmallImage = (SCREEN_width - 32) / 3
        let heightSmallImage = widthSmallImage * 5 / 8
        let bootmViewH = heightSmallImage * 2 + 16 + 40 + 32
        
        // 预览窗口
        editView = UIView.init(frame: CGRect.init(x: 10, y: channelView.frame.maxY + 10, width: SCREEN_width - 20, height: SCREEN_height - channelView.frame.maxY - bootmViewH - 20))
        editView.backgroundColor = UIColor.white
        self.view.addSubview(editView)
        
        // 底部按钮区
        showQPButtons(bottomViewHeight: bootmViewH, buttonWidth: widthSmallImage, buttonHeight: heightSmallImage)
    }
    
    //maple_mark-------🍁🍁🍁🍁🍁🍁展示下面的button
    func showQPButtons(bottomViewHeight: CGFloat, buttonWidth: CGFloat, buttonHeight: CGFloat) -> Void {
        let startY = SCREEN_height - bottomViewHeight
        
        //strY起始的Y值；BVH整个view的高
        for i in 0...1 {
            for j in 0...2 {
                let btnBackView = UIView.init(frame: CGRect.init(x: 0 + CGFloat(j) * SCREEN_width / 3, y: startY + CGFloat(i) * (buttonHeight + 8), width: SCREEN_width / 3, height: buttonHeight + 8))
                btnBackView.backgroundColor = UIColor.white
                
                self.view.addSubview(btnBackView)
                let btn = UIButton.init(frame: CGRect(x: 8, y: 8, width: buttonWidth, height: buttonHeight))
                btn.addTarget(self, action: #selector(self.quickBottomBtnE(sender:)), for: .touchUpInside)
                btn.backgroundColor = UIColor.white
                btn.layer.masksToBounds = true
                btn.layer.cornerRadius = 8
                btn.tag = 300 + i * 10 + j
                btn.layer.borderColor = SYS_LIGHT_GREY.cgColor
                btn.layer.borderWidth = 0.5
                btn.imageView?.contentMode = .scaleAspectFill
                self.buttonDataSource.append(btn)
                btnBackView.addSubview(btn)
            }
        }
        
        let titleArr = [ MHTBase.internationalStringWith(str: "保存"), MHTBase.internationalStringWith(str: "快速打印")]
        for m in 0...1 {
            let bottomBtnV = UIView.init(frame: CGRect.init(x: 0 + CGFloat(m) * SCREEN_width / 2, y: SCREEN_height - 40 - 32, width: (SCREEN_width) / 2, height: 40 + 32))
            bottomBtnV.backgroundColor = UIColor.white
            self.view.addSubview(bottomBtnV)
            
            let bottomBtns = UIButton.init(frame: CGRect.init(x: 16, y: 16, width: bottomBtnV.frame.width - 24, height: 40))
            bottomBtns.addTarget(self, action: #selector(self.quickBottomBtnE(sender:)), for: .touchUpInside)
            bottomBtns.setTitle(titleArr[m], for: .normal)
            bottomBtns.setTitleColor(UIColor.black, for: .normal)
            bottomBtns.backgroundColor = SYS_LIGHT_GREY
            bottomBtns.layer.masksToBounds = true
            bottomBtns.layer.cornerRadius = 4
            bottomBtns.tag = 400 + m
            bottomBtnV.addSubview(bottomBtns)
        }
    }
    
    //maple_mark-------🍁🍁🍁🍁🍁🍁用在展示标签--预留
    func showQPlabel(supView:UIView) -> Void {
        
    }
    
    //maple_mark-------🍁🍁🍁🍁🍁🍁导航btn
    @objc func quickPNavB(sender:UIBarButtonItem) -> Void {
        
    }
    
    // 打印方式按钮事件
    @objc func printStyleAction(sender: UIButton) -> Void {
        let alertController = UIAlertController(title: MHTBase.internationalStringWith(str: "请选择打印方式"), message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: MHTBase.internationalStringWith(str: "普通打印"), style: .default, handler: {
            action in
            self.dataSource.printStyle = 0
            self.resetPrintStyleButtonTitle(sender: sender)
        })
        let waitAction = UIAlertAction(title: MHTBase.internationalStringWith(str: "序列打印"), style: .default, handler: {
            action in
            self.dataSource.printStyle = 1
            self.resetPrintStyleButtonTitle(sender: sender)
        })
        let okAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(waitAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // 根据新的设置，更新打印方式按钮的标题
    func resetPrintStyleButtonTitle(sender: UIButton) -> Void {
        if 0 == self.dataSource.printStyle {
            sender.setTitle(MHTBase.internationalStringWith(str: "打印方式：普通打印"), for: UIControlState.normal)
            return
        }
        
        if 1 == self.dataSource.printStyle {
            sender.setTitle(MHTBase.internationalStringWith(str: "打印方式：序列化打印"), for: UIControlState.normal)
            return
        }
    }
    
    // 打印纸张按钮事件
    @objc func printNumberAction(sender: UIButton) -> Void {
        let alertController = UIAlertController(title: MHTBase.internationalStringWith(str: "请选择打印方式"), message: nil, preferredStyle: .alert)
        
        // 数量输入框
        alertController.addTextField {
            (textField) in
            textField.keyboardType = .numberPad
            textField.text = self.dataSource.pageNumber?.description
        }
        
        let waitAction = UIAlertAction(title: MHTBase.internationalStringWith(str: "确认"), style: .default, handler: {
            action in
            let textField = alertController.textFields?.first
            var text = textField?.text
            if nil == text || 0 >= (text! as NSString).length {
                text = "1"
            }
            
            var number = Int(text!)
            
            if 0 >= number! {
                number = 1
            }
            
            self.dataSource.pageNumber = number
            self.resetPrintNumberButtonTitle(sender: sender)
        })
        let okAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(waitAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // 根据新的设置，更新打印方式按钮的标题
    func resetPrintNumberButtonTitle(sender: UIButton) -> Void {
        let title = MHTBase.internationalStringWith(str: "打印张数：") + (self.dataSource.pageNumber?.description)!
        sender.setTitle(title, for: UIControlState.normal)
    }
    
    //maple_mark-------🍁🍁🍁🍁🍁🍁下区button
    @objc func quickBottomBtnE(sender: UIButton) {
        switch sender.tag {
        case 400:
            self.saveCurrentDataSource()
        case 401:
            self.navigationController?.pushViewController(BluetoothMVC(), animated: true)
        default:
            if 300 <= sender.tag {
                let index = sender.tag - 300
                // 判断原来是否有元素
                if nil != self.dataSource.fileNameArray &&
                    index < (self.dataSource.fileNameArray?.count)! {
                    
                } else {
                    let labelModelViewController = LabelModelViewController()
                    labelModelViewController.selectedTemplateClosure = self.pickedTempateAction(model: isUser: )
                    self.navigationController?.pushViewController(labelModelViewController, animated: true)
                }
            } else {
                print(sender.tag)
            }
        }
    }
}

extension QuickPrintVC {
    // 读取本地保存的数据源
    func getQuickPrintDataSource() -> Void {
        let userDefaults = UserDefaults.standard
        if let jsonData = userDefaults.object(forKey: "QuickPrintDataSourceData") {
            let decoder = JSONDecoder()
            self.dataSource = try! decoder.decode(QuickPrintDataModel.self, from: jsonData as! Data)
            if nil == self.dataSource.fileNameArray {
                self.dataSource.fileNameArray = []
            }
            
            // 读取文件数据源
            let readConfigQueue = DispatchQueue.global(qos: .default)
            readConfigQueue.async(group: nil, qos: .default, flags: [], execute: {
                for _ in 0 ..< self.dataSource.fileNameArray!.count {
                    for fileName in self.dataSource.fileNameArray! {
                        // 获取文件路径
                        let pathTemp = Bundle.main.path(forResource: fileName, ofType: "json")
                        
                        // 通过文件路径创建NSData
                        if let jsonPathTemp = pathTemp {
                            let jsonDataTemp = NSData.init(contentsOfFile: jsonPathTemp)
                            let decoder = JSONDecoder()
                            let templateModel = try! decoder.decode(TemplateModel.self, from: jsonDataTemp! as Data)
                            self.modelDataSource?.append(templateModel)
                        }
                    }
                }
            })
            
            // 主线程刷新数据
            readConfigQueue.async(group: nil, qos: .default, flags: .barrier, execute: {
                if 0 < (self.dataSource.fileNameArray?.count)! && 0 < (self.modelDataSource?.count)! {
                    DispatchQueue.main.async {
                        for i in 0 ..< (self.modelDataSource?.count)! {
                            let model = self.modelDataSource![i]
                            var imageString = model.labelViewBack!
                            imageString = imageString.replacingOccurrences(of: "\n", with: "")
                            let base64 = Data(base64Encoded: imageString)
                            let image = UIImage(data: base64!)
                            self.buttonDataSource[i].setImage(image, for: UIControlState.normal)
                        }
                    }
                }
            })
        }
    }
    
    // 选择模板
    func pickedTempateAction(model: TemplateModel, isUser: Bool) -> Void {
        // 将保存状态改为未保存
        self.isSave = false
        
        // 判断是否是删除操作
        for i in 0 ..< self.dataSource.fileNameArray!.count {
            let fileNameSelected = self.dataSource.fileNameArray![i]
            if fileNameSelected == model.fileName {
                // 删除数据源
                self.modelDataSource?.remove(at: i)
                self.dataSource.fileNameArray?.remove(at: i)
                
                // 更新最后一个按钮的图片
                self.buttonDataSource[(self.modelDataSource?.count)!].setImage(nil, for: UIControlState.normal)
                
                // 更新图片栏
                for j in i ..< (self.modelDataSource?.count)! {
                    var imageString = model.labelViewBack!
                    imageString = imageString.replacingOccurrences(of: "\n", with: "")
                    let base64 = Data(base64Encoded: imageString)
                    let image = UIImage(data: base64!)
                    self.buttonDataSource[j].setImage(image, for: UIControlState.normal)
                }
                
                return
            }
        }
        
        // 保存数据源
        self.modelDataSource?.append(model)
        self.dataSource.fileNameArray?.append(model.fileName!)
        var imageString = model.labelViewBack!
        imageString = imageString.replacingOccurrences(of: "\n", with: "")
        let base64 = Data(base64Encoded: imageString)
        let image = UIImage(data: base64!)
        self.buttonDataSource[(self.modelDataSource?.count)! - 1].setImage(image, for: UIControlState.normal)
    }
    
    func turnBackAction() {
        if(self.isSave) {
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
                self.saveCurrentDataSource()
            })
            alertController.addAction(cancelAction)
            alertController.addAction(waitAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func saveCurrentDataSource() -> Void {
        let encoder = JSONEncoder()
        let jsonData = try! encoder.encode(self.dataSource) as Data
        let userDefaults = UserDefaults.standard
        userDefaults.set(jsonData, forKey: "QuickPrintDataSourceData")
        self.isSave = true
        ToastView.instance.showToast(content: MHTBase.internationalStringWith(str: "保存成功"))
    }
}
