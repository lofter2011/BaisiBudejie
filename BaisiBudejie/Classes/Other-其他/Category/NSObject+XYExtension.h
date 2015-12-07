//
//  NSObject+XYExtension.h
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/5.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (XYExtension)

/** 查看一个对象所属类中定义的成员变量 */
- (void)xy_checkClass;

/** 查看一个类中定义的成员变量 */
+ (void)xy_checkClass;
@end
