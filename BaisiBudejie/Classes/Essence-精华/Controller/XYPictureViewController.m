//
//  XYPictureViewController.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/9.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYPictureViewController.h"

@interface XYPictureViewController ()

@end

@implementation XYPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    // tableView设置内边距，防止导航栏和TabBar挡住内容
    self.tableView.contentInset = UIEdgeInsetsMake(XYNavMaxY + XYTitlesViewH, 0, XYTabBarH, 0);
    // 防止导航栏和TabBar挡住滚动条
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

#pragma mark - <数据源>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    static UIColor *bgColor = nil;
    if (!bgColor) {
        bgColor = [UIColor xy_colorRandom];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = bgColor;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %zd", self.class, indexPath.row];
    
    return cell;
}

@end