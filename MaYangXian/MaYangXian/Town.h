//
//  Town.h
//  MaYangXian
//
//  Created by lujie on 14-7-27.
//  Copyright (c) 2014年 LuJie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Town : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *distance;
@property (nonatomic, strong) UIImage *thumbnailImage;
@property (nonatomic, copy) NSMutableArray *articleList;

@end
