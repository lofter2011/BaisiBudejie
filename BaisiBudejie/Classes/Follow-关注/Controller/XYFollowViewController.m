//
//  XYFollowViewController.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/11/30.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYFollowViewController.h"

@interface XYFollowViewController ()

@end

@implementation XYFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = XYCommonBgColor;
    
    // NavigationItem标题
    self.navigationItem.title = @"我的关注";

    // 导航栏按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem xy_itemWithImage:@"friendsRecommentIcon" highlightedImage:@"friendsRecommentIcon-click" target:self action:@selector(followClick)];
}

#pragma mark - 监听
/**
 *  推荐关注
 */
- (void)followClick
{
    XYFuncLocation;
}

@end
