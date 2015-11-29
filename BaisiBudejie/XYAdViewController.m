//
//  XYAdViewController.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/11/29.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYAdViewController.h"
#import "XYTabBarController.h"

/** 广告播放时间 */
static NSTimeInterval const XYAdDuration = 3.0;

@interface XYAdViewController ()

/** 广告界面背景imageView */
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
/** 展示广告imageView */
@property (weak, nonatomic) IBOutlet UIImageView *adImageView;
/** 广告剩余提示 */
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
/** 跳过广告按钮 */
@property (weak, nonatomic) IBOutlet UIButton *skipButton;

/** 广告剩余时间 */
@property (nonatomic, assign) NSTimeInterval leftTime;
/** 广告定时器 */
@property (nonatomic, weak) NSTimer *adTimer;

@end

@implementation XYAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 跳过按钮圆角
    self.skipButton.layer.cornerRadius = 7.0;
    self.skipButton.layer.masksToBounds = YES;
    
    // 设置广告界面背景
    [self setUpBackgroundImage];
    
    // 初始化广告
    [self setUpAd];
    

}

#pragma mark - 初始化

/**
 *  根据屏幕判断机型, 设置不同相应背景图片
 */
- (void)setUpBackgroundImage
{
    // 屏幕高度
    if (screenH == 736) { // 6 plus\6s plus
        self.bgImageView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    } else if (screenH == 667) { // 6\6s
        self.bgImageView.image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    } else if (screenH == 568) { // 5\5s
        self.bgImageView.image = [UIImage imageNamed:@"LaunchImage-568h"];
    } else if (screenH == 480) { // 其它iPhone
        self.bgImageView.image = [UIImage imageNamed:@"LaunchImage"];
    }
}

/**
 *  添加广告交互, 为其增加定时器
 */
- (void)setUpAd
{
    self.adImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(adClick)];
    [self.adImageView addGestureRecognizer:tapGesture];
    
    // 沙盒中是否有网络数据, 没有服务器的广告接口, 不做此功能了
    BOOL hadAd = NO;
    
    if (hadAd) {
        // 如果沙盒中有广告, 显示沙盒中的广告
    } else {
        // 如果从未加载过服务器广告图片, 显示占位广告
        // 然后在后台开启广告下载
        self.adImageView.image = [UIImage imageNamed:@"Ad"];
    }
    
    // 初始化广告剩余时间
    self.leftTime = XYAdDuration;
    
    // 开启定时器
    NSTimer *adTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    self.adTimer = adTimer;
}

#pragma mark - 跳转相关
/**
 *  定时器更新
 */
- (void)updateTime
{
    // 刷新剩余时间提示
    NSString *infoText = [NSString stringWithFormat:@"广告剩余%.0f秒", self.leftTime--];
    self.infoLabel.text = infoText;
    
    // 到时间自动进入主界面
    if (self.leftTime < 0) {
        [self skip];
    }
    
}

/**
 *  点击跳过按钮, 进入主界面
 */
- (IBAction)skip
{
    
    // 关闭定时器
    [self.adTimer invalidate];
    
    // 跳到下一个界面(窗口根控制器)
    appKeyWidow.rootViewController = [[XYTabBarController alloc] init];
    
}

/**
 *  点击广告视图, 进入广告详情界面
 */
- (void)adClick
{
    [self.adTimer invalidate];
    
    UIViewController *adVc = [[UIViewController alloc] init];
    adVc.view.backgroundColor = [UIColor whiteColor];
    UILabel *adlbl = [[UILabel alloc] init];
    adlbl.text = @"美国圣地亚哥!稍后进入主界面";
    adlbl.textAlignment = NSTextAlignmentCenter;
    adlbl.bounds = CGRectMake(0, 0, screenW, 30);
    adlbl.center = adVc.view.center;
    [adVc.view addSubview:adlbl];
    
    appKeyWidow.rootViewController = adVc;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        appKeyWidow.rootViewController = [[XYTabBarController alloc] init];
    });
}

@end
