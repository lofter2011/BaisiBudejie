//
//  XYHTTPSessionManager.h
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/5.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface XYHTTPSessionManager : AFHTTPSessionManager

- (instancetype)initWithBaseURL:(NSURL *)url sessionConfiguration:(NSURLSessionConfiguration *)configuration;

@end
