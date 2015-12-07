//
//  NSString+XYExtension.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/7.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "NSString+XYExtension.h"

@implementation NSString (XYExtension)

/**
 *  该路径下文件大小
 */
- (unsigned long long)xy_fileSize
{
    NSFileManager *manager = [NSFileManager defaultManager];

    
    BOOL isDirectory = NO;
    BOOL exists = [manager fileExistsAtPath:self isDirectory:&isDirectory];

    // 路径不存在
    if (!exists) return 0;
    
    // 路径是文件， 计算大小
    if (!isDirectory) return [manager attributesOfItemAtPath:self error:nil].fileSize;
    
    // 路径是文件夹， 遍历计算总大小
    unsigned long long fileSize = 0;
    NSDirectoryEnumerator *enumerator = [manager enumeratorAtPath:self];
    for (NSString *subPath in enumerator) {
        NSString *fullPath = [self stringByAppendingPathComponent:subPath];
        fileSize += [manager attributesOfItemAtPath:fullPath error:nil].fileSize;
    }
    return fileSize;
}

@end
