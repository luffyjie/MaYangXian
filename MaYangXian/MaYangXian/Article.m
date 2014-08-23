//
//  Article.m
//  MaYangXian
//
//  Created by lujie on 14-7-27.
//  Copyright (c) 2014年 LuJie. All rights reserved.
//

#import "Article.h"

@implementation Article

- (instancetype)init
{
    self = [super init];
    if (self) {
        _imageList = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void)setImageList:(NSMutableArray *)imageList
{
    if (_imageList != imageList) {
        _imageList =[imageList mutableCopy];
    }
}

@end
