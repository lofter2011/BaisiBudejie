//
//  UITextField+XYExtension.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/5.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "UITextField+XYExtension.h"

static NSString * const XYPlaceholderColorKey = @"placeholderLabel.textColor";

@implementation UITextField (XYExtension)

/**
 *  设置占位文字颜色
 */
- (void)setXy_placeholderColor:(UIColor *)xy_placeholderColor
{
    // 为了保证懒加载能创建出placeholderLabel, 而且不改变placeholder内容
    NSString *placeholder = self.placeholder;
    self.placeholder = @"PlaceholderLabel Lazy Init";
    self.placeholder = placeholder;
    
    // 如果传进来的颜色为空, 那就用系统的默认颜色
    if (!xy_placeholderColor) {
        xy_placeholderColor = [UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22];
    }
    
    [self setValue:xy_placeholderColor forKeyPath:XYPlaceholderColorKey];
}

/**
 *  获取占位文字颜色
 */
- (UIColor *)xy_placeholderColor
{
    return [self valueForKeyPath:XYPlaceholderColorKey];
}

@end
