//
//  UIImageView+XYExtension.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/9.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "UIImageView+XYExtension.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (XYExtension)

/**
 *  从URL加载头像，未获取加载占位头像
 *
 *  @param url                  图像URL地址
 *  @param placeholderImageName 本地占位图像名
 */
- (void)xy_setHeader:(NSString *)url placeholderImageName:(NSString *)placeholderImageName
{
    UIImage *placeholder = nil;
    // 展位图像存在才剪裁成圆形
    if (placeholderImageName.length > 0) placeholder = [UIImage xy_circleImageNamed:placeholderImageName];

    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 如果没获取到头像图像，直接返回
        if (!image) return;
        
        self.image = [self.image xy_circleImage];
    }];
}

@end
