//
//  XYNavigationController.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/4.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYNavigationController.h"

@interface XYNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation XYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置导航栏背景
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
    // 设置导航栏文字
    [self.navigationBar setTitleTextAttributes:@{
                                                 NSFontAttributeName : [UIFont boldSystemFontOfSize:18]
                                                 }];
    
    // 滑动返回手势执行与否由代理决定
    self.interactivePopGestureRecognizer.delegate = self;
}

/**
 *  重写push方法, 拦截所有push进来的拦截器进行操作
 *
 *  @param viewController push进来的拦截器
 *  @param animated       push时是否执行动画
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    // 如果是导航控制器的根控制器, 就不进行操作了
    if (self.childViewControllers.count > 0) {
        // 统一设置返回按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [button sizeToFit];
        // 按钮有点儿偏右, 左移一点
        [button setContentEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        // 当push的时候, 隐藏TabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
    
}

#pragma mark - 监听
/**
 *  返回上一层控制器
 */
- (void)back
{
    [self popViewControllerAnimated:YES];
}

#pragma mark - UIGestureRecognizerDelegate
/**
 *  决定手势何时生效
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 导航控制器的子控制器数量大于1, 即不是根控制器的时候, 手势生效
    return self.childViewControllers.count > 1;
}

@end
