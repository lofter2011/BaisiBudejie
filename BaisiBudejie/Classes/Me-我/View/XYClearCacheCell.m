//
//  XYClearCacheCell.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/8.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYClearCacheCell.h"
#import <SVProgressHUD.h>

// Library/Caches路径
#define cacheRootPath NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject
// 所有缓存文件夹全路径
#define cachePath_SDWebImage [cacheRootPath stringByAppendingPathComponent:@"default"]
#define cachePath_MyCache [cacheRootPath stringByAppendingPathComponent:@"MyCaches"]

@implementation XYClearCacheCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 占位文字
        self.textLabel.text = @"正在计算缓存大小...";

        // 右边进度指示器
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityView startAnimating];
        self.accessoryView = activityView;
        
        // 添加手势
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearCache)]];
        
        // 子线程中计算缓存大小
        XYWeakSelf
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [NSThread sleepForTimeInterval:7]; // 模拟延迟
            
            // 获取文件大小信息
            NSString *cachesFileSizeText = [self getCachesFileSizeText];
            
            // 如果cell此时销毁，那就没进行下去的必要了
            if (weakSelf == nil) return ;
            
            // 回到主线程设置文字
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.textLabel.text = [NSString stringWithFormat:@"清除缓存(%@)", cachesFileSizeText];
                weakSelf.accessoryView = nil;
                weakSelf.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            });
        });
    }
    return self;
}

/**
 *  布局子控件，cell会在添加到窗口显示之前调用这个方法
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIActivityIndicatorView *activityView = (UIActivityIndicatorView *)self.accessoryView;
    
    // 菊花移出窗口后动画就停止了
    [activityView startAnimating];
    
}

#pragma mark - 缓存相关操作
/**
 *  获取缓存大小，格式化成字符串
 */
- (NSString *)getCachesFileSizeText
{
    // 所有缓存总大小
    unsigned long long cachesFileSize = cachePath_SDWebImage.xy_fileSize + cachePath_MyCache.xy_fileSize;
    
    // 文件大小的字符串
    NSString *cachesFileSizeText = nil;
    if (cachesFileSize > pow(10, 9)) {
        cachesFileSizeText = [NSString stringWithFormat:@"%.1fGB", cachesFileSize / pow(10, 9)];
    } else if (cachesFileSize > pow(10, 6)) {
        cachesFileSizeText = [NSString stringWithFormat:@"%.1fMB", cachesFileSize / pow(10, 6)];
    } else if (cachesFileSize > pow(10, 3)) {
        cachesFileSizeText = [NSString stringWithFormat:@"%.1fKB", cachesFileSize / pow(10, 3)];
    } else {
        cachesFileSizeText = [NSString stringWithFormat:@"%zdB", cachesFileSize];
    }
    
    return cachesFileSizeText;
}

/**
 *  清理缓存
 */
- (void)clearCache
{
    if (self.accessoryView) return;

    // 显示蒙版
    [SVProgressHUD showWithStatus:@"正在清除缓存" maskType:SVProgressHUDMaskTypeBlack];
    
    // 子线程中清除缓存
    XYWeakSelf
    dispatch_async(dispatch_get_global_queue(0, 0), ^{

        NSFileManager *manager = [NSFileManager defaultManager];

//        [NSThread sleepForTimeInterval:3]; // 模拟延迟
        // 删除缓存内容, 创建缓存文件夹
        [manager removeItemAtPath:cachePath_MyCache error:nil];
        [manager removeItemAtPath:cachePath_SDWebImage error:nil];
        [manager createDirectoryAtPath:cachePath_MyCache withIntermediateDirectories:YES attributes:nil error:nil];
        
        // 回到主线程刷新文字
        dispatch_async(dispatch_get_main_queue(), ^{

            // 移除蒙版
            [SVProgressHUD showSuccessWithStatus:@"清除成功" maskType:SVProgressHUDMaskTypeBlack];
            
            // 刷新文字
            weakSelf.textLabel.text = @"清除缓存(0B)";
        });
    });
    
}

@end
