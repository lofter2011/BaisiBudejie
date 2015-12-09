//
//  XYTopicCell.h
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/9.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYTopic;

@interface XYTopicCell : UITableViewCell

/** 帖子模型 */
@property (nonatomic, strong) XYTopic *topic;

@end
