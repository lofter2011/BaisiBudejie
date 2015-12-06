//
//  UIImage+Image.m
//  工具分类
//
//  Created by 韩啸宇 on 15/10/8.
//  Copyright (c) 2015年 韩啸宇. All rights reserved.
//

#import "UIImage+XYExtension.h"

@implementation UIImage (XYExtension)

/**
 *  返回一张未经渲染的图片
 */
+ (UIImage *)imageWithOriginalImageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

/**
 *  获得一张圆形图片
 */
- (instancetype)circleImage
{
    // 开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    
    // 设置剪裁区域
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    [path addClip];
    
    // 原始图片绘制到图形上下文
    [self drawAtPoint:CGPointZero];
    
    // 从上下文生成一张新的图片
    UIImage *circleImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return circleImage;
}

+ (instancetype)circleImageNamed:(NSString *)name
{
    return [[UIImage imageNamed:name] circleImage];
}

@end
