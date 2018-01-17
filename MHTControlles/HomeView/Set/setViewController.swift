//
//  setViewController.swift
//  MHTLabelPrinter
//
//  Created by 程骋 on 2017/12/27.
//  Copyright © 2017年 MHT. All rights reserved.
//

import UIKit

class setViewController: UIViewController {
    var setTB:UITableView!
    var setIsCompression:Bool!//图片压缩

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setSetUI()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setIsCompression = false
        self.view.backgroundColor = UIColor.lightGray
    }
    //maple_mark-------🍁🍁🍁🍁🍁🍁设置界面
    func setSetUI() -> Void {
        self.title = MHTBase.internationalStringWith(str: "设置")
        setTB = UITableView.init(frame: SYS_Bounds)
        setTB.delegate = self
        setTB.dataSource = self
        setTB.register(UINib.init(nibName: "setTBCell", bundle: nil), forCellReuseIdentifier: "setTBCell")
        setTB.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        setTB.separatorStyle = .none
        setTB.backgroundColor = UIColor.clear
        self.view.addSubview(setTB)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
extension setViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "setTBCell", for: indexPath) as! setTBCell
            cell.cellIcon.image = UIImage.init(named: "moreLanuage")
            cell.cellLabel.text = MHTBase.internationalStringWith(str: "多语言")
            cell.cellTail.image = UIImage.init(named: "moreLanuageR")
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "setTBCell", for: indexPath) as! setTBCell
            cell.cellIcon.image = UIImage.init(named: "isCompression")
            cell.cellLabel.text = MHTBase.internationalStringWith(str: "添加图片时压缩")
            cell.cellLabel.font = UIFont.systemFont(ofSize: CGFloat(14 * MHTBase.autoScreen()))

            cell.cellTail.image = UIImage.init(named: "")
            cell.selectionStyle = .none
            return cell
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footSV = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_width, height: 10))
       footSV.backgroundColor = UIColor.lightGray
        return footSV
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        } else {
            return 0
        }
    }
    
    //maple_mark-------🍁🍁🍁🍁🍁🍁图片压缩和多语言
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        switch indexPath.section {
        case 0:
            print("多语言")
        default:
            if !setIsCompression {
                let cell = tableView.cellForRow(at: indexPath) as! setTBCell
                cell.cellIcon.image = UIImage.init(named: "isCompressionO")
                setIsCompression = true
            } else {
                let cell = tableView.cellForRow(at: indexPath) as! setTBCell
                cell.cellIcon.image = UIImage.init(named: "isCompression")
                setIsCompression = false
            }
            
        }
    }
    
}
