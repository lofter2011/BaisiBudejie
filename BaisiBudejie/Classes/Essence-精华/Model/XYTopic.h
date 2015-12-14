//
//  XYTopic.h
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/9.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, XYTopicType) {
    /** 图片 */
    XYTopicTypePicture = 10,
    /** 段子 */
    XYTopicTypeWord = 29,
    /** 音频 */
    XYTopicTypeAudio = 31,
    /** 视频 */
    XYTopicTypeVideo = 41
};

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
/** 帖子类型 */
@property (nonatomic, assign) XYTopicType type;

/** 图片宽度 */
@property (nonatomic, assign) NSInteger width;
/** 图片高度 */
@property (nonatomic, assign) NSInteger height;
/** 小图 */
@property (nonatomic, copy) NSString *small_image;
/** 中图 */
@property (nonatomic, copy) NSString *middle_image;
/** 大图 */
@property (nonatomic, copy) NSString *large_image;
/** 是否为动态图片 */
@property (nonatomic, assign) BOOL is_gif;

/********** 额外属性 **********/

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
/** 中间图片内容的frame */
@property (nonatomic, assign) CGRect pictureFrame;
@end
