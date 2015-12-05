//
//  NSObject+XYExtension.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/5.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "NSObject+XYExtension.h"
#import <objc/message.h>

@implementation NSObject (XYExtension)

// 查看一个对象所属类中的成员变量
- (void)checkClass
{
    [[self class] checkClass];
}

// 查看一个类中的成员变量
+ (void)checkClass
{
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList([self class], &count);
    NSLog(@"********** Begin **********");
    for (NSInteger i = 0; i < count; i++)
    {
        Ivar ivar = ivarList[i];
        NSLog(@"%s", ivar_getName(ivar));
    }
    NSLog(@"**********  End  **********");
    free(ivarList);
}

@end
