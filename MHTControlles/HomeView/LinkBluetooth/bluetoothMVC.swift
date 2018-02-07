//
//  bluetoothMVC.swift
//  MHTLabelPrinter
//
//  Created by 程骋 on 2018/1/3.
//  Copyright © 2018年 MHT. All rights reserved.
//

import UIKit

class bluetoothMVC: UIViewController {
    var currentPrinter:UILabel!
    var printerName:UILabel!
    var printerMac:UILabel!
    
    // 锁定当前的搜索状态
    var isSearching: Bool = false
    
    // 当前搜索到的设备列表
    var searchDataSource: Array<String> = []
    
    // 搜索按钮
    var searchButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = MHTBase.internationalStringWith(str: "打印机列表")
        self.setBluetoothUI()
        
        // 一开始就搜索
        self.searchBtnE()
    }
    
    func setBluetoothUI() -> Void {
        let navMaxY = self.navigationController?.navigationBar.frame.maxY
        self.view.backgroundColor = UIColor.white
        
        currentPrinter = UILabel.init(frame: CGRect.init(x: 5, y: navMaxY!+10, width: 100, height: 22))
        currentPrinter.text = MHTBase.internationalStringWith(str: "当前打印机")
        currentPrinter.font = UIFont.systemFont(ofSize: CGFloat(13 * MHTBase.autoScreen()))
        currentPrinter.textColor = UIColor.black
        self.view.addSubview(currentPrinter)
        
        printerName = UILabel.init(frame: CGRect.init(x: 20, y: navMaxY!+40, width: 200, height: 22))
        printerName.text = MHTBase.internationalStringWith(str: "名称：未连接蓝牙")
        printerName.font = UIFont.systemFont(ofSize: CGFloat(13 * MHTBase.autoScreen()))
        printerName.textColor = UIColor.black
        self.view.addSubview(printerName)
        
        printerMac = UILabel.init(frame: CGRect.init(x: 20, y: navMaxY!+67, width: 200, height: 22))
        printerMac.text = MHTBase.internationalStringWith(str: "地址：未连接蓝牙")
        printerMac.font = UIFont.systemFont(ofSize: CGFloat(13 * MHTBase.autoScreen()))
        printerMac.textColor = UIColor.black
        self.view.addSubview(printerMac)
        
        self.searchButton = UIBarButtonItem.init(title: MHTBase.internationalStringWith(str: "搜索"),
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(searchBtnE))
        self.searchButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: CGFloat(13 * MHTBase.autoScreen()))], for: UIControlState.normal)
        self.searchButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: CGFloat(13 * MHTBase.autoScreen()))], for: UIControlState.highlighted)
        self.searchButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = self.searchButton
    }
    
    // 搜索蓝牙设备
    @objc func searchBtnE() -> Void {
        if self.isSearching {
            return
        }
        self.isSearching = true
        self.searchButton.title = MHTBase.internationalStringWith(str: "搜索中")
        
        ToastView.instance.showToast(content: MHTBase.internationalStringWith(str: "搜索中"))
        FzhBluetooth.shareInstance().scanForPeripherals(withPrefixName: "mht") {
            (central, peripheral, advertisementData, RSSI) in
            print(peripheral?.name as Any)
            print(peripheral as Any)
        }
        
        // 设置超时
    }
}
