//
//  XYLoginRegisterTextField.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/4.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYLoginRegisterTextField.h"
#import "UITextField+XYExtension.h"

@interface XYLoginRegisterTextField ()

@end

@implementation XYLoginRegisterTextField

- (void)awakeFromNib
{
    [self setUpAttribute];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        [self setUpAttribute];
    }
    return self;
}

/**
 *  初始化属性
 */
- (void)setUpAttribute
{
    // 边框风格
    self.borderStyle = UITextBorderStyleNone;
    
    // 设置字体
    self.font = [UIFont systemFontOfSize:18];

    // 设置文字颜色
    self.textColor = [UIColor whiteColor];
    
    // 设置光标颜色
    self.tintColor = self.textColor;
    
    // 设置占位文字颜色
    self.xy_placeholderColor = [UIColor yellowColor];
}
@end
