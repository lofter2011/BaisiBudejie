//
//  XYRefreshFooter.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/11.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYRefreshFooter.h"

@implementation XYRefreshFooter

/**
 *  初始化
 */
- (void)prepare
{
    [super prepare];
    
    [self setTitle:@"上拉查看更多" forState:MJRefreshStateIdle];
    [self setTitle:@"刷新ing" forState:MJRefreshStateRefreshing];
}

/**
 *  摆放子控件
 */
- (void)placeSubviews
{
    [super placeSubviews];
}

@end
