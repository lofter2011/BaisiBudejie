//
//  XYSettingViewController.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/4.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYSettingViewController.h"
#import "XYClearCacheCell.h"
#import "XYSettingCell.h"
#import "XYSwitchCell.h"

static NSString * const XYClearCacheCellId = @"clearCache";
static NSString * const XYSettingCellId = @"setting";
static NSString * const XYSwitchCellId = @"switch";

@interface XYSettingViewController ()

@end

@implementation XYSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    
    [self.tableView registerClass:[XYClearCacheCell class] forCellReuseIdentifier:XYClearCacheCellId];
    [self.tableView registerClass:[XYSettingCell class] forCellReuseIdentifier:XYSettingCellId];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XYSwitchCell class]) bundle:nil] forCellReuseIdentifier:XYSwitchCellId];
}

#pragma mark - 数据源

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return [tableView dequeueReusableCellWithIdentifier:XYClearCacheCellId];
    } else if (indexPath.row == 4) {
        return [tableView dequeueReusableCellWithIdentifier:XYSwitchCellId];
    }
    
    XYSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:XYSettingCellId];
    cell.textLabel.text = @"其他设置";
    return cell;
}

#pragma mark - 代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYFuncLocation
}

@end
