//
//  XYLoginRegisterViewController.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/4.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYLoginRegisterViewController.h"

@interface XYLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;

@end

@implementation XYLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

/**
 *  设置为亮色状态栏
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - 监听

/**
 *  关闭注册界面
 */
- (IBAction)close:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showLoginOrRegister:(UIButton *)button {
    
    // 按钮文字依靠切换状态来改变
    button.selected = !button.isSelected;
    
    // 退出编辑
    [self.view endEditing:YES];
    
    // 修改约束值
    self.leftMargin.constant = self.leftMargin.constant ? 0 : -screenW;

    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        // 执行layoutIfNeeded来做约束动画
        [weakSelf.view layoutIfNeeded];
    }];
    
}



@end
