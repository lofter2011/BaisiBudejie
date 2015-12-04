//
//  UIBarButtonItem+XYExtension.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/4.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "UIBarButtonItem+XYExtension.h"

@implementation UIBarButtonItem (XYExtension)

/**
 *  返回一个初始化好的ItemBarButtonItem
 */
+ (instancetype)xy_itemWithImage:(NSString *)imageName highlightedImage:(NSString *)highlightedImageName target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    
    return [[self alloc] initWithCustomView:button];
}

@end
