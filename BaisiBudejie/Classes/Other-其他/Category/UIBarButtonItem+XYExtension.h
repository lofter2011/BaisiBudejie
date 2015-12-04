//
//  UIBarButtonItem+XYExtension.h
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/4.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (XYExtension)

/**
 *  返回一个初始化好的ItemBarButtonItem
 */
+ (instancetype)xy_itemWithImage:(NSString *)imageName highlightedImage:(NSString *)highlightedImageName target:(id)target action:(SEL)action;

@end
