//
//  XYMeCell.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/6.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYMeCell.h"

@implementation XYMeCell
#pragma mark - 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    return self;
}

#pragma mark - 布局
/**
 *  重写setFrame让cell之间有间隔
 */
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= XYCommonMargin;
    
    [super setFrame:frame];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 没图就没必要重排布了
    if (!self.imageView.image) return;
    
    // 重新排布图片
    self.imageView.xy_y = XYCommonMargin * 0.5;
    self.imageView.xy_height = self.xy_height - 2 * self.imageView.xy_y;
    self.imageView.xy_width = self.imageView.xy_height;

    // 重新排布文字
    self.textLabel.xy_x = CGRectGetMaxX(self.imageView.frame) + XYCommonMargin;
}
@end
