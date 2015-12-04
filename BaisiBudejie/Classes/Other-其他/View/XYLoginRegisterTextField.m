//
//  XYLoginRegisterTextField.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/4.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYLoginRegisterTextField.h"

@interface XYLoginRegisterTextField () <UITextFieldDelegate>

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
    self.delegate = self;
    
    // 边框风格
    self.borderStyle = UITextBorderStyleNone;
    
    // 设置字体
    self.font = [UIFont systemFontOfSize:18];

    // 设置文字颜色
    self.textColor = [UIColor whiteColor];
    
    // 设置光标颜色
    self.tintColor = self.textColor;
}

#pragma mark - UITextFieldDelegate
/**
 *  textField开始编辑时, 让placeholder颜色和字体颜色相同
 */
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    // 设置占位字体(有颜色, 选用富文本)
    if (!self.placeholder.length) return; // 如果没占位文字, 直接返回
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = self.textColor;
    
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attributes];
}

/**
 *  textField结束编辑, 去掉placeholder颜色
 */
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSString *str = self.attributedPlaceholder.string;
    self.attributedPlaceholder = nil;
    self.placeholder = str;
}

@end
