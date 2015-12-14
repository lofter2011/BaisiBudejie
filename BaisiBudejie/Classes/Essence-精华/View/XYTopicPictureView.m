//
//  XYTopicPictureView.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/14.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYTopicPictureView.h"
#import <UIImageView+WebCache.h>
#import "XYTopic.h"

@interface XYTopicPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@end

@implementation XYTopicPictureView

- (void)awakeFromNib
{
    self.autoresizingMask = NO;
}

- (void)setTopic:(XYTopic *)topic
{
    _topic = topic;
    
    // 显示图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    // gif标识
    self.gifView.hidden = !topic.is_gif;
}

@end
