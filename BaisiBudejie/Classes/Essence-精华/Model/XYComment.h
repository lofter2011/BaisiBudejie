//
//  XYComment.h
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/13.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XYUser;

@interface XYComment : NSObject

/** 评论内容 */
@property (nonatomic, copy) NSString *content;

/** 发表这条评论的用户 */
@property (nonatomic, strong) XYUser *user;

/** 被点赞数 */
@property (nonatomic, assign) NSInteger like_count;

@end
