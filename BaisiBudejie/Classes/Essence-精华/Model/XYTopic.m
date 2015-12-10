//
//  XYTopic.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/9.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYTopic.h"

@implementation XYTopic

/**
 *  重写create_at的get方法, 对日期进行处理
 */
- (NSString *)created_at
{
    static NSDateFormatter *fmt = nil;
    if (!fmt) {
        fmt = [[NSDateFormatter alloc] init];
    }
    static NSCalendar *calendar = nil;
    if (!calendar) {
        calendar = [NSCalendar xy_calendar];
    }
    
    // 帖子的日期对象
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createdAtDate = [fmt dateFromString:_created_at];

    // 判断处理
    if ([createdAtDate xy_isThisYear]) { // 今年
        if ([createdAtDate xy_isToday]) { // 今天
            NSCalendarUnit unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *cmps = [calendar components:unit fromDate:createdAtDate toDate:[NSDate date] options:0];
            
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute > 1) {
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else {
                return @"刚刚";
            }
            
        } else if ([createdAtDate xy_isYesterday]) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:createdAtDate];
        } else { // 今年其他天
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:createdAtDate];
        }
    } else { // 不是今年
        return _created_at;
    }
    
}

@end
