//
//  quickPrintVC.swift
//  MHTLabelPrinter
//
//  Created by 程骋 on 2018/1/8.
//  Copyright © 2018年 MHT. All rights reserved.
//

import UIKit

class quickPrintVC: UIViewController {
    var editView:UIView!
    var editViewB:UIView!
    var bootmViewH:CGFloat = 0.0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.setQuickPrintUI()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        editViewB = UIView.init(frame: CGRect.init(x: 9, y: navMaxY! + 10, width: SCREEN_width-18, height: (SCREEN_width-20)))
        editViewB.backgroundColor = UIColor.black
        self.view.addSubview(editViewB)
        
        editView = UIView.init(frame: CGRect.init(x: 10, y: navMaxY! + 11, width: SCREEN_width-20, height: (SCREEN_width-22)))
        editView.backgroundColor = UIColor.white
        self.view.addSubview(editView)
        
        bootmViewH = SCREEN_height-SCREEN_width-40-navMaxY!
        let bootmStrY = navMaxY!+SCREEN_width
        print(bootmStrY)
        showQPButtons(srtY: bootmStrY, BVH: bootmViewH)
    }
    
    //maple_mark-------🍁🍁🍁🍁🍁🍁展示下面的button
    func showQPButtons(srtY:CGFloat,BVH:CGFloat) -> Void {//strY起始的Y值；BVH整个view的高
        for i in 0...1{
            for j in 0...2 {
                let btnBackView = UIView.init(frame: CGRect.init(x: 0 + CGFloat(j)*SCREEN_width/3, y: srtY + CGFloat(i) * BVH / 2, width: SCREEN_width/3, height: BVH/2))
                btnBackView.backgroundColor = UIColor.lightGray
                self.view.addSubview(btnBackView)
                let btn = UIButton.init(frame: CGRect.init(x: 3, y: 3, width: btnBackView.frame.width-6, height: btnBackView.frame.height-6))
                btn.addTarget(self, action: #selector(self.quickBottomBtnE(sender:)), for: .touchUpInside)
                btn.backgroundColor = UIColor.white
                btn.layer.masksToBounds = true
                btn.layer.cornerRadius = 5
                btn.tag = 300+i*10+j//300-301-302;310-311-312
                btnBackView.addSubview(btn)
                
            }
        }
        let titleArr = [ MHTBase.internationalStringWith(str: "保存"), MHTBase.internationalStringWith(str: "快速打印")]
        for m in 0...1 {
            let bottomBtnV = UIView.init(frame: CGRect.init(x: 0 + CGFloat(m)*SCREEN_width / 2, y: srtY + BVH, width: SCREEN_width / 2, height: 40))
            bottomBtnV.backgroundColor = UIColor.lightGray
            self.view.addSubview(bottomBtnV)
            let bottomBtns = UIButton.init(frame: CGRect.init(x: 10, y: 6, width: bottomBtnV.frame.width-20, height: bottomBtnV.frame.height-12))
            bottomBtns.addTarget(self, action: #selector(self.quickBottomBtnE(sender:)), for: .touchUpInside)
            bottomBtns.setTitle(titleArr[m], for: .normal)
            bottomBtns.setTitleColor(UIColor.black, for: .normal)
            bottomBtns.backgroundColor = UIColor.gray
            bottomBtns.layer.masksToBounds = true
            bottomBtns.layer.cornerRadius = 9
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
    
    //maple_mark-------🍁🍁🍁🍁🍁🍁下区button
    @objc func quickBottomBtnE(sender:UIButton) {
        switch sender.tag {
        case 400:
            print("保存")
        case 400:
            print("快速打印")
        default:
            print(sender.tag)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
