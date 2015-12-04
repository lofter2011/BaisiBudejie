//
//  XYMeViewController.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/11/30.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYMeViewController.h"

@interface XYMeViewController ()

@end

@implementation XYMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = XYCommonBgColor;
    
    // NavigationItem标题
    self.navigationItem.title = @"我的";

    UIBarButtonItem *moonItem = [UIBarButtonItem xy_itemWithImage:@"mine-moon-icon" highlightedImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    UIBarButtonItem *settingItem = [UIBarButtonItem xy_itemWithImage:@"mine-setting-icon" highlightedImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    
    self.navigationItem.rightBarButtonItems = @[
                                                settingItem,
                                                moonItem
                                                ];
}

#pragma mark - 监听
/**
 *  夜间模式
 */
- (void)moonClick
{
    XYFuncLocation
}

/**
 *  设置
 */
- (void)settingClick
{
    XYFuncLocation
}

@end
