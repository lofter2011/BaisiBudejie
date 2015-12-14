//
//  MJExtensionConfig.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/13.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "MJExtensionConfig.h"
#import "XYTopic.h"
#import <MJExtension.h>

@implementation MJExtensionConfig

+ (void)load
{
    [XYTopic mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"top_cmt" : @"top_cmt[0]"
                 };
    }];
}

@end
