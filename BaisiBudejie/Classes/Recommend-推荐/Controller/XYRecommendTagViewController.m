//
//  XYRecommendTagViewController.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/4.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYRecommendTagViewController.h"
#import "XYHTTPSessionManager.h"
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "XYRecommendTag.h"
#import "XYRecommendTagCell.h"


static NSString * const XYRecommendTagCellId = @"tag";

@interface XYRecommendTagViewController ()

/** 请求管理者 */
@property (nonatomic, weak) XYHTTPSessionManager *manager;
/** 推荐标签数组 */
@property (nonatomic, strong) NSArray *recommendTags;
@end

@implementation XYRecommendTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"推荐标签";
    
    [self setUpTable];
    
    [self loadRecommendTags];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
    
    [self.manager invalidateSessionCancelingTasks:YES];
}

/**
 *  初始化table
 */
- (void)setUpTable
{
    self.tableView.backgroundColor = XYCommonBgColor;
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XYRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:XYRecommendTagCellId];
}

#pragma mark - 数据处理
/**
 *  加载推荐标签数据
 */
- (void)loadRecommendTags
{
    // 显示蒙版
    [SVProgressHUD showWithStatus:@"正在加载推荐标签数据"];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    // 弱引用
    __weak typeof(self) weakSelf = self;

    // 发送GET请求
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray * _Nonnull responseObject) {
        
        // 字典数组 -> 模型数组
        weakSelf.recommendTags = [XYRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];

        // 刷新表格
        [weakSelf.tableView reloadData];
        
        // 隐藏蒙版
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 取消任务不执行任何操作
        if (error.code == NSURLErrorCancelled) return ;

        // 提示错误信息
        [SVProgressHUD showErrorWithStatus:@"网络繁忙, 请稍后再试!"];
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

#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.recommendTags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:XYRecommendTagCellId];

    XYRecommendTag *recommendTag = self.recommendTags[indexPath.row];
    cell.recommendTag = recommendTag;

    return cell;
}
@end
