//
//  NSDate+XYExtension.h
//  日期操作
//
//  Created by 韩啸宇 on 15/12/10.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYDateItem : NSObject
@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) NSInteger hour;
@property (nonatomic, assign) NSInteger minute;
@property (nonatomic, assign) NSInteger second;
@end

@interface NSDate (XYExtension)
/** 快速获取时间间隔 */
- (XYDateItem *)xy_timeIntervalSinceDate:(NSDate *)date;

/** 是不是今年 */
- (BOOL)xy_isThisYear;
/** 是不是今天 */
- (BOOL)xy_isToday;
/** 是不是昨天 */
- (BOOL)xy_isYesterday;
/** 是不是明天 */
- (BOOL)xy_isTomorrow;
@end
