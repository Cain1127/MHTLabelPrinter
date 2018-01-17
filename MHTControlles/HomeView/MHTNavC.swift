//
//  MHTNavC.swift
//  MHTLabelPrinter
//
//  Created by 程骋 on 2017/12/27.
//  Copyright © 2017年 MHT. All rights reserved.
//

import UIKit

class MHTNavC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let navBar = UINavigationBar.appearance()
        //maple_mark:nav颜色
        navBar.barTintColor = SYS_Color
        //maple_mark:navTitle颜色和字体大小
        navBar.titleTextAttributes = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: CGFloat(17 * MHTBase.autoScreen())),NSAttributedStringKey.foregroundColor:UIColor.white]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = false
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "navBack"), style: .plain, target: self, action: #selector(self.navigationBack))
        }
        super.pushViewController(viewController, animated: true)
    }
    @objc func navigationBack() -> Void {
        popViewController(animated: true)
    }


}
