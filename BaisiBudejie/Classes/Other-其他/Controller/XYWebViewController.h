//
//  XYWebViewController.h
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/7.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYWebViewController : UIViewController

/** 需要跳转的URL */
@property (nonatomic, strong) NSString *urlPath;

- (instancetype)initWithURLPath:(NSString *)urlPath;
@end
