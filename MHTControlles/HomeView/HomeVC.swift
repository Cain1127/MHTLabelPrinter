//
//  homeVC.swift
//  MHTLabelPrinter
//
//  Created by 程骋 on 2017/12/27.
//  Copyright © 2017年 MHT. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    @IBOutlet weak var addLabelL: UIButton!
    @IBOutlet weak var printLabelL: UILabel!
    @IBOutlet weak var quickPrintL: UILabel!
    @IBOutlet weak var labelModelL: UILabel!
    @IBOutlet weak var newLabelL: UILabel!
    @IBOutlet weak var bluetoothL: UIButton!
    @IBOutlet weak var templateView: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var bottomChannelView: UIView!
    
    // 最后保存的模板对象
    var dataSource: TemplateModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 创建沙盒模板文件夹
        print("document path: " + MHTBase.getTemplateDocumentPath())
        
        // 搭建UI
        setHomeNavUI()
        
        // 读取最后编辑的模板
        self.getLatestSaveFile()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mm = mapleButton()
        mm.intervalSpace = 30
        mm.typeNum = 3
    }
    
    //maple_mark-------🍁🍁🍁🍁🍁🍁导航
    func setHomeNavUI() {
        addLabelL.titleLabel?.adjustsFontSizeToFitWidth = true
        bluetoothL.titleLabel?.adjustsFontSizeToFitWidth = true
        quickPrintL.font = UIFont.systemFont(ofSize: CGFloat(14*MHTBase.autoScreen()))
        labelModelL.font = UIFont.systemFont(ofSize: CGFloat(14*MHTBase.autoScreen()))
        printLabelL.font = UIFont.systemFont(ofSize: CGFloat(14*MHTBase.autoScreen()))
        newLabelL.font = UIFont.systemFont(ofSize: CGFloat(14*MHTBase.autoScreen()))

        self.title = MHTBase.internationalStringWith(str: "MHTLabel")
        let navRBtn = UIBarButtonItem.init(image: UIImage.init(named: "navHomeSet"), style: .plain, target: self, action: #selector(self.homeRBtnEvent))
        self.navigationItem.rightBarButtonItem = navRBtn
    }
    
    @objc func homeRBtnEvent() {
        self.navigationController?.pushViewController(setViewController(), animated: true)
    }
    
    //maple_mark-------🍁🍁🍁🍁🍁🍁点击屏幕创建标签
    @IBAction func creatLabelBtn(_ sender: UIButton) {
        self.navigationController?.pushViewController(AddLabelViewController(), animated: true)
    }
    
    //maple_mark-------🍁🍁🍁🍁🍁🍁连接蓝牙
    @IBAction func linkBluetoothBtn(_ sender: UIButton) {
        self.navigationController?.pushViewController(BluetoothMVC(), animated: true)
    }
    
    //maple_mark-------🍁🍁🍁🍁🍁🍁新建标签
    @IBAction func addLabelBtn(_ sender: UIButton) {
        self.dataSource = nil
        self.gotoEditTemplateVC()
    }
    
    //maple_mark-------🍁🍁🍁🍁🍁🍁打印标签
    @IBAction func printLabelBtn(_ sender: UIButton) {
        if nil == FzhBluetooth.shareInstance().serviceArr || 0 >= FzhBluetooth.shareInstance().serviceArr.count {
            self.navigationController?.pushViewController(BluetoothMVC(), animated: true)
        } else {
            // 判断是否有最近编辑标签
            if nil != self.dataSource && nil != self.dataSource?.labelViewBack {
                // 打印
//                var imageString = self.dataSource?.labelViewBack!
//                imageString = imageString?.replacingOccurrences(of: "\n", with: "")
                
                /**
                 * 测试打印字符串
                 * 打印完整的Android代码是PrintfManager的realPrintfBitmapByLabelView方法
                
                 * 打印的指令集是TSCL文档。一般用到的是以下指令：
                 * 第一步：初始化画布---> SIZE w(画布的宽度) mm,h(画布的高度) mm\r\n
                 * 第二步：清除画布---> CLS\r\n
                 * 第三步：发送打印数据---> BITMAP -8,0,w(图片的宽度)/8,h(图片的高度),1,加上 图片的二值化数据
                 * 这里我们只需要把标签的图片发送过去即可。发送标签数据之后，需要发送(\r\n),告诉打印机，这条命令结束
                 * 第四步：开始打印---> PRINT 1,number(此为变量，是打印的张数) \r\n
                 * 注：---> 后面是对应的指令,括号里面的中文是对变量的说明，逗号都是英文。
                 */
//                let imageString = "SIZE 40 mm,30 mm\r\nCLS\r\nTEXT 10,10,\"0\",0,12,12,\"TSPL 2\"\r\nPRINT 1,1\r\n"
//                let utf8EncodeData = imageString.data(using: String.Encoding.utf8, allowLossyConversion: true)
//
//                // 将NSData进行Base64编码
//                let base64String = utf8EncodeData?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: UInt(0)))
                
//                let byteArray: [UInt8] = Array(imageString.utf8)
//                let printData = Data.init(bytes: byteArray)
//                FzhBluetooth.shareInstance().write(printData, for: nil, completionBlock: {(ch, err) in
//
//                }, return: { (peri, ch, dataString, err) in
//
//                })

//                FzhBluetooth.shareInstance().writeValue(imageString, for: nil, completionBlock: {(ch, err) in
//                    ToastView.instance.showToast(content: MHTBase.internationalStringWith(str: "已打印"))
//                }, return: { (peri, ch, dataString, err) in
//                    ToastView.instance.showToast(content: MHTBase.internationalStringWith(str: "打印失败"))
//                    print(err as Any)
//                })
                
//                let byteArray = [0x0d, 0x0a]
//                let byteData = Data(bytes: byteArray, count: byteArray.count)
//
                let imageString1 = "SIZE 40 mm,30 mm\r\n"
                FzhBluetooth.shareInstance().writeValue(imageString1, for: nil, completionBlock: {(ch, err) in

                }, return: { (peri, ch, dataString, err) in

                })
//
//                FzhBluetooth.shareInstance().write(byteData, for: nil, completionBlock: {(ch, err) in
//
//                }, return: { (peri, ch, dataString, err) in
//
//                })

                let imageString2 = "CLS\r\n"
                FzhBluetooth.shareInstance().writeValue(imageString2, for: nil, completionBlock: {(ch, err) in

                }, return: { (peri, ch, dataString, err) in

                })
//
//                FzhBluetooth.shareInstance().write(byteData, for: nil, completionBlock: {(ch, err) in
//
//                }, return: { (peri, ch, dataString, err) in
//
//                })

//                let imageString3 = "TEXT 80,80,\"0\",0,32,32,\"TSPL 2\"\r\n"
//                let imageString3 = "BAR 80,80,300,100\r\n"
                var imageString = (self.dataSource?.labelViewBack)!
                imageString = imageString.replacingOccurrences(of: "\n", with: "")
                let base64 = Data(base64Encoded: imageString)
                let image = UIImage.init(data: base64!)
                let imageData = UIImagePNGRepresentation(image!)
//                let printImageString = String.init(data: imageData!, encoding: String.Encoding.utf8)!
//                let imageString3 = "BITMAP 10,10,400,300,0," + printImageString + "\r\n"
                let imageString3 = "BITMAP 10,10,400,300,0,"
                FzhBluetooth.shareInstance().writeValue(imageString3, for: nil, completionBlock: {(ch, err) in

                }, return: { (peri, ch, dataString, err) in

                })
                
                FzhBluetooth.shareInstance().write(imageData, for: nil, completionBlock: {(ch, err) in

                }, return: { (peri, ch, dataString, err) in

                })
                
                let imageString31 = "\r\n"
                FzhBluetooth.shareInstance().writeValue(imageString31, for: nil, completionBlock: {(ch, err) in
                    
                }, return: { (peri, ch, dataString, err) in
                    
                })
                
//                let byteArray = [66,73,84,77,65,80,32,49,48,48,44,49,48,48,44,50,44,49,54,44,49,44,0xfd,0x7f,0xf8,0x3f, 0xf0,0x0f, 0xe1,0x07,0xc3, 0x83, 0x87, 0xe1,0x0f,0xf1,0x1f,0xf0,0x1e, 0xf8,0x1c,0x38,0x00,0x00,0x00,0x00, 0xc1,0x83,0xff,0xff, 0xff,0xff, 0xff, 0xff,0x0d,0x0a]
//                let printData = Data.init(bytes: byteArray, count: byteArray.count)
////                let printData = self.dataSource?.labelViewBack?.data(using: .utf8)
//                FzhBluetooth.shareInstance().write(printData, for: nil, completionBlock: {(ch, err) in
//
//                }, return: { (peri, ch, dataString, err) in
//
//                })
//
//                let imageString5 = "\r\n"
//                FzhBluetooth.shareInstance().writeValue(imageString5, for: nil, completionBlock: {(ch, err) in
//
//                }, return: { (peri, ch, dataString, err) in
//
//                })

                let imageString4 = "PRINT 1,1\r\n"
                FzhBluetooth.shareInstance().writeValue(imageString4, for: nil, completionBlock: {(ch, err) in

                }, return: { (peri, ch, dataString, err) in

                })
//
//                FzhBluetooth.shareInstance().write(byteData, for: nil, completionBlock: {(ch, err) in
//
//                }, return: { (peri, ch, dataString, err) in
//
//                })
                
//                let imageString5 = self.dataSource?.labelViewBack
//                FzhBluetooth.shareInstance().writeValue(imageString5, for: nil, completionBlock: {(ch, err) in
//                    ToastView.instance.showToast(content: MHTBase.internationalStringWith(str: "已打印"))
//                }, return: { (peri, ch, dataString, err) in
//                    ToastView.instance.showToast(content: MHTBase.internationalStringWith(str: "打印失败"))
//                    print(err as Any)
//                })
            } else {
                self.navigationController?.pushViewController(BluetoothMVC(), animated: true)
            }
        }
    }
    
    //maple_mark-------🍁🍁🍁🍁🍁🍁快速打印
    @IBAction func quickPrintBtn(_ sender: UIButton) {
        self.navigationController?.pushViewController(QuickPrintVC(), animated: true)
    }
    
    //maple_mark-------🍁🍁🍁🍁🍁🍁便签模版
    @IBAction func labelModelBtn(_ sender: UIButton) {
        self.navigationController?.pushViewController(LabelModelViewController(), animated: true)
    }
    
    // 读取最后编辑保存的模板
    func getLatestSaveFile() -> Void {
        // 清空原来数据
        for subView in self.templateView.subviews {
            subView.removeFromSuperview()
        }
        
        // 保存最后编辑的模板
        let userDefault = UserDefaults.standard
        let filePathRelative = userDefault.string(forKey: SAVE_LATEST_FILE_PATH_KEY_NAME)
        if(nil == filePathRelative || (filePathRelative?.isEmpty)!) {
            self.view.sendSubview(toBack: self.templateView)
            return
        }
        
        // 判断文件是否存在
        let fileManager = FileManager.default
        let filePath: String = MHTBase.getTemplateDocumentPath() + "/" + filePathRelative!
        let exist = fileManager.fileExists(atPath: filePath)
        if(!exist) {
            self.view.sendSubview(toBack: self.templateView)
            return
        }
        self.view.bringSubview(toFront: self.templateView)
        
        // 显示最新的模板
        let jsonDataTemp = NSData.init(contentsOfFile: filePath)
        let decoder = JSONDecoder()
        let templateModel = try! decoder.decode(TemplateModel.self, from: jsonDataTemp! as Data)
        self.dataSource = templateModel
        
        // 重新设置编辑窗口尺寸
        let pageWidth = templateModel.width! > Float(0) ? templateModel.width! : 48
        let pageHeight = templateModel.height! > Float(0) ? templateModel.height! : 30
        
        // 判断宽高哪个占满
        var viewHeight = CGFloat(0)
        var viewWidth = CGFloat(0)
        if(pageWidth > pageHeight) {
            let width = Float(SCREEN_width - 20)
            let height = width * pageHeight / pageWidth
            viewHeight = CGFloat(height)
            viewWidth = CGFloat(width)
        } else {
            let width = Float(SCREEN_width - 20)
            let height = width
            let widthNew = height * pageWidth / pageHeight
            viewHeight = CGFloat(height)
            viewWidth = CGFloat(widthNew)
        }
        
        // 显示的模板图片
        let xpoint = (SCREEN_width - viewWidth) / 2
        let leftHeight = SCREEN_height - 64 - bottomChannelView.frame.height
        let ypoint = (leftHeight - viewHeight) / 2
        let tempImageView = UIImageView.init(frame: CGRect(x: xpoint, y: ypoint, width: viewWidth, height: viewHeight))
        tempImageView.isUserInteractionEnabled = true
        
        var imageString = templateModel.labelViewBack!
        imageString = imageString.replacingOccurrences(of: "\n", with: "")
        let base64 = Data(base64Encoded: imageString)
        tempImageView.image = UIImage(data: base64!)
        self.templateView.addSubview(tempImageView)
        
        // 点击手势
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(gotoEditTemplateVC))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        tempImageView.addGestureRecognizer(tap)
    }
    
    // 进入编辑界面
    @objc func gotoEditTemplateVC() {
        let vc = AddLabelViewController()
        if(nil != self.dataSource && !((self.dataSource?.labelName?.isEmpty)!)) {
            vc.dataSource = self.dataSource!
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
