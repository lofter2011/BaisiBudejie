//
//  XYAllViewController.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/9.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYAllViewController.h"
#import "XYTopicCell.h"
#import "XYTopic.h"
#import "XYHTTPSessionManager.h"
#import <MJExtension.h>
#import "XYRefreshFooter.h"


static NSString * const XYTopicCellId = @"topic";

@interface XYAllViewController ()
/** 会话管理者 */
@property (nonatomic, weak) XYHTTPSessionManager *manager;
/** 帖子模型数组 */
@property (nonatomic, strong) NSMutableArray *topics;

/** 加载下一页数据 */
@property (nonatomic, strong) NSString *maxtime;
@end

@implementation XYAllViewController
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化tableView
    [self setUpTableview];
    
    // 设置刷新控件
    [self setUpRefresh];
    
    // 加载新帖数据
    [self loadNewTopics];
}

/**
 *  初始化tableView
 */
- (void)setUpTableview
{
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.tableView.contentInset = UIEdgeInsetsMake(XYNavMaxY + XYTitlesViewH, 0, XYTabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.rowHeight = 200;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XYTopicCell class]) bundle:nil] forCellReuseIdentifier:XYTopicCellId];
}

/**
 *  初始化刷新控件
 */
- (void)setUpRefresh
{
    self.tableView.mj_footer = [XYRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

#pragma mark - 数据处理
/**
 *  加载新帖数据
 */
- (void)loadNewTopics
{
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @1;
    
    // 发送GET请求
    XYWeakSelf
    [self.manager GET:XYCommonURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {

        // 设置maxtime
        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典数组 -> 模型数组
        weakSelf.topics = [XYTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [weakSelf.tableView reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        XY_Log(@"请求失败");
    }];
}

/**
 *  加载更多帖子数据
 */
- (void)loadMoreTopics
{
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @1;
    params[@"maxtime"] = self.maxtime;
    
    // 发送GET请求
    XYWeakSelf
    [self.manager GET:XYCommonURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        // 设置maxtime
        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];

        // 新数据转成模型数组
        NSArray *moreTopics = [XYTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 添加新数据
        [weakSelf.topics addObjectsFromArray:moreTopics];
        
        [weakSelf.tableView reloadData];
        
        [weakSelf.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        XY_Log(@"请求失败");
    }];
}

#pragma mark - <数据源>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:XYTopicCellId];
    
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}

#pragma mark - 懒加载
- (XYHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [XYHTTPSessionManager manager];
    }
    return _manager;
}

@end