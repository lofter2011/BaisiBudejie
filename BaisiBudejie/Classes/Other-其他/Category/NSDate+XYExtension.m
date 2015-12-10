//
//  NSDate+XYExtension.m
//  日期操作
//
//  Created by 韩啸宇 on 15/12/10.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "NSDate+XYExtension.h"
#import "NSCalendar+XYExtension.h"

static int const secondPerMinute = 60;
static int const secondPerHour = 60 * 60;
static int const secondPerDay = 60 * 60 * 24;

@implementation XYDateItem

- (NSString *)description
{
    return [NSString stringWithFormat:@"%zd天%zd小时%zd分%zd秒", self.day, self.hour, self.minute, self.second];
}
@end

@implementation NSDate (XYExtension)

/** 快速获取时间间隔 */
- (XYDateItem *)xy_timeIntervalSinceDate:(NSDate *)date
{
    // self和date的时间间隔
    NSTimeInterval interval = [self timeIntervalSinceDate:date];
    // 转成整型
    int intInterval = interval;
    
    XYDateItem *item = [[XYDateItem alloc] init];
    
    item.day = intInterval / secondPerDay;
    item.hour = (intInterval % secondPerDay) / secondPerHour;
    item.minute = ((intInterval % secondPerDay) % secondPerHour) / secondPerMinute;
    item.second = ((intInterval % secondPerDay) % secondPerHour) % secondPerMinute;
    
    return item;
}

#pragma mark - 今年/昨天/今天/明天
/** 是不是今年 */
- (BOOL)xy_isThisYear
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy";
    
    NSString *selfString = [fmt stringFromDate:self];
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    
    return [selfString isEqualToString:nowString];
}

/** 是不是今天 */
- (BOOL)xy_isToday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyyMMdd";
    
    NSString *selfString = [fmt stringFromDate:self];
    NSString *nowString = [fmt stringFromDate:[NSDate date]];

    return [selfString isEqualToString:nowString];
}

/** 是不是昨天 */
- (BOOL)xy_isYesterday
{
    NSDateFormatter  *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyyMMdd";

    // 生成只有年月日的字符串
    NSString *selfString = [fmt stringFromDate:self];
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    
    // 生成只有年月日的日期对象
    NSDate *selfDate = [fmt dateFromString:selfString];
    NSDate *nowDate = [fmt dateFromString:nowString];
    
    NSCalendar *calendar = [NSCalendar xy_calendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == 1;
}

/** 是不是明天 */
- (BOOL)xy_isTomorrow
{
    NSDateFormatter  *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyyMMdd";
    
    // 生成只有年月日的字符串
    NSString *selfString = [fmt stringFromDate:self];
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    
    // 生成只有年月日的日期对象
    NSDate *selfDate = [fmt dateFromString:selfString];
    NSDate *nowDate = [fmt dateFromString:nowString];
    
    NSCalendar *calendar = [NSCalendar xy_calendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == -1;
}
@end
