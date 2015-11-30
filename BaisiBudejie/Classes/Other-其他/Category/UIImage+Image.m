//
//  UIImage+Image.m
//  工具分类
//
//  Created by 韩啸宇 on 15/10/8.
//  Copyright (c) 2015年 韩啸宇. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)

// 返回一张未经渲染的图片
+ (UIImage *)imageWithOriginalImageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

// 从URL地址获取图片
+ (UIImage *)imageWithUrlPath:(NSString *)urlPath
{
    NSURL *url = [NSURL URLWithString:urlPath];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    
    return image;
}
@end
