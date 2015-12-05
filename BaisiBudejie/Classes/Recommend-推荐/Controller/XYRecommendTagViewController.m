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
    self.view.backgroundColor = XYCommonBgColor;
    
    [self setUpTable];
    
    [self loadRecommendTags];
}

- (void)setUpTable
{
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XYRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:XYRecommendTagCellId];
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)loadRecommendTags
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    __weak typeof(self) weakSelf = self;

    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, NSArray * _Nonnull responseObject) {
        NSLog(@"请求成功");
        
        // 字典数组 -> 模型数组
        weakSelf.recommendTags = [XYRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        NSLog(@"%@", weakSelf.recommendTags);
        [weakSelf.tableView reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
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
    NSLog(@"%zd", self.recommendTags.count);
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
