//
//  bluetoothMVC.swift
//  MHTLabelPrinter
//
//  Created by 程骋 on 2018/1/3.
//  Copyright © 2018年 MHT. All rights reserved.
//

import UIKit

class BluetoothMVC: UIViewController {
    var currentPrinter:UILabel!
    var printerName:UILabel!
    var printerMac:UILabel!
    
    // 锁定当前的搜索状态
    var isSearching: Bool = false
    
    // 当前搜索到的设备列表
    var searchTableView: UITableView!
    var searchDataSource: Array<CBPeripheral> = []
    
    // 搜索按钮
    var searchButton: UIBarButtonItem!
    
    // 当前连接的设备
    var linkCBPeripheral: CBPeripheral?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = MHTBase.internationalStringWith(str: "打印机列表")
        self.setBluetoothUI()
        
        // 一开始就搜索
        self.searchBtnE()
    }
    
    func setBluetoothUI() -> Void {
        self.view.backgroundColor = UIColor.white
        
        // 可连接设备连表
        self.searchTableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_width, height: SCREEN_height))
        self.view.addSubview(self.searchTableView)
        self.searchTableView.delegate = self
        self.searchTableView.dataSource = self
        self.searchTableView.backgroundColor = UIColor.white
        self.searchTableView.showsVerticalScrollIndicator = false
        self.searchTableView.showsHorizontalScrollIndicator = false
        self.searchTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
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
        FzhBluetooth.shareInstance().scanForPeripherals(withPrefixName: "") {
            (central, peripheral, advertisementData, RSSI) in
            self.addCBPeripheralAction(model: peripheral!)
        }
    }
    
    // 添加元素事件
    func addCBPeripheralAction(model: CBPeripheral) -> Void {
        for i in 0 ..< self.searchDataSource.count {
            let oriModel = self.searchDataSource[i]
            if oriModel.identifier == model.identifier {
                self.searchDataSource[i] = model
                self.searchTableView.reloadRows(at: [IndexPath.init(row: i, section: 1)], with: UITableViewRowAnimation.fade)
                return
            }
        }
        
        self.searchDataSource.append(model)
        self.searchTableView.reloadData()
    }
    
    // 返回上一级时，停止搜描
    func turnBackAction() -> Void {
        FzhBluetooth.shareInstance().stopScan()
        self.navigationController?.popViewController(animated: true)
    }
}

// 列表代理的数据源
extension BluetoothMVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if 0 == section {
            return 2
        }
        
        return self.searchDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if 0 == indexPath.section {
            let linkCellName = "linkCellName"
            var linkCell = tableView.dequeueReusableCell(withIdentifier: linkCellName)
            if nil == linkCell {
                linkCell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: linkCellName)
                linkCell?.selectionStyle = UITableViewCellSelectionStyle.none
            }
            
            if nil == self.linkCBPeripheral {
                if 0 == indexPath.row {
                    linkCell?.textLabel?.text = MHTBase.internationalStringWith(str: "名称") + ": " + MHTBase.internationalStringWith(str: "未连接蓝牙")
                } else {
                    linkCell?.textLabel?.text = MHTBase.internationalStringWith(str: "地址") + ": " + MHTBase.internationalStringWith(str: "未连接蓝牙")
                }
            } else {
                if 0 == indexPath.row {
                    linkCell?.textLabel?.text = MHTBase.internationalStringWith(str: "名称") + ": " + (self.linkCBPeripheral?.name)!
                } else {
                    linkCell?.textLabel?.text = MHTBase.internationalStringWith(str: "地址") + ": " + (self.linkCBPeripheral?.identifier.uuidString)!
                }
            }
            
            return linkCell!
        }
        
        let cellName = "normalCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellName)
        if nil == cell {
            cell = UITableViewCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: cellName)
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
        }
        
        // 更新数据
        let peripheral = self.searchDataSource[indexPath.row]
        let periName = (peripheral.name == nil ? "" : peripheral.name!)
        if peripheral.state == .connected {
            cell?.textLabel?.text = periName + "(" + MHTBase.internationalStringWith(str: "已连接") + ")"
        } else if peripheral.state == .connecting {
            cell?.textLabel?.text = periName + "(" + MHTBase.internationalStringWith(str: "正在连接") + ")"
        } else if peripheral.state == .disconnected {
            cell?.textLabel?.text = periName + "(" + MHTBase.internationalStringWith(str: "未连接") + ")"
        } else if peripheral.state == .disconnecting {
            cell?.textLabel?.text = periName + "(" + MHTBase.internationalStringWith(str: "正在断开") + ")"
        } else {
            cell?.textLabel?.text = periName
        }
        cell?.detailTextLabel?.text = peripheral.identifier.uuidString
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if 0 == section {
            var linkDeviceHeaderLabel = tableView.dequeueReusableHeaderFooterView(withIdentifier: "linkDeviceHeaderLabel")
            if nil == linkDeviceHeaderLabel {
                linkDeviceHeaderLabel = UITableViewHeaderFooterView.init(reuseIdentifier: "linkDeviceHeaderLabel")
            }
            linkDeviceHeaderLabel?.textLabel?.text = MHTBase.internationalStringWith(str: "当前打印机")
            return linkDeviceHeaderLabel
        }
        
        var deviceHeaderLabel = tableView.dequeueReusableHeaderFooterView(withIdentifier: "deviceHeaderLabel")
        if nil == deviceHeaderLabel {
            deviceHeaderLabel = UITableViewHeaderFooterView.init(reuseIdentifier: "deviceHeaderLabel")
        }
        deviceHeaderLabel?.textLabel?.text = MHTBase.internationalStringWith(str: "附近的蓝牙")
        return deviceHeaderLabel
    }
    
    // 点击蓝牙设备连接
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if 0 == indexPath.section {
            return
        }
        
        let peripheral = self.searchDataSource[indexPath.row]
        FzhBluetooth.shareInstance().connect(peripheral, complete: {
            (peripheral, service, ch) in
            self.linkCBPeripheral = peripheral
            self.searchTableView.reloadSections(IndexSet.init(integer: 0), with: UITableViewRowAnimation.fade)
        }, fail: {
            (peripheral, err) in
            ToastView.instance.showToast(content: (err?.localizedDescription)!)
        })
    }
}
