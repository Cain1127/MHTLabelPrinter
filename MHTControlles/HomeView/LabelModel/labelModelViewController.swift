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
    
    // 系统模板的列表
    fileprivate var selectedIndexSystemTample = 0
    fileprivate var systemMenuTableView: UITableView!
    fileprivate var systemTemplateTableView: UITableView!
    
    fileprivate var dataSource:Array<SystemTemplateConfigModel>?;
    
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
        let path = Bundle.main.path(forResource: "SystemTemplateConfigJSON", ofType: "geojson")
        
        // 2.通过文件路径创建NSData
        if let jsonPath = path {
            let jsonData = NSData.init(contentsOfFile: jsonPath)
            let decoder = JSONDecoder()
            self.dataSource = try! decoder.decode(Array<SystemTemplateConfigModel>.self, from: jsonData! as Data)
        }
        
        // 3. 通过配置文件读取资源文件
        if self.dataSource != nil {
//            for i in 0..<self.dataSource!.count {
//                let templateConfigModel = self.dataSource![i]
//                templateConfigModel.name = templateConfigModel.name + "1"
//            }
            
            let readConfigQueue = DispatchQueue.global(qos: .default)
            readConfigQueue.async(group: nil, qos: .default, flags: [], execute: {
                for i in 0 ..< self.dataSource!.count {
                    
                    if let filesNameArray = self.dataSource![i].fileNameArray {
                        for fileName in filesNameArray {
                            // 3.1.获取文件路径
                            let pathTemp = Bundle.main.path(forResource: fileName, ofType: "json")
                            
                            // 3.2.通过文件路径创建NSData
                            if let jsonPathTemp = pathTemp {
                                let jsonDataTemp = NSData.init(contentsOfFile: jsonPathTemp)
                                let decoder = JSONDecoder()
                                let templateModel = try! decoder.decode(TemplateModel.self, from: jsonDataTemp! as Data)
                                if nil != self.dataSource![i].dataSource {
                                    self.dataSource![i].dataSource!.append(templateModel)
                                } else {
                                    self.dataSource![i].dataSource = [templateModel]
                                }
                            }
                        }
                    }
                }
            })
            
            // 主线程刷新数据
            readConfigQueue.async(group: nil, qos: .default, flags: .barrier, execute: {
                if self.dataSource != nil {
                    DispatchQueue.main.async {
//                        self.systemMenuTableView.reloadData()
                        self.systemTemplateTableView.reloadData()
                    }
                }
            })
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
            // 底View
            let mapleView = UIView.init(frame: CGRect.init(x: CGFloat(m) * SCREEN_width, y: 0, width: SCREEN_width, height: pageView.bounds.height - 40))
            mapleView.backgroundColor = UIColor.white
            
            // 菜单列表
            let menuTableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: (mapleView.frame.width) / 4, height: mapleView.frame.height))
            menuTableView.separatorStyle = UITableViewCellSeparatorStyle.none
            menuTableView.showsVerticalScrollIndicator = false
            menuTableView.showsHorizontalScrollIndicator = false
            menuTableView.delegate = self
            menuTableView.dataSource = self
            mapleView.addSubview(menuTableView)
            
            // 分隔线
            let sepLineView = UIView.init(frame: CGRect.init(x: menuTableView.frame.width - 0.5, y: 0, width: 0.5, height: mapleView.frame.height))
            sepLineView.backgroundColor = UIColor.lightGray
            mapleView.addSubview(sepLineView)
            
            // 模板项列表
            let templateTableView = UITableView.init(frame: CGRect.init(x: menuTableView.frame.width, y: 0, width: (mapleView.frame.width) * 3 / 4, height: mapleView.frame.height))
            templateTableView.separatorStyle = UITableViewCellSeparatorStyle.none
            templateTableView.showsVerticalScrollIndicator = false
            templateTableView.showsHorizontalScrollIndicator = false
            templateTableView.delegate = self
            templateTableView.dataSource = self
            mapleView.addSubview(templateTableView)
        
            switch m {
            case 0 :
                self.systemMenuTableView = menuTableView
                self.systemTemplateTableView = templateTableView
            case 1:
                print(1)
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
        // 系统模板的菜单项
        if(tableView == self.systemMenuTableView) {
            if(nil == self.dataSource) {
                return 0
            }
            return self.dataSource!.count;
        }
        
        // 系统模板数据项
        if(tableView == self.systemTemplateTableView) {
            if(nil == self.dataSource) {
                return 0
            }
            
            if self.selectedIndexSystemTample < (self.dataSource?.count)! {
                let selectedMenu = self.dataSource![self.selectedIndexSystemTample]
                if let templateDataSource = selectedMenu.dataSource {
                    return templateDataSource.count
                }
            }
        }
        
        return 0
    }
    
    // 返回cell的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 系统模板的菜单项
        if(tableView == self.systemMenuTableView) {
            return 60
        }
        
        // 系统模板数据项
        if(tableView == self.systemTemplateTableView) {
            if(nil == self.dataSource) {
                return 0
            }
            
            if self.selectedIndexSystemTample < (self.dataSource?.count)! {
                let selectedMenu = self.dataSource![self.selectedIndexSystemTample]
                if let templateDataSource = selectedMenu.dataSource {
                    if(indexPath.row < templateDataSource.count) {
                        let tempTempate = templateDataSource[indexPath.row]
                        let width = SCREEN_width * 3 / 4
                        let imageHeight = CGFloat(tempTempate.height / tempTempate.width) * width
                        return imageHeight + 16 + 16 + 10
                    }
                }
            }
        }
        
        return 0
    }
    
    //返回某行上应该显示的单元格
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 系统模板的菜单项
        if(tableView == self.systemMenuTableView) {
            if(nil != self.dataSource) {
                //定义一个cell标示符，用以区分不同的cell
                let cellID : String = "MENU_CELL";
                var cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? TemplateMenuCell;
                
                // 检测，拿到一个可用的cell
                if(cell == nil) {
                    cell = TemplateMenuCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: cellID, width: tableView.frame.width, height: 60)
                }
                
                let temp = self.dataSource![indexPath.row]
                cell?.titleLabel.text = temp.name
                if(indexPath.row == self.selectedIndexSystemTample) {
                    tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableViewScrollPosition.none)
                }
                return cell!
            }
        }
        
        // 系统模板数据项
        if(tableView == self.systemTemplateTableView) {
            if(nil != self.dataSource && self.selectedIndexSystemTample < (self.dataSource?.count)!) {
                let selectedMenu = self.dataSource![self.selectedIndexSystemTample]
                if let templateDataSource = selectedMenu.dataSource {
                    if(indexPath.row < templateDataSource.count) {
                        let tempTempate = templateDataSource[indexPath.row]
                        
                        let cellID = "TEMPLATE_CELL"
                        var cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? TemplateCell
                        
                        // 检测，拿到一个可用的cell
                        if(cell == nil) {
                            let width = SCREEN_width * 3 / 4
                            let imageHeight = CGFloat(tempTempate.height / tempTempate.width) * width
                            let cellHeight = imageHeight + 16 + 16 + 10
                            cell = TemplateCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: cellID, width: tableView.frame.width, height: cellHeight)
                        }
                        
                        // 设置新的图片和标题
                        cell?.updateUIWithModel(model: tempTempate)
                        return cell!
                    }
                }
            }
        }
        
        /**
         * 定义一个普通cell，避免代码报错
         */
        let cellID : String = "cell";
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID) as UITableViewCell!;
        
        // 检测，拿到一个可用的cell
        if(cell == nil) {
            cell = UITableViewCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: cellID);
        }
        
        return cell!;
    }
    
    /**
     * 菜单栏选择事件
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableView == self.systemMenuTableView) {
            self.selectedIndexSystemTample = indexPath.row
            self.systemTemplateTableView.reloadData()
        }
    }
}

extension labelModelViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = mainScrollView.contentOffset.x / SCREEN_width
        mapleScroollView.setViewIndex(Int(index))
    }
}
