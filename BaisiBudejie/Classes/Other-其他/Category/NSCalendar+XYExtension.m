//
//  NSCalendar+XYExtension.m
//  日期操作
//
//  Created by 韩啸宇 on 15/12/10.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "NSCalendar+XYExtension.h"

@implementation NSCalendar (XYExtension)

+ (instancetype)xy_calendar
{
    // iOS8之前和之后采取不同的创建方法
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    } else {
        return [NSCalendar currentCalendar];
    }
}
@end
