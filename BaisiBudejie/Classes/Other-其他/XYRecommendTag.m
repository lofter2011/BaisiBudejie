//
//  XYRecommendTag.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/5.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYRecommendTag.h"

@implementation XYRecommendTag

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@, %@, %@", self.image_list, self.theme_name, self.sub_number];
}
@end
