//
//  XYTopicCell.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/9.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYTopicCell.h"
#import <UIImageView+WebCache.h>

#import "XYTopic.h"
#import "XYComment.h"
#import "XYUser.h"

#import "XYTopicVideoView.h"
#import "XYTopicAudioView.h"
#import "XYTopicPictureView.h"

@interface XYTopicCell ()

/** 头像ImageView */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 用户名Label */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 审核通过时间Labe */
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
/** 内容Label */
@property (weak, nonatomic) IBOutlet UILabel *text_label;

/** 最热评论整体 */
@property (weak, nonatomic) IBOutlet UIView *topCommentView;
/** 最热评论内容 */
@property (weak, nonatomic) IBOutlet UILabel *topCommentContentLabel;

/** 顶按钮 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩按钮 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享按钮 */
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
/** 评论按钮 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

/***** 帖子中间内容控件 *****/

/** 视频帖子中间的控件 */
@property (nonatomic, weak) XYTopicVideoView *videoView;
/** 图片帖子中间的控件 */
@property (nonatomic, weak) XYTopicPictureView *pictureView;
/** 声音帖子中间的控件 */
@property (nonatomic, weak) XYTopicAudioView *audioView;

@end


///** 评论数量 */
//@property (nonatomic, assign) NSInteger comment;

@implementation XYTopicCell

- (void)awakeFromNib {
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    switch (self.topic.type) {
            
        case XYTopicTypeVideo:
            self.videoView.frame = self.topic.pictureFrame;
            break;
            
        case XYTopicTypeAudio:
            self.audioView.frame = self.topic.pictureFrame;
            break;
            
        case XYTopicTypePicture:
            self.pictureView.frame = self.topic.pictureFrame;
            break;
            
        default:
            break;
    }

}

#pragma mark - 设置内容
/**
 *  重写setFrame让cell之间有间隔
 */
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= XYCommonMargin;
    
    [super setFrame:frame];
}

/**
 *  根据模型给让cell的子控件显示数据
 */
- (void)setTopic:(XYTopic *)topic
{
    _topic = topic;
    
    // 顶部内容
    [self.profileImageView xy_setHeader:topic.profile_image placeholderImageName:@"setup-head-default"];
    self.nameLabel.text = topic.name;
    self.createdAtLabel.text = topic.created_at;
    self.text_label.text = topic.text;
    
    // 底部工具栏按钮的数字
    [self setTitleForButton:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setTitleForButton:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setTitleForButton:self.repostButton number:topic.repost placeholder:@"分享"];
    [self setTitleForButton:self.commentButton number:topic.comment placeholder:@"评论"];
    
    // 最热评论
    if (topic.top_cmt) {
        self.topCommentView.hidden = NO;
        NSString *username = topic.top_cmt.user.username;
        NSString *content = topic.top_cmt.content;
        self.topCommentContentLabel.text = [NSString stringWithFormat:@"%@：%@", username, content];
    } else {
        self.topCommentView.hidden = YES;
    }
    
    // 中间内容
    switch (topic.type) {
        case XYTopicTypeVideo:
        {
            self.videoView.hidden = NO;
            self.audioView.hidden = YES;
            self.pictureView.hidden = YES;
            
            self.videoView.topic = topic;
            
            break;
        }
        case XYTopicTypeAudio:
        {
            self.videoView.hidden = YES;
            self.audioView.hidden = NO;
            self.pictureView.hidden = YES;
            
            self.audioView.topic = topic;
            
            break;
        }
        case XYTopicTypePicture:
        {
            self.videoView.hidden = YES;
            self.audioView.hidden = YES;
            self.pictureView.hidden = NO;

            self.pictureView.topic = topic;
            
            break;
        }
        case XYTopicTypeWord:
        {
            self.videoView.hidden = YES;
            self.audioView.hidden = YES;
            self.pictureView.hidden = YES;
            
            break;
        }
            
        default:
            break;
    }
}

/**
 *  设置按钮数字
 */
- (void)setTitleForButton:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder
{
    NSString *title;
    if (number >= 10000) {
        title = [NSString stringWithFormat:@"%.1f万", number / 10000.0];
    } else if (number > 0) {
        title = [NSString stringWithFormat:@"%zd", number];
    } else {
        title = placeholder;
    }
    [button setTitle:title forState:UIControlStateNormal];
}

#pragma mark - 懒加载

- (XYTopicVideoView *)videoView
{
    if (!_videoView) {
        XYTopicVideoView *videoView = [XYTopicVideoView xy_viewFromXib];
        _videoView = videoView;
        [self.contentView addSubview:videoView];
    }
    return _videoView;
}

- (XYTopicAudioView *)audioView
{
    if (!_audioView) {
        XYTopicAudioView *audioView = [XYTopicAudioView xy_viewFromXib];
        _audioView = audioView;
        [self.contentView addSubview:audioView];
    }
    return _audioView;
}

- (XYTopicPictureView *)pictureView
{
    if (!_pictureView) {
        XYTopicPictureView *pictureView = [XYTopicPictureView xy_viewFromXib];
        _pictureView = pictureView;
        [self.contentView addSubview:pictureView];
    }
    return _pictureView;
}
@end
