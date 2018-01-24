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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // 创建沙盒模板文件夹
        print("document path: " + MHTBase.getTemplateDocumentPath())
        
        // 搭建UI
        setHomeNavUI()
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
        self.navigationController?.pushViewController(bluetoothMVC(), animated: true)
    }
    //maple_mark-------🍁🍁🍁🍁🍁🍁新建标签
    @IBAction func addLabelBtn(_ sender: UIButton) {
        self.navigationController?.pushViewController(AddLabelViewController(), animated: true)

    }
    //maple_mark-------🍁🍁🍁🍁🍁🍁打印标签
    @IBAction func printLabelBtn(_ sender: UIButton) {
        self.navigationController?.pushViewController(bluetoothMVC(), animated: true)
    }
    //maple_mark-------🍁🍁🍁🍁🍁🍁快速打印
    @IBAction func quickPrintBtn(_ sender: UIButton) {
        self.navigationController?.pushViewController(quickPrintVC(), animated: true)
    }
    //maple_mark-------🍁🍁🍁🍁🍁🍁便签模版
    @IBAction func labelModelBtn(_ sender: UIButton) {
        self.navigationController?.pushViewController(LabelModelViewController(), animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
