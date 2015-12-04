//
//  XYNewViewController.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/11/30.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYNewViewController.h"

@interface XYNewViewController ()

@end

@implementation XYNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = XYCommonBgColor;

    // NavigationItem标题视图
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];

    // 导航栏按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem xy_itemWithImage:@"MainTagSubIcon" highlightedImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
}

#pragma mark - 监听
/**
 *  推荐标签
 */
- (void)tagClick
{
    XYFuncLocation;
}

@end
