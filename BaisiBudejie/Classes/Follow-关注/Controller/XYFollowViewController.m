//
//  XYFollowViewController.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/11/30.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYFollowViewController.h"
#import "XYRecommendFollowViewController.h"
#import "XYLoginRegisterViewController.h"

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
 *  点击推荐关注, 跳转到推荐关注控制器
 */
- (void)followClick
{
    XYRecommendFollowViewController *recommendFollowVc = [[XYRecommendFollowViewController alloc] init];
    
    [self.navigationController pushViewController:recommendFollowVc animated:YES];
}

/**
 *  进入登陆注册界面
 */
- (IBAction)loginRegister:(id)sender {

    XYLoginRegisterViewController *loginRegisterVc = [[XYLoginRegisterViewController alloc] init];

    [self presentViewController:loginRegisterVc animated:YES completion:nil];
}


@end
