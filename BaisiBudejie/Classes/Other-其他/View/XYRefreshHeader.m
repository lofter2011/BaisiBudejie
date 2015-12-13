//
//  XYRefreshHeader.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/13.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYRefreshHeader.h"

@implementation XYRefreshHeader

/**
 *  初始化
 */
- (void)prepare
{
    [super prepare];
    
    [self setTitle:@"下拉加载最新数据" forState:MJRefreshStateIdle];
    [self setTitle:@"加载ing" forState:MJRefreshStateRefreshing];
    
}

/**
 *  摆放子控件
 */
- (void)placeSubviews
{
    [super placeSubviews];
}

@end
