//
//  XYTopicVideoView.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/14.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYTopicVideoView.h"
#import "XYTopic.h"

@implementation XYTopicVideoView

- (void)awakeFromNib
{
    self.autoresizingMask = NO;
}

- (void)setTopic:(XYTopic *)topic
{
    _topic = topic;
}

@end
