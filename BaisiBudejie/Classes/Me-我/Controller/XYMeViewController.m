//
//  XYMeViewController.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/11/30.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYMeViewController.h"
#import "XYSettingViewController.h"
#import "XYMeFooterView.h"
#import "XYMeCell.h"

static NSString * const XYMeCellId = @"me";

@interface XYMeViewController ()

@end

@implementation XYMeViewController

#pragma mark - 初始化

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化导航栏
    [self setUpNav];
    
    // 初始化table
    [self setUpTable];
}

/**
 *  初始化导航栏
 */
- (void)setUpNav
{
    // 导航栏标题
    self.navigationItem.title = @"我的";
    
    // 导航栏按钮
    UIBarButtonItem *moonItem = [UIBarButtonItem xy_itemWithImage:@"mine-moon-icon" highlightedImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    UIBarButtonItem *settingItem = [UIBarButtonItem xy_itemWithImage:@"mine-setting-icon" highlightedImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    
    self.navigationItem.rightBarButtonItems = @[
                                                settingItem,
                                                moonItem
                                                ];
}

/**
 *  初始化table
 */
- (void)setUpTable
{
    self.tableView.backgroundColor = XYCommonBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 44 + XYCommonMargin;
    self.tableView.contentInset = UIEdgeInsetsMake(XYCommonMargin, 0, 0, 0);
    
    // 设置footerView, 显示服务器获取的方块信息
    self.tableView.tableFooterView = [[XYMeFooterView alloc] init];
    
    [self.tableView registerClass:[XYMeCell class] forCellReuseIdentifier:XYMeCellId];
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
 *  点击设置, 跳转到设置控制器
 */
- (void)settingClick
{
    XYSettingViewController *settingVc = [[XYSettingViewController alloc] init];
    
    [self.navigationController pushViewController:settingVc animated:YES];
}

#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYMeCell *cell = [tableView dequeueReusableCellWithIdentifier:XYMeCellId];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"离线下载";
        cell.imageView.image = nil;
    }
    
    return cell;
}
@end
