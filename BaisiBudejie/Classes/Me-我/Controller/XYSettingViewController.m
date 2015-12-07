//
//  XYSettingViewController.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/4.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYSettingViewController.h"

@interface XYSettingViewController ()

@end

@implementation XYSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
}

#pragma mark - 缓存文件相关
/**
 *  获取缓存大小字符串
 */
- (NSString *)getCachesFileSizeText
{
    // Library/Caches路径
    NSString *caches = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    
    // 所有缓存文件夹全路径
    NSString *cachePath_SDWebImage = [caches stringByAppendingPathComponent:@"default"];
    NSString *cachePath_MyCache = [caches stringByAppendingPathComponent:@"MyCaches"];
    
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

#pragma mark - 数据源

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *XYSettingCellId = @"setting";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:XYSettingCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:XYSettingCellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = @"正在计算缓存大小...";
    
    // 子线程中计算缓存大小
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *cachesFileSizeText = [self getCachesFileSizeText];

        // 回到主线程设置文字
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.textLabel.text = [NSString stringWithFormat:@"清除缓存(%@)", cachesFileSizeText];
        });
    });
    
    return cell;
}
@end
