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
#import "XYRefreshHeader.h"

static NSString * const XYTopicCellId = @"topic";

@interface XYAllViewController ()
/** 会话管理者 */
@property (nonatomic, weak) XYHTTPSessionManager *manager;
/** 帖子模型数组 */
@property (nonatomic, strong) NSMutableArray<XYTopic *> *topics;

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
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XYTopicCell class]) bundle:nil] forCellReuseIdentifier:XYTopicCellId];
}

/**
 *  初始化刷新控件
 */
- (void)setUpRefresh
{
    // header 下拉刷新最新数据
    self.tableView.mj_header = [XYRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    // 先获取一次最新数据
    [self.tableView.mj_header beginRefreshing];
    
    // footer 上拉加载更多数据
    self.tableView.mj_footer = [XYRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

#pragma mark - 数据处理
/**
 *  加载新帖数据
 */
- (void)loadNewTopics
{
    // 取消之前请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];

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
        
        // 结束刷新(恢复默认状态)
        [weakSelf.tableView.mj_header endRefreshing];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        XY_Log(@"请求失败");
        
        // 结束刷新(恢复默认状态)
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

/**
 *  加载更多帖子数据
 */
- (void)loadMoreTopics
{
    // 取消之前请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
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
        [weakSelf.tableView.mj_footer endRefreshing];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.topics[indexPath.row].cellHeight;
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