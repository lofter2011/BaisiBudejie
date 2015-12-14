//
//  XYTopic.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/9.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYTopic.h"
#import "XYComment.h"
#import "XYUser.h"

@implementation XYTopic

#pragma mark - 模型属性处理
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

- (CGFloat)cellHeight
{
    // 如果_cellHeight值非0(已经算过), 直接返回
    if (_cellHeight) return _cellHeight;
    
    // 1.头像
    _cellHeight = XYCommonMargin; // 头像到顶部间距
    _cellHeight += 35; // 头像高度
    _cellHeight += XYCommonMargin; // 头像到文字内容间距
    
    // 2.文字内容
    CGSize textSize = CGSizeMake(screenW - 2 * XYCommonMargin, MAXFLOAT);
    CGFloat textH = [self.text boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
    _cellHeight += textH; // 文字内容高度
    _cellHeight += XYCommonMargin; // 文字内容到中间内容的间距
    
    // 3.中间图片内容高度
    if (self.type != XYTopicTypeWord) {
        
        CGFloat pictureW = screenW - 2 * XYCommonMargin; // 图片显示宽度
        CGFloat scale = pictureW / self.width; // 图片缩放比例
        CGFloat pictureH = self.height * scale; // 图片显示高度
        pictureH = pictureH > screenH ? 200 : pictureH;
        
        self.pictureFrame = CGRectMake(XYCommonMargin, _cellHeight, pictureW, pictureH);
        
        _cellHeight += pictureH; // 显示图片高度
        _cellHeight += XYCommonMargin; // 中间图片内容到最热评论间距
    }

    
    // 4.最热评论
    if (self.top_cmt) { // 有最热评论加上最热评论高度
        
        // 最热评论内容高度
        NSString *content = [NSString stringWithFormat:@"%@：%@", self.top_cmt.user.username, self.top_cmt.content];
        CGFloat contentH = [content boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:0].size.height;
        
        _cellHeight += 20; // 最热评论标题高度
        _cellHeight += contentH; // 最热评论内容高度
        _cellHeight += XYCommonMargin; // 最热评论到底部工具条间距
    }
    
    // 5.底部工具条
    _cellHeight += 35;
    
    // 6.最后空出的表格间距
    _cellHeight += XYCommonMargin;
    
    return _cellHeight;
}
@end
