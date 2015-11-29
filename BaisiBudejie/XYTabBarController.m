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

@end

@implementation XYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    

    // 统一设置子控制器(背景色随机)
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.view.backgroundColor = [UIColor colorRandom];
    vc1.tabBarItem.title = @"精华"; // 标题
    vc1.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"]; // 普通状态图片图片
    vc1.tabBarItem.selectedImage = [UIImage imageWithOriginalImageName:@"tabBar_essence_click_icon"]; // 选中状态图片
    [self addChildViewController:vc1];
    
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.view.backgroundColor = [UIColor colorRandom];
    vc2.tabBarItem.title = @"新帖";
    vc2.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    vc2.tabBarItem.selectedImage = [UIImage imageWithOriginalImageName:@"tabBar_new_click_icon"];
    [self addChildViewController:vc2];
    
    UIViewController *vc3 = [[UIViewController alloc] init];
    vc3.view.backgroundColor = [UIColor colorRandom];
    vc3.tabBarItem.title = @"关注";
    vc3.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    vc3.tabBarItem.selectedImage = [UIImage imageWithOriginalImageName:@"tabBar_friendTrends_click_icon"];
    [self addChildViewController:vc3];
    
    UIViewController *vc4 = [[UIViewController alloc] init];
    vc4.view.backgroundColor = [UIColor colorRandom];
    vc4.tabBarItem.title = @"我";
    vc4.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    vc4.tabBarItem.selectedImage = [UIImage imageWithOriginalImageName:@"tabBar_me_click_icon"];
    [self addChildViewController:vc4];
}


@end
