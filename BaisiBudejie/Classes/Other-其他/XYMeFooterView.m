//
//  XYMeFooterView.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/6.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYMeFooterView.h"
#import "XYHTTPSessionManager.h"
#import "NSDictionary+PropertyCode.h"
#import <MJExtension.h>
#import <SafariServices/SafariServices.h>
#import "XYSquare.h"
#import "XYSquareButton.h"
#import "XYWebViewController.h"

@interface XYMeFooterView ()
/** 会话管理者 */
@property (nonatomic, weak) XYHTTPSessionManager *manager;
@end


@implementation XYMeFooterView
#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self loadSquare];
    }
    return self;
}

/**
 *  根据数据添加方块按钮
 */
- (void)createButtonWithSquares:(NSArray *)squares
{
    // 按钮尺寸
    NSInteger colsPerRow = 4;
    CGFloat buttonWH = self.xy_width / colsPerRow;
    
    // 添加对应个数的方块按钮
    NSInteger count = squares.count;
    for (NSInteger i = 0; i < count; i++)
    {
        // 计算按钮位置
        NSInteger col = i % colsPerRow;
        NSInteger row = i / colsPerRow;
        CGFloat buttonX = buttonWH * col;
        CGFloat buttonY = buttonWH * row;
        
        // 创建并添加按钮
        XYSquareButton *button = [XYSquareButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonX, buttonY, buttonWH, buttonWH);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        // 设置数据
        button.square = squares[i];

        [self addSubview:button];
    }
    // 根据最后一个按钮, 设置自身的高度
    self.xy_height = CGRectGetMaxY(self.subviews.lastObject.frame);
    UITableView *tableView = (UITableView *)self.superview;
    tableView.tableFooterView = self;
}

#pragma mark - 数据处理
/**
 *  加载方块数据
 */
- (void)loadSquare
{
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"square";
    params[@"c"] = @"topic";
    
    // 弱引用
    __weak typeof(self) weakSelf = self;
    
    // 发送GET请求
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        // 字典数组 -> 模型数组
        NSArray *squares = [XYSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        // 根据获取的方块数据添加方块
        [weakSelf createButtonWithSquares:squares];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败, %@", error.localizedDescription);
    }];
}

#pragma mark - 懒加载
- (XYHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [XYHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - 监听
/**
 *  点击方块, 进行相应跳转
 */
- (void)buttonClick:(XYSquareButton *)squareButton
{

    NSString *url = squareButton.square.url;

    if ([url hasPrefix:@"http"]) { // 如果是http/https网页, 用webView展示
        UITabBarController *tab = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        UINavigationController *nav = tab.selectedViewController;
//        SFSafariViewController *safariVc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:url]];
//        safariVc.navigationController.navigationItem.title = squareButton.square.name;
//        [nav presentViewController:safariVc animated:YES completion:nil];
        XYWebViewController *webVc = [[XYWebViewController alloc] init];
        webVc.urlPath = url;
        webVc.navigationItem.title = squareButton.square.name;
        [nav pushViewController:webVc animated:YES];
        
    } else if([url hasPrefix:@"mod"]) {
        // 如果不是网页, 根据具体进行操作
        // 这里操作都需要登陆
        // 不知道登陆加密方式, 没法做
        
    } else { // 其他
        XY_Log(@"未知");
    }
        
}
@end
