//
//  Town.m
//  MaYangXian
//
//  Created by lujie on 14-7-27.
//  Copyright (c) 2014年 LuJie. All rights reserved.
//

#import "Town.h"

@implementation Town

// 在这里对数组进行初始化
- (instancetype)init
{
    self = [super init];
    if (self) {
        _articleList = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark 重写set方法
- (void)setArticleList:(NSMutableArray *)articleList
{
    if (_articleList != articleList) {
        _articleList = [articleList mutableCopy];
    }
}

@end
