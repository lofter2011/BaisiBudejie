//
//  XYEssenceViewController.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/11/30.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYEssenceViewController.h"
#import "XYRecommendTagViewController.h"
#import "XYTitleButton.h"

#import "XYAllViewController.h"
#import "XYVideoViewController.h"
#import "XYAudioViewController.h"
#import "XYPictureViewController.h"
#import "XYWordViewController.h"

@interface XYEssenceViewController ()
/** 标题栏 */
@property (nonatomic, weak) UIView *titlesView;
/** 目前选中按钮 */
@property (nonatomic, weak) XYTitleButton *selectedButton;
/** 按钮下划线 */
@property (nonatomic, weak) UIView *underlineView;
@end

@implementation XYEssenceViewController
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = XYCommonBgColor;
    
    // 初始化导航栏
    [self setUpNav];
    
    // 添加所有子控制器
    [self setUpAllChildViewControllers];
    
    // 初始化内容view
    [self setUpContentView];
    
    // 初始化标题栏
    [self setUpTitleView];
}

// 初始化导航栏
- (void)setUpNav
{
    // NavigationItem标题视图
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 导航栏按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem xy_itemWithImage:@"MainTagSubIcon" highlightedImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
}

/**
 *  初始化标题栏
 */
- (void)setUpTitleView
{
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    titlesView.frame = CGRectMake(0, XYNavMaxY, self.view.xy_width, XYTitlesViewH);
    self.titlesView = titlesView;
    [self.view addSubview:titlesView];
    
    [self setUpTitlesButton];
    [self setUpUnderline];
    
}

/**
 *  添加标题按钮
 */
- (void)setUpTitlesButton
{
    // 标题内容
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    
    // 按钮尺寸
    CGFloat buttonW = self.titlesView.xy_width * 0.2;
    CGFloat buttonH = self.titlesView.xy_height;
    
    // 根据标题添加相应的按钮
    [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XYTitleButton *titleButton = [XYTitleButton buttonWithType:UIButtonTypeCustom];

        titleButton.frame = CGRectMake(buttonW * idx, 0, buttonW, buttonH);
        [titleButton setTitle:titles[idx] forState:UIControlStateNormal];
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.titlesView addSubview:titleButton];
    }];
}

/**
 *  添加下划线
 */
- (void)setUpUnderline
{
    // 取出第一个按钮
    XYTitleButton *firstTitleButton = self.titlesView.subviews.firstObject;
    
    UIView *underlineView = [[UIView alloc] init];
    
    underlineView.xy_height = 2;
    underlineView.xy_y = self.titlesView.xy_height - underlineView.xy_height;
    underlineView.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    
    self.underlineView = underlineView;
    [self.titlesView addSubview:underlineView];
    
    // 默认选中第一个按钮
    firstTitleButton.selected = YES;
    self.selectedButton = firstTitleButton;
    // 按钮内部titleView根据文字大小自动计算尺寸
    [firstTitleButton.titleLabel sizeToFit];

    underlineView.xy_width = firstTitleButton.titleLabel.xy_width + XYCommonMargin;
    underlineView.xy_centerX = firstTitleButton.xy_centerX;
}

/**
 *  添加所有内容子控制器
 */
- (void)setUpAllChildViewControllers
{
    [self addChildViewController:[[XYAllViewController alloc] init]];
    [self addChildViewController:[[XYVideoViewController alloc] init]];
    [self addChildViewController:[[XYAudioViewController alloc] init]];
    [self addChildViewController:[[XYPictureViewController alloc] init]];
    [self addChildViewController:[[XYWordViewController alloc] init]];
}

/**
 *  初始化内容view
 */
- (void)setUpContentView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollView];
    
    // scrollView中添加所有子控制器的view
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UITableViewController * _Nonnull childVc, NSUInteger idx, BOOL * _Nonnull stop) {

        childVc.view.frame = CGRectMake(idx * scrollView.xy_width, 0, scrollView.xy_width, scrollView.xy_height);

scrollView.contentInset = UIEdgeInsetsMake(XYNavMaxY+XYTitlesViewH, 0, XYTabBarH, 0);
        childVc.tableView.scrollIndicatorInsets = childVc.tableView.contentInset;
        [scrollView addSubview:childVc.view];
    }];
    self.automaticallyAdjustsScrollViewInsets = NO;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * scrollView.xy_width, 0);
}

#pragma mark - 监听
/**
 *  点击推荐标签, 跳转到推荐标签控制器
 */
- (void)tagClick
{
    XYRecommendTagViewController *recommendTagVc = [[XYRecommendTagViewController alloc] init];
    [self.navigationController pushViewController:recommendTagVc animated:YES];
}

/**
 *  点击标题按钮
 */
- (void)titleClick:(XYTitleButton *)titleButton
{
    self.selectedButton.selected = NO;
    titleButton.selected = YES;
    self.selectedButton = titleButton;

    [UIView animateWithDuration:0.25 animations:^{
        self.underlineView.xy_width = titleButton.titleLabel.xy_width + XYCommonMargin;
        self.underlineView.xy_centerX = titleButton.xy_centerX;
    }];
}
@end
