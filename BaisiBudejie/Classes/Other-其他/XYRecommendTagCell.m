//
//  XYRecommendTagCell.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/6.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYRecommendTagCell.h"
#import "XYRecommendTag.h"
#import <UIImageView+WebCache.h>

@interface XYRecommendTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageListView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;

@end

@implementation XYRecommendTagCell

- (void)awakeFromNib {

}

/**
 *  拦截所有frame, 设置一个间隔
 */
- (void)setFrame:(CGRect)frame
{
    frame.size.height--;
    [super setFrame:frame];
}

- (void)setRecommendTag:(XYRecommendTag *)recommendTag
{
    _recommendTag = recommendTag;
    
    // 设置图片(圆形图片)
    UIImage *placeholder = [UIImage circleImageNamed:@"defaultUserIcon"];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) return;
        // 将图片处理成圆形
        self.imageView.image = [image circleImage];
    }];
    
    self.themeNameLabel.text = recommendTag.theme_name;

    if (recommendTag.sub_number > 10000) {
        self.subNumberLabel.text = [NSString stringWithFormat:@"%.1f万人订阅", recommendTag.sub_number / 10000.0];
    } else {
        self.subNumberLabel.text = [NSString stringWithFormat:@"%zd人订阅", recommendTag.sub_number];
    }
    
}

@end
