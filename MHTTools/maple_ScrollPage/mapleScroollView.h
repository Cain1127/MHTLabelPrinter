//
//  mapleScroollView.h
//  maple0807
//
//  Created by 程骋 on 2017/8/10.
//  Copyright © 2017年 DoraMutualEntertainment. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^IndexBlock)(NSString *title,NSInteger index);
@interface mapleScroollView : UIView

@property (nonatomic, strong) UIColor    *lineColor;        //移动线的颜色(默认红色)
@property (nonatomic, assign) CGFloat    lineHeight;        //移动线的高度(默认2)
@property (nonatomic, assign) CGFloat    lineCornerRadius;  //移动线的两边弧度(默认3)
@property (nonatomic, copy  ) IndexBlock indexBlock;        //block回调(返回标题、下标)

/**
 *  设置控件位置
 *
 *  @param points 坐标
 *
 *  @return 对象
 */
+ (mapleScroollView *)setTabBarPoint:(CGPoint)points;

+ (mapleScroollView *)sharedTabBar;

- (mapleScroollView *)setTabBarPoint:(CGPoint)point;
/**
 *  设置数据源与属性
 *
 *  @param titles  每个选项的标题
 *  @param normal_color 默认颜色
 *  @param select_color 选中颜色
 *  @param font    字体
 */
- (void)setData:(NSArray *)titles NormalColor:(UIColor *)normal_color SelectColor:(UIColor *)select_color Font:(UIFont *)font;
- (void)setData:(NSArray *)titles NormalColor:(UIColor *)normal_color SelectColor:(UIColor *)select_color Font:(UIFont *) font selectedIndex: (int)selectedIndex;

/**
 *  得到移动的下标与内容
 *
 *  @param block 回调
 */
- (void)getViewIndex:(IndexBlock)block;
    
/**
 * 修改当前的选择下标
 */
- (void)setViewIndex:(NSInteger)index;

/**
 *  设置移动的位置
 *
 *  @param index 下标
 */
+ (void)setViewIndex:(NSInteger)index;


@end
