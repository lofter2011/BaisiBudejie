//
//  UIView+Frame.h
//  工具分类
//
//  Created by 韩啸宇 on 15/10/8.
//  Copyright (c) 2015年 韩啸宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
/** size的get/set方法声明 */
@property (nonatomic, assign) CGSize xy_size;

/** 中心点X的get/set方法声明 */
@property (nonatomic, assign) CGFloat xy_centerX;
/** 中心点Y的get/set方法声明 */
@property (nonatomic, assign) CGFloat xy_centerY;

/** X的get/set方法声明 */
@property (nonatomic, assign) CGFloat xy_x;
/** Y的get/set方法声明 */
@property (nonatomic, assign) CGFloat xy_y;
/** Widhth的get/set方法声明 */
@property (nonatomic, assign) CGFloat xy_width;
/** Height的get/set方法声明 */
@property (nonatomic, assign) CGFloat xy_height;
@end
