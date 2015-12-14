//
//  XYUser.h
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/13.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYUser : NSObject

/** 用户名 */
@property (nonatomic, copy) NSString *username;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 性别 */
@property (nonatomic, copy) NSString *sex;

@end
