//
//  UIImageView+XYExtension.h
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/9.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (XYExtension)

/** 从URL加载头像，未获取加载占位头像 */
- (void)xy_setHeader:(NSString *)url placeholderImageName:(NSString *)placeholderImageName;
@end
