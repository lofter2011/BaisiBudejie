//
//  UIView+Frame.m
//  工具分类
//
//  Created by 韩啸宇 on 15/10/8.
//  Copyright (c) 2015年 韩啸宇. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
#pragma mark - size
// size的get/set方法实现
- (void)setXy_size:(CGSize)xy_size
{
    CGRect bounds = self.bounds;
    
    bounds.size = xy_size;
    
    self.bounds = bounds;
}
- (CGSize)xy_size
{
    return self.bounds.size;
}

#pragma mark - 中心点x,y
// centerX的get/set方法实现
- (void)setXy_centerX:(CGFloat)xy_centerX
{
    CGPoint center = self.center;
    center.x = xy_centerX;
    self.center = center;
}

- (CGFloat)xy_centerX
{
    return self.center.x;
}

// centerY的get/set方法实现
- (void)setXy_centerY:(CGFloat)xy_centerY
{
    CGPoint center = self.center;
    center.y = xy_centerY;
    self.center = center;
}

- (CGFloat)xy_centerY
{
    return self.center.y;
}

#pragma mark - x,y,width,height
// x的get/set方法实现
- (void)setXy_x:(CGFloat)xy_x
{
    CGRect frame = self.frame;

    frame.origin.x = xy_x;
    
    self.frame = frame;
}
- (CGFloat)xy_x
{
    return self.frame.origin.x;
}

// y的get/set方法实现
- (void)setXy_y:(CGFloat)xy_y
{
    CGRect frame = self.frame;
    
    frame.origin.y = xy_y;
    
    self.frame = frame;
}

- (CGFloat)xy_y
{
    return self.frame.origin.y;
}

// width的get/set方法实现
- (void)setXy_width:(CGFloat)xy_width
{
    CGRect bounds = self.frame;
    
    bounds.size.width = xy_width;
    
    self.bounds = bounds;
}

- (CGFloat)xy_width
{
    return self.bounds.size.width;
}

// height的get/set方法实现
- (void)setXy_height:(CGFloat)xy_height
{
    CGRect bounds = self.frame;
    
    bounds.size.height = xy_height;
    
    self.bounds = bounds;
}

- (CGFloat)xy_height
{
    return self.bounds.size.height;
}

@end
