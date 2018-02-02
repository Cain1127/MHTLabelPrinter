//
//  TemplateModel.swift
//  MHTLabelPrinter
//
//  Created by Admin on 16/01/2018.
//  Copyright © 2018 MHT. All rights reserved.
//

import Foundation

struct TemplateModel: Codable {
    // 模板名称
    var labelName: String? = ""
    
    // 模板的宽度，单位 mm
    var width: Float? = 48
    
    // 模板的高
    var height: Float? = 30
    
    // 比率。 解释:手机屏幕显示的模板大小相对打印机需要的模板的尺寸是放大了还是缩小了。
//    等于 1 是刚好一样，大于 1 是手机显示的模板更大，小于 1 则更小
//    这个变量的存在意义为:在 Control 中，保存的尺寸都以 px 为单位，所以 需要在新控件上适配，需要请求新控件的新比率与旧比率的比，从而计算出新 Control 尺寸，保证不变形
//    新比率与旧比率的比
//    单位为 px 需要除以上面计算出来的
//    计算方式:
//    控件高度(单位 px)/8(打印机 1mm 等于 8px)/纸张高度(单位 mm) 或控件宽度(单位 px)/8(打印机 1mm 等于 8px)/纸张宽度(单位 mm)
    var proportion: Float? = PROPORTION_LOCAL
    
    // 图片二值化的阈值，默认为 128
    var concentration: Float?
    
    // 是否有背景图片
    var bitmapPaperBackground: Bool? = false
    
    // 背景图片 base64
    var backgroundBitmap: String?
    
    // 打印方向 0 90 180 270
    var printingDirection: Int? = 0
    
    // 是否开启镜像模式 true 为开启，false 为不开启
    var mirror: Bool? = false
    
    // 镜像的方向
    // public final static int TAIL_LEFT = 0, TAIL_RIGHT = 1, TAIL_TOP = 2, TAIL_BOTTOM = 3;
    var tailDirection: Int? = 0
    
    // 尾巴长度(镜像偏移线相对左边，右边，上边，下边的偏移长度，默认偏移线在中心)
    var tailLength: Float? = 10
    
    //  一维码元素数组
    var qcControls: Array<TemplateQCModel>?
    
    var qrControls: Array<TemplateQRModel>?
    
    // 文本框控件数组
    var textControl: Array<TemplateTextModel>?
    
    var lineControls: Array<TemplateLineControlModel>?
    
    var rectangleControls: Array<TemplateRectModel>?
    
    // 图片控件
    var bitmapControls: Array<TemplateImageModel>?
    
    // 当前对象的本地保存文件名
    var fileName: String? = MHTBase.idGenerator()
    
    // 当前对象的图片base64编码
    var labelViewBack: String?
    
    // 当前元素是否锁定
    var isLock: Bool? = false
    
    // 保存的目录
    var saveDocument: String? = SAVE_DOCUMENT_DEFAULT
    
}
