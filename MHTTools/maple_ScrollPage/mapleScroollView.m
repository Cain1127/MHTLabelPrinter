//
//  mapleScroollView.m
//  maple0807
//
//  Created by 程骋 on 2017/8/10.
//  Copyright © 2017年 DoraMutualEntertainment. All rights reserved.
//

#import "mapleScroollView.h"

#define Bound_Width  [[UIScreen mainScreen] bounds].size.width
#define Bound_Height [[UIScreen mainScreen] bounds].size.height
// 获得RGB颜色
#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

@interface mapleScroollView(){
    NSArray *tempArray;
}
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *selectedBtn;
@end

@implementation mapleScroollView
+ (mapleScroollView *)sharedTabBar{
    static mapleScroollView *CustomTabBar = nil;
    static dispatch_once_t tabBar;
    dispatch_once(&tabBar, ^{
        CustomTabBar = [[self alloc] init];
    });
    return CustomTabBar;
}

+ (mapleScroollView *)setTabBarPoint:(CGPoint)points{
    return [[mapleScroollView sharedTabBar] setTabBarPoint:points];
}

- (mapleScroollView *)setTabBarPoint:(CGPoint)point{
    CGRect frame = self.frame;
    frame.origin.x = point.x;
    frame.origin.y = point.y;
    self.frame = frame;
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadUI];
    }
    return self;
}

- (void)loadUI{
    self.frame = CGRectMake(0, 0, Bound_Width, 40);
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderWidth = 0.6;
    self.layer.borderColor = [UIColor colorWithRed:0.698f green:0.698f blue:0.698f alpha:1.00f].CGColor;
}

- (void)setData:(NSArray *)titles NormalColor:(UIColor *)normal_color SelectColor:(UIColor *)select_color Font:(UIFont *) font {
    [self setData:titles NormalColor: normal_color SelectColor: select_color Font: font selectedIndex: 0];
}

- (void)setData:(NSArray *)titles NormalColor:(UIColor *)normal_color SelectColor:(UIColor *)select_color Font:(UIFont *) font selectedIndex: (int)selectedIndex {
    tempArray = titles;
    CGFloat _width = Bound_Width / titles.count;
    
    for (int i=0; i < titles.count; i++) {
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        item.frame = CGRectMake(i * _width, 0, _width, CGRectGetHeight(self.frame));
        [item setTitle:titles[i] forState:UIControlStateNormal];
        [item setTitleColor:normal_color forState:UIControlStateNormal];
        [item setTitleColor:select_color forState:UIControlStateSelected];
        item.titleLabel.font = font;
        item.tag = i + 10;
        [item addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:item];
        
        if (i == selectedIndex) {
            item.selected = YES;
            self.selectedBtn = item;
            self.lineView = [[UIView alloc]initWithFrame:CGRectMake(selectedIndex * _width, CGRectGetHeight(self.frame) - 3, _width, 3)];
            self.lineView.layer.cornerRadius = 3.0;
            self.lineView.backgroundColor = kColor(244, 92, 42);
            self.lineView.layer.masksToBounds = YES;
            [self addSubview:self.lineView];
        }
    }
}

- (void)clickItem:(UIButton *)button{
    
    [self setAnimation:button.tag-10];
    
    if (self.indexBlock != nil) {
        self.indexBlock(tempArray[button.tag-10],button.tag-10);
    }
}

/***********************【属性】***********************/

- (void)setLineColor:(UIColor *)lineColor{
    self.lineView.backgroundColor = lineColor;
}

- (void)setLineHeight:(CGFloat)lineHeight{
    CGRect frame = self.lineView.frame;
    frame.size.height = lineHeight;
    frame.origin.y = CGRectGetHeight(self.frame) - lineHeight - 1;
    self.lineView.frame = frame;
}

- (void)setLineCornerRadius:(CGFloat)lineCornerRadius{
    self.lineView.layer.cornerRadius = lineCornerRadius;
}
/***********************【回调】***********************/

- (void)getViewIndex:(IndexBlock)block{
    self.indexBlock = block;
}

+ (void)setViewIndex:(NSInteger)index{
    [[mapleScroollView sharedTabBar] setViewIndex:index];
}

- (void)setViewIndex:(NSInteger)index {
    if (index < 0) {
        index = 0;
    }
    
    if (index > tempArray.count - 1) {
        index = tempArray.count - 1;
    }
    
    if (self.indexBlock != nil) {
        self.indexBlock(tempArray[index], index);
    }
    
    [self setAnimation:index];
}

/***********************【其他】***********************/

- (void)setAnimation:(NSInteger)index{
    
    UIButton *tempBtn = (UIButton *)[self viewWithTag:index+10];
    self.selectedBtn.selected = NO;
    tempBtn.selected = YES;
    self.selectedBtn = tempBtn;
    
    CGFloat x = index * (Bound_Width / tempArray.count);
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.lineView.frame;
        frame.origin.x = x;
        self.lineView.frame = frame;
    }];
}

@end
