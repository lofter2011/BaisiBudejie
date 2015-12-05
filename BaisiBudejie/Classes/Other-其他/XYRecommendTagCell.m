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

- (void)setFrame:(CGRect)frame
{
    frame.size.height--;
    [super setFrame:frame];
}

- (void)setRecommendTag:(XYRecommendTag *)recommendTag
{
    _recommendTag = recommendTag;
    
    UIImage *placeholder = [UIImage imageNamed:@"defaultUserIcon"];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
       // 剪裁圆角图片
    }];
    
    self.themeNameLabel.text = recommendTag.theme_name;
    self.subNumberLabel.text = [NSString stringWithFormat:@"%zd人订阅", recommendTag.sub_number];
}

@end
