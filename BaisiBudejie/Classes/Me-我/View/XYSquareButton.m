//
//  XYSquareButton.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/7.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYSquareButton.h"
#import <UIButton+WebCache.h>
#import "XYSquare.h"

@implementation XYSquareButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.xy_width = self.xy_width * 0.5;
    self.imageView.xy_height = self.xy_width * 0.5;
    self.imageView.xy_centerX = self.xy_width * 0.5;
    self.imageView.xy_y = XYCommonMargin;
    
    self.titleLabel.xy_x = 0;
    self.titleLabel.xy_y = CGRectGetMaxY(self.imageView.frame) + XYCommonMargin;
    self.titleLabel.xy_width = self.xy_width;
    self.titleLabel.xy_height = self.xy_height - self.imageView.xy_height - 3 * XYCommonMargin;
    
}

- (void)setSquare:(XYSquare *)square
{
    _square = square;

    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"setup-head-default"]];
    [self setTitle:square.name forState:UIControlStateNormal];
    
}

@end
