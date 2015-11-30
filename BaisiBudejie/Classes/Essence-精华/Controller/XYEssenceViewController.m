//
//  XYEssenceViewController.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/11/30.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYEssenceViewController.h"

@interface XYEssenceViewController ()

@end

@implementation XYEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = XYCommonBgColor;
    
    // NavigationItem标题视图
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
}


@end
