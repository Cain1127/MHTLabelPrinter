//
//  AnimationUtil.swift
//  MHTLabelPrinter
//
//  Created by Admin on 23/01/2018.
//  Copyright © 2018 MHT. All rights reserved.
//

import UIKit

class AnimationUtil {
    
    // 弹窗动画
    static func getToastAnimation(duration:CFTimeInterval = 1.5) -> CAAnimation{
        // 大小变化动画
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnimation.keyTimes = [0, 0.1, 0.9, 1]
        scaleAnimation.values = [0.5, 1, 1,0.5]
        scaleAnimation.duration = duration
        
        // 透明度变化动画
        let opacityAnimaton = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimaton.keyTimes = [0, 0.8, 1]
        opacityAnimaton.values = [0.5, 1, 0]
        opacityAnimaton.duration = duration
        
        // 组动画
        let animation = CAAnimationGroup()
        animation.animations = [scaleAnimation, opacityAnimaton]
        /**
         * 动画的过渡效果
         * 1. kCAMediaTimingFunctionLinear//线性
         * 2. kCAMediaTimingFunctionEaseIn//淡入
         * 3. kCAMediaTimingFunctionEaseOut//淡出
         * 4. kCAMediaTimingFunctionEaseInEaseOut//淡入淡出
         * 5. kCAMediaTimingFunctionDefault//默认
         */
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        animation.duration = duration
        animation.repeatCount = 0// HUGE
        animation.isRemovedOnCompletion = false
        
        return animation
    }
}
