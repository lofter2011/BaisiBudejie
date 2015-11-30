//
//  XYTabBarController.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/11/29.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYTabBarController.h"
#import "UIImage+Image.h"
#import "UIColor+RandomColor.h"

@interface XYTabBarController ()

/** 发布按钮 */
@property (nonatomic, weak) UIButton *publishButton;
@end

@implementation XYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置所有UITabBarItem的文字属性
    [self setUpItemTitleAttrs];
    
    // 添加所有的子控制器
    [self setUpAllChildVcs];

}

- (void)viewWillAppear:(BOOL)animated
{
    [self publishButton];
}

/**
 *  设置所有UITabBarItem的文字属性
 */
- (void)setUpItemTitleAttrs
{
    // 正常状态文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // 选中状态文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    // 通过appearance统一给UITabBarItem的文字设置属性
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];

}

/**
 *  添加所有的子控制器
 */
- (void)setUpAllChildVcs
{
    [self setUpOneChildVc:[[UIViewController alloc] init] image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon" title:@"精华"];
    
    [self setUpOneChildVc:[[UIViewController alloc] init] image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon" title:@"新帖"];
    
    [self setUpOneChildVc:[[UIViewController alloc] init] image:nil selectedImage:nil title:nil];
    
    [self setUpOneChildVc:[[UIViewController alloc] init] image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon" title:@"关注"];

    [self setUpOneChildVc:[[UIViewController alloc] init] image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon" title:@"我"];
}

/**
 *  初始化一个子控制器
 *
 *  @param childVc           被初始化的子控制器
 *  @param imageName         子控制器TabBarItem图标
 *  @param selectedImageName 子控制器TabBarItem选中图标
 *  @param title             子控制器TabBarItem标题
 */
- (void)setUpOneChildVc:(UIViewController *)childVc image:(NSString *)imageName selectedImage:(NSString *)selectedImageName title:(NSString *)title
{
    // 随机背景色
    childVc.view.backgroundColor = [UIColor colorRandom];

    // tabBarItem的标题和图标
    childVc.tabBarItem.title = title;
    // imageNamed:如果参数为nil或空串的话, 会报警告. length>0会排除这两种情况, 消除警告
    if (imageName.length) childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    if (selectedImageName.length) childVc.tabBarItem.selectedImage = [UIImage imageWithOriginalImageName:selectedImageName];

    [self addChildViewController:childVc];
}

#pragma mark - 逻辑操作
- (void)publishClick
{
    XYFuncLocation;
}

#pragma mark - 懒加载
- (UIButton *)publishButton
{
    if (!_publishButton) {
        UIButton *publishButton = [[UIButton alloc] init];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        publishButton.xy_size = self.tabBar.xy_size;
        publishButton.center = self.tabBar.center;
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:publishButton];
        _publishButton = publishButton;
    }
    return _publishButton;
}
@end
