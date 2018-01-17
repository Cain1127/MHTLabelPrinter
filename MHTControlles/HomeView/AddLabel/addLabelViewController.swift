//
//  addLabelViewController.swift
//  MHTLabelPrinter
//
//  Created by 程骋 on 2018/1/4.
//  Copyright © 2018年 MHT. All rights reserved.
//

import UIKit

class addLabelViewController: UIViewController {
    fileprivate var editView:UIView!
    fileprivate var editViewB:UIView!
    fileprivate var pageView:UIView!
    fileprivate var mainScrollView:UIScrollView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setAddLabellUI()

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    func setAddLabellUI() -> Void {
        let navMaxY = self.navigationController?.navigationBar.frame.maxY
        
//        self.title = MHTBase.internationalStringWith(str: "新建标签")
        
        let navRBtn1 = UIBarButtonItem.init(image: UIImage.init(named: "navDeleting"), style: .plain, target: self, action: nil)
        
//        navRBtn1.imageInsets = UIEdgeInsetsMake(0, 10, 0, -10)
        let navRBtn2 = UIBarButtonItem.init(image: UIImage.init(named: "navPrint"), style: .done, target: self, action: nil)
//        navRBtn2.imageInsets = UIEdgeInsetsMake(0, 30, 0, -30)
        let navRBtn3 = UIBarButtonItem.init(image: UIImage.init(named: "navMSelect"), style: .done, target: self, action: nil)
//        navRBtn3.imageInsets = UIEdgeInsetsMake(0, 50, 0, -50)

        let navSpace = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: self, action: nil)
        navSpace.width = -50
        self.navigationItem.rightBarButtonItems = [navRBtn1,navSpace,navRBtn2,navSpace,navRBtn3]
        
        let addLBI = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_width, height: SCREEN_height))
        addLBI.image = UIImage.init(named: "homeMainIV")
        self.view.addSubview(addLBI)
        
        editViewB = UIView.init(frame: CGRect.init(x: 9, y: navMaxY! + 79, width: SCREEN_width-18, height: (SCREEN_width-20)*3/5 + 2))
        editViewB.backgroundColor = UIColor.black
        self.view.addSubview(editViewB)
        
        editView = UIView.init(frame: CGRect.init(x: 10, y: navMaxY! + 80, width: SCREEN_width-20, height: (SCREEN_width-20)*3/5))
        editView.backgroundColor = UIColor.white
        self.view.addSubview(editView)
        
        let aLBottomStrY = editView.frame.maxY + 79
        pageView = UIView.init(frame: CGRect.init(x: 0, y: aLBottomStrY, width: SCREEN_width, height: SCREEN_height - aLBottomStrY))
        pageView.backgroundColor = UIColor.white
        self.view.addSubview(pageView)
        addPageScrollView()

    }
    func addPageScrollView() -> Void {
        
        let pageTA1 = [MHTBase.internationalStringWith(str: "标签"),MHTBase.internationalStringWith(str: "插入"),MHTBase.internationalStringWith(str: "属性")]
        let pageScrollView = mapleScroollView.init()
        pageScrollView.lineColor = UIColor.clear
        pageScrollView.setData(pageTA1, normalColor: UIColor.black, select: UIColor.red, font: UIFont.systemFont(ofSize: 14), selectedIndex: 1)

        pageView.addSubview(pageScrollView)
        pageScrollView.getIndex({ (title, index) in
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
                let btnImage = ["AddNew","","","","","","","",""]
                let btnTitle = [MHTBase.internationalStringWith(str: "新建"),MHTBase.internationalStringWith(str: "打开"),MHTBase.internationalStringWith(str: "保存"),MHTBase.internationalStringWith(str: "另存为"),MHTBase.internationalStringWith(str: "拷贝"),MHTBase.internationalStringWith(str: "锁定"),MHTBase.internationalStringWith(str: "打印"),MHTBase.internationalStringWith(str: "上传"),MHTBase.internationalStringWith(str: "多选")]
                for i in 0...2 {
                    for j in 0...3 {
                        if i==2&&j==1{
                            break
                        }
                        let addBtnV = UIView.init(frame: CGRect.init(x: 0 + CGFloat(j)*SCREEN_width/4, y: CGFloat(i)*mapleView.bounds.height/3, width: SCREEN_width/4, height: mapleView.bounds.height/3))
                        addBtnV.backgroundColor = UIColor.green
                        mapleView.addSubview(addBtnV)
                        let addBtn = UIButton.init(frame: CGRect.init(x: 5, y: 5, width: addBtnV.bounds.width-10, height: addBtnV.bounds.height-10))
                        addBtn.setTitle(btnTitle[4*i+j], for: .normal)
                        addBtn.backgroundColor = UIColor.red
                        addBtnV.addSubview(addBtn)
                        
                    }
                }
            case 1:
                let btnImage = ["AddText","AddBarcode","AddTDcode","AddImage","Addlogo","AddLine","AddRectangle","AddTable","AddDate"]
                let btnTitle = [MHTBase.internationalStringWith(str: "文本"),MHTBase.internationalStringWith(str: "一维码"),MHTBase.internationalStringWith(str: "二维码"),MHTBase.internationalStringWith(str: "图片"),MHTBase.internationalStringWith(str: "Logo"),MHTBase.internationalStringWith(str: "线条"),MHTBase.internationalStringWith(str: "矩形"),MHTBase.internationalStringWith(str: "表格"),MHTBase.internationalStringWith(str: "日期")]
                for i in 0...2 {
                    for j in 0...3 {
                        if i==2&&j==1{
                            break
                        }
                        let addBtnV = UIView.init(frame: CGRect.init(x: 0 + CGFloat(j)*SCREEN_width/4, y: CGFloat(i)*mapleView.bounds.height/3, width: SCREEN_width/4, height: mapleView.bounds.height/3))
                        mapleView.addSubview(addBtnV)
                        
                        // 图片
                        let addImageView = UIImageView(frame: CGRect.init(x: 5, y: 5, width: addBtnV.bounds.width-10, height: addBtnV.bounds.height-10));
                        addImageView.isUserInteractionEnabled = true;
                        addImageView.image = UIImage(named: btnImage[4*i+j]);
                        addBtnV.addSubview(addImageView)
                        
                        // 按钮标题
                        let addBtn = UIButton.init(frame: CGRect.init(x: 5, y: 5, width: addBtnV.bounds.width-10, height: addBtnV.bounds.height - 20))
                        addBtn.setTitle(btnTitle[4*i+j], for: .normal)
                        addBtnV.addSubview(addBtn)
                        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
extension addLabelViewController:UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = mainScrollView.contentOffset.x / SCREEN_width
        mapleScroollView.setViewIndex(Int(index))
    }
}
