//
//  XYTitleButton.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/8.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYTitleButton.h"

@implementation XYTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

/**
 *  取消高亮下的默认操作
 */
- (void)setHighlighted:(BOOL)highlighted
{
    
}

@end
