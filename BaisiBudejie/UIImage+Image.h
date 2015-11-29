//
//  UIImage+Image.h
//  工具分类
//
//  Created by 韩啸宇 on 15/10/8.
//  Copyright (c) 2015年 韩啸宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)

/** 返回一张未经渲染的原始图片 */
+ (UIImage *)imageWithOriginalImageName:(NSString *)imageName;

/** 从URL地址获取图片 */
+ (UIImage *)imageWithUrlPath:(NSString *)urlPath;
@end
