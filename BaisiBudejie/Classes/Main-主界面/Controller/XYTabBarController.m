//
//  XYTabBarController.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/11/29.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYTabBarController.h"
#import "XYTabBar.h"
#import "XYNavigationController.h"

#import "XYEssenceViewController.h"
#import "XYNewViewController.h"
#import "XYFollowViewController.h"
#import "XYMeViewController.h"

@interface XYTabBarController ()


@end

@implementation XYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置所有UITabBarItem的文字属性
    [self setUpItemTitleAttrs];
    
    // 添加所有的子控制器
    [self setUpAllChildVcs];
    
    // 替换TabBar
    [self replaceTabBar];
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
    XYNavigationController *essenceNav = [[XYNavigationController alloc] initWithRootViewController:[[XYEssenceViewController alloc] init]];
    [self setUpOneChildVc:essenceNav image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon" title:@"精华"];
    
    XYNavigationController *newNav = [[XYNavigationController alloc] initWithRootViewController:[[XYNewViewController alloc] init]];
    [self setUpOneChildVc:newNav image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon" title:@"新帖"];
    
    XYNavigationController *followNav = [[XYNavigationController alloc] initWithRootViewController:[[XYFollowViewController alloc] init]];
    [self setUpOneChildVc:followNav image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon" title:@"关注"];

    XYNavigationController *meNav = [[XYNavigationController alloc] initWithRootViewController:[[XYMeViewController alloc] init]];
    [self setUpOneChildVc:meNav image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon" title:@"我"];
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
    // tabBarItem的标题和图标
    childVc.tabBarItem.title = title;
    // imageNamed:如果参数为nil或空串的话, 会报警告. length>0会排除这两种情况, 消除警告
    if (imageName.length) childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    if (selectedImageName.length) childVc.tabBarItem.selectedImage = [UIImage xy_imageWithOriginalImageName:selectedImageName];

    [self addChildViewController:childVc];
}

/**
 *  用自定义的TabBar替换系统的TabBar
 */
- (void)replaceTabBar
{
    [self setValue:[[XYTabBar alloc] init] forKeyPath:@"tabBar"];
}

@end
