//
//  UIColor+RandomColor.m
//  随机颜色
//
//  Created by 韩啸宇 on 15/9/25.
//  Copyright (c) 2015年 韩啸宇. All rights reserved.
//

#import "UIColor+RandomColor.h"

@implementation UIColor (RandomColor)
+ (UIColor *)colorRandom
{
    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}
@end
