//
//  XYQuickLoginButton.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/4.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYQuickLoginButton.h"

@implementation XYQuickLoginButton

- (void)awakeFromNib
{
    [self setUpSubviews];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUpSubviews];
    }
    return self;
}

/**
 *  进行一些初始化设置
 */
- (void)setUpSubviews
{
    // titleLabel文字居中显示
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.xy_y = 0;
    self.imageView.xy_centerX = self.xy_width * 0.5;

    self.titleLabel.xy_x = 0;
    self.titleLabel.xy_y = self.imageView.xy_height;
    self.titleLabel.xy_height = self.xy_height - self.titleLabel.xy_y;
    self.titleLabel.xy_width = self.xy_width;
}

@end
