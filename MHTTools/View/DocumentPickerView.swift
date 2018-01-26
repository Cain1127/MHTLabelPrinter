//
//  PickerViewPop.swift
//  MHTLabelPrinter
//
//  Created by Admin on 26/01/2018.
//  Copyright © 2018 MHT. All rights reserved.
//

import UIKit

class DocumentPickerView: UIView {
    var dataSource: Array<SystemTemplateConfigModel>?
    var pickedIndex = 0
    var closeClosure: ((_ model: SystemTemplateConfigModel?) -> Void)?
    
    var pickerView: UIPickerView?
    
    init() {
        let frame = CGRect(x: 0, y: 0, width: SCREEN_width, height: SCREEN_height)
        self.pickerView = UIPickerView(frame: CGRect(x: 0, y: frame.height * 3 / 5 + 40, width: frame.width, height: frame.height * 2 / 5 - 40))
        self.pickerView?.backgroundColor = UIColor.white
        
        let buttonView = UIView(frame: CGRect(x: 0, y: frame.height * 3 / 5, width: frame.width, height: 40))
        buttonView.backgroundColor = UIColor.white
        
        let cancelButton = UIButton()
        cancelButton.frame = CGRect(x: 16, y: 0, width: 40, height: 40)
        cancelButton.setTitle("取消", for: UIControlState.normal)
        cancelButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        buttonView.addSubview(cancelButton)
        
        let confirmButton = UIButton()
        confirmButton.frame = CGRect(x: frame.width - 40 - 16, y: 0, width: 40, height: 40)
        confirmButton.setTitle("确定", for: UIControlState.normal)
        confirmButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        buttonView.addSubview(confirmButton)
        
        super.init(frame: frame)
        self.addSubview(self.pickerView!)
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
        self.pickerView?.delegate = self
        self.pickerView?.dataSource = self
        
        cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: UIControlEvents.touchUpInside)
        confirmButton.addTarget(self, action: #selector(confirmButtonAction), for: UIControlEvents.touchUpInside)
        self.addSubview(buttonView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // 取消按钮事件
    @objc func cancelButtonAction() {
        if((self.closeClosure) != nil) {
            self.closeClosure!(nil)
        }
    }
    
    // 确定按钮事件
    @objc func confirmButtonAction() {
        if((self.closeClosure) != nil) {
            self.closeClosure!(self.dataSource![self.pickedIndex])
        }
    }
}

/**
 * 文件夹选择器代理
 */
extension DocumentPickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    // 设置组的数量
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // 根据组下标，设置组里item的数量
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(nil != self.dataSource) {
            return (self.dataSource?.count)!
        }
        return 0
    }
    
    // 根据组下标，设置item文字
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(nil == self.dataSource || !(0 < (self.dataSource?.count)!)) {
            return ""
        }
        
        let model = self.dataSource![row]
        return model.name
    }
    
    // 当前选择的下标
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.pickedIndex = row
        
    }
}
