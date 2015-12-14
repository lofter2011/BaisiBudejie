//
//  XYTopic.h
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/9.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XYComment;

@interface XYTopic : NSObject
/** 用户的名字 */
@property (nonatomic, strong) NSString *name;
/** 用户的头像 */
@property (nonatomic, strong) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, strong) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, strong) NSString *created_at;
/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;
/** 最热评论(通过MJExtension框架进行操作) */
@property (nonatomic, strong) XYComment *top_cmt;
@end
