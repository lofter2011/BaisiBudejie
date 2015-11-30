//
//  XYTabBar.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/11/30.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYTabBar.h"

@interface XYTabBar ()

/** 发布按钮 */
@property (nonatomic, weak) UIButton *publishButton;
@end

@implementation XYTabBar
#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
    }
    return self;
}

#pragma mark - 布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 发布按钮的frame
    self.publishButton.xy_size = CGSizeMake(self.xy_width * 0.2, self.xy_height);
    self.publishButton.center = CGPointMake(self.xy_width * 0.5, self.xy_height * 0.5);
    
    // TabBarButton的frame
    NSInteger tabBarBtnIndex = 0;
    for (UIView *childView in self.subviews) {

        if ([NSStringFromClass([childView class]) isEqualToString:@"UITabBarButton"]) {

            [self tabBarButton:childView frameToFitForIndex:tabBarBtnIndex++];
        }
    }
}

/**
 *  调整TabBar上第index个TabBarButton的尺寸和位置, 给发布按钮空出位置
 *
 *  @param tabBarButton 要调整的TabBarButton
 *  @param index        要调整的TabBarButton的角标
 */
- (void)tabBarButton:(UIView *)tabBarButton frameToFitForIndex:(NSInteger)index
{
    // TabBar上按钮的宽高
    CGFloat buttonW = self.xy_width * 0.2;
    
    tabBarButton.xy_width = buttonW;
    
    tabBarButton.xy_x = (index < 2) ? (index * buttonW) : ((index + 1) * buttonW);
}

#pragma mark - 懒加载
/**
 *  发布按钮懒加载
 *
 *  创建发布按钮之后, 设置显示图片, 添加点击事件, 并将其添加到TabBar上
 *
 *  @return 初始化并添加到TabBar上的发布按钮
 */
- (UIButton *)publishButton
{
    if (!_publishButton) {
        UIButton *publishButton = [[UIButton alloc] init];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];

        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        _publishButton = publishButton;
    }
    return _publishButton;
}

#pragma mark - 监听方法
/**
 *  发布按钮点击
 */
- (void)publishClick
{
    XYFuncLocation;
}

@end
