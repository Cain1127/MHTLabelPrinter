//
//  MHTBase.swift
//  MHTLabelPrinter
//
//  Created by 程骋 on 2017/12/27.
//  Copyright © 2017年 MHT. All rights reserved.
//

import UIKit

class MHTBase: NSObject {
    // 返回国际化的内容
    class func internationalStringWith(str:String) -> String {
        return NSLocalizedString(str, comment: str)
    }
    
    // 自适应计算
    class func autoScreen() -> Float {
        switch SCREEN_width {
        case 320:
            return 0.85
        case 375:
            return 1.00
        case 414:
            return 1.15
        default:
            return 1.00
        }
    }
    
    // 返回模板保存目录
    class func getTemplateDocumentPath() -> String {
        // 创建沙盒模板保存目录
        let home = NSHomeDirectory() as NSString;
        
        // 获得Documents路径，使用NSString对象的stringByAppendingPathComponent()方法拼接路径
        let docPath = home.appendingPathComponent("Documents") as NSString;
        
        // 文件操作
        let fileManager = FileManager.default
        let filePath: String = docPath.appendingPathComponent("template") as String
        let exist = fileManager.fileExists(atPath: filePath)
        if(!exist) {
            try! fileManager.createDirectory(atPath: filePath, withIntermediateDirectories: true, attributes: nil)
        }
        
        return filePath
    }
    
    /// 创建指定大小的的条形码图片
    ///
    /// - Parameters:
    ///   - content: 条形码内容信息
    ///   - size: 条形码大小
    /// - Returns: UIImage?
    class func creatBarCodeImage(content: String?, size: CGSize) -> UIImage? {
        // iOS 8.0以上的系统才支持条形码的生成，iOS8.0以下需要使用第三方控件生成
        if #available(iOS 8.0, *) {
            // 注意生成条形码的编码方式
            let contentEncode = content?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let data = contentEncode?.data(using: .utf8)
            let filter = CIFilter(name: "CICode128BarcodeGenerator")
            filter?.setDefaults()
            filter?.setValue(data, forKey: "inputMessage")
            filter?.setValue(NSNumber(value: 0), forKey: "inputQuietSpace")
            let outputImage = filter?.outputImage
            
            // 创建一个颜色滤镜,黑白色
            let colorFilter = CIFilter(name: "CIFalseColor")!
            colorFilter.setDefaults()
            colorFilter.setValue(outputImage, forKey: "inputImage")
            colorFilter.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: "inputColor0")
            colorFilter.setValue(CIColor(red: 1, green: 1, blue: 1, alpha: 0), forKey: "inputColor1")
            
            // 返回条形码image
            let codeImage = UIImage(ciImage: (colorFilter.outputImage!.transformed(by: CGAffineTransform(scaleX: 10, y: 10))))
            return self.resizeImage(image: codeImage, size: size)
        } else {
            return nil
        }
    }
    
    /// 创建带logo的二维码图片
    ///
    /// - Parameters:
    ///   - content: 二维码内容信息
    ///   - iconName: logo 图片名称
    /// - Returns: UIImage?
    class func creatQRCodeImage(content: String?, iconName: String?, size: CGSize) -> UIImage? {
        
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setDefaults()
        
        /// allowLossyConversion 在转换过程中是否可以移除或者改变字符
        let data = content?.data(using: String.Encoding.utf8, allowLossyConversion: false)
        filter?.setValue(data, forKey: "inputMessage")
        
        /// L M Q H 修正等级，应该跟采样有关
        filter?.setValue("H", forKey: "inputCorrectionLevel")
        let outputImage = filter?.outputImage
        
        // 创建一个颜色滤镜,黑白色
        let colorFilter = CIFilter(name: "CIFalseColor")!
        colorFilter.setDefaults()
        colorFilter.setValue(outputImage, forKey: "inputImage")
        colorFilter.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: "inputColor0")
        colorFilter.setValue(CIColor(red: 1, green: 1, blue: 1, alpha: 0), forKey: "inputColor1")
        
        // 返回二维码image
        let codeImage = UIImage(ciImage: (colorFilter.outputImage!.transformed(by: CGAffineTransform(scaleX: 10, y: 10))))
        
        // 中间一般放logo
        if let icon_name = iconName {
            if let iconImage = UIImage(named: icon_name) {
                let rect = CGRect(x: 0, y: 0, width: codeImage.size.width, height: codeImage.size.height)
                UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
                UIGraphicsBeginImageContext(rect.size)
                codeImage.draw(in: rect)
                let avatarSize = CGSize(width: rect.size.width * 0.15, height: rect.size.height * 0.15)
                
                let x = (rect.width - avatarSize.width) * 0.5
                let y = (rect.height - avatarSize.height) * 0.5
                iconImage.draw(in: CGRect(x: x, y: y, width: avatarSize.width, height: avatarSize.height))
                
                let resultImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                return self.resizeImage(image: resultImage!, size: size)
            }
        }
        
        return self.resizeImage(image: codeImage, size: size)
    }
    
    // 图像缩放
    class func resizeImage(image: UIImage, size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizeImage
    }
}
