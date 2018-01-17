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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.setBluetoothUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = MHTBase.internationalStringWith(str: "打印机列表")
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
        
        let rightBtn = UIBarButtonItem.init(title: MHTBase.internationalStringWith(str: "搜索"), style: .plain, target: self, action: #selector(self.searchBtnE(sender:)))
        rightBtn.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: CGFloat(13 * MHTBase.autoScreen()))], for: UIControlState.normal)
        rightBtn.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: CGFloat(13 * MHTBase.autoScreen()))], for: UIControlState.highlighted)
        rightBtn.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = rightBtn
    }
    @objc func searchBtnE(sender:UIBarButtonItem) -> Void {
        sender.title = "搜索中"
        FzhBluetooth.shareInstance().scanForPeripherals(withPrefixName: "mht") { (central, peripheral, advertisementData, RSSI) in
            
            print(peripheral?.name,peripheral)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
