//
//  labelModelViewController.swift
//  MHTLabelPrinter
//
//  Created by 程骋 on 2018/1/4.
//  Copyright © 2018年 MHT. All rights reserved.
//

import UIKit

class labelModelViewController: UIViewController {
    fileprivate var pageView:UIView!
    fileprivate var mainScrollView:UIScrollView!
    fileprivate var dataSource:Array<TemplateModel>?;
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // 获取本地的系统模板数据
        self.getSystemTemplateDataSourceService()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.setlabelModelUI()
    }
    
    // 读取系统模板数据
    func getSystemTemplateDataSourceService() -> Void {
        // 1.获取文件路径
        let path = Bundle.main.path(forResource: "mbymx4830", ofType: "geojson")
        
        // 2.通过文件路径创建NSData
        if let jsonPath = path {
            let jsonData = NSData.init(contentsOfFile: jsonPath)
            let decoder = JSONDecoder()
            self.dataSource = try! decoder.decode(Array<TemplateModel>.self, from: jsonData! as Data)
        }
    }
    
    // 搭建UI
    func setlabelModelUI() -> Void {
        self.title = MHTBase.internationalStringWith(str: "模板列表")
        
        let rightBtn = UIBarButtonItem.init(title: MHTBase.internationalStringWith(str: "确定"), style: .plain, target: self, action: #selector(self.sureBtnE(sender:)))
        rightBtn.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: CGFloat(13 * MHTBase.autoScreen()))], for: UIControlState.normal)
        rightBtn.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: CGFloat(13 * MHTBase.autoScreen()))], for: UIControlState.highlighted)
        rightBtn.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = rightBtn
        
        let navMaxY = self.navigationController?.navigationBar.frame.maxY
        pageView = UIView.init(frame: CGRect.init(x: 0, y: navMaxY!, width: SCREEN_width, height: SCREEN_height-navMaxY!))
        self.view.addSubview(pageView)
        addPageScrollView()
    }
    
    @objc func sureBtnE(sender:UIBarButtonItem) -> Void {
        sender.title = "搜索中"
    }
    
    func addPageScrollView() -> Void {
        let pageTA4 = [ MHTBase.internationalStringWith(str: "系统模板"), MHTBase.internationalStringWith(str: "保存的模板")]
        let pageScrollView = mapleScroollView.init()//setTabBarPoint(CGPoint.init(x: 0, y: 0))
        pageScrollView.lineColor = UIColor.clear
        pageScrollView.setData(pageTA4, normalColor: UIColor.black, select: UIColor.red, font: UIFont.systemFont(ofSize: 14))
        
        pageView.addSubview(pageScrollView)
        mapleScroollView.setViewIndex(0)
        
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
        self.mainScrollView.contentSize = CGSize.init(width: CGFloat(pageTA4.count) * SCREEN_width ,height: 0)
        pageView.addSubview(mainScrollView!)
        
        for m in 0..<pageTA4.count {
            let mapleView = UITableView.init(frame: CGRect.init(x: CGFloat(m) * SCREEN_width, y: 0, width: SCREEN_width, height: pageView.bounds.height - 40));
            mapleView.separatorStyle = UITableViewCellSeparatorStyle.none;
            mapleView.showsVerticalScrollIndicator = false;
            mapleView.showsHorizontalScrollIndicator = false;
            mapleView.delegate = self;
            mapleView.dataSource = self;
            switch m {
            case 0 :
                mapleView.tag = 1000;
            case 1:
                mapleView.tag = 1001;
            default:
                print(4)
            }
            mainScrollView.addSubview(mapleView)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

/*
 * 列表代理
 */
extension labelModelViewController: UITableViewDelegate, UITableViewDataSource {
    //返回表格视图应该显示的数据的段数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    //返回表格视图上每段应该显示的数据的行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(nil == dataSource) {
            return 0
        }
        return dataSource!.count;
    }
    
    //返回某行上应该显示的单元格
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //定义一个cell标示符，用以区分不同的cell
        let cellID : String = "cell";
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID) as UITableViewCell!;
        
        // 检测，拿到一个可用的cell
        if(cell == nil) {
            cell = UITableViewCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: cellID);
        }
        
        let temp = self.dataSource![indexPath.row];
        
        // 将图片转为base64
//        let imageData = UIImagePNGRepresentation(image)
//        let base64String = imageData!.base64EncodedStringWithOptions
//        (NSDataBase64EncodingOptions(rawValue:0))
        
        //cell上图片
//        let data = temp.labelViewBack.data(using: String.Encoding.utf8)
        let base64 = Data(base64Encoded: temp.labelViewBack!)
        cell?.imageView?.image = UIImage(data: base64!)
//        cell?.contentView.backgroundColor = UIColor.blue;
        return cell!;
    }
}

extension labelModelViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = mainScrollView.contentOffset.x / SCREEN_width
        mapleScroollView.setViewIndex(Int(index))
    }
}
