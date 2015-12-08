//
//  XYSettingCell.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/8.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYSettingCell.h"

@interface XYSettingCell ()

@property (nonatomic, weak) UISlider *sliderView;
@end

@implementation XYSettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UISlider *sliderView = [[UISlider alloc] init];
        self.sliderView = sliderView;
        [self.contentView addSubview:sliderView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.sliderView.xy_x = self.xy_width * 0.5;
}

@end
