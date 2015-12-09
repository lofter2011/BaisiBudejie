//
//  XYTopicCell.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/9.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYTopicCell.h"
#import "XYTopic.h"
#import <UIImageView+WebCache.h>

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


@end


///** 评论数量 */
//@property (nonatomic, assign) NSInteger comment;

@implementation XYTopicCell

- (void)awakeFromNib {
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
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
    [self.profileImageView xy_setHeader:topic.profile_image placeholderImageName:@"setup-head-default"];
    self.nameLabel.text = topic.name;
    self.createdAtLabel.text = topic.created_at;
    self.text_label.text = topic.text;
    
    [self setTitleForButton:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setTitleForButton:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setTitleForButton:self.repostButton number:topic.repost placeholder:@"分享"];
    [self setTitleForButton:self.commentButton number:topic.comment placeholder:@"评论"];
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

@end
