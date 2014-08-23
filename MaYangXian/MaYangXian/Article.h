//
//  Article.h
//  MaYangXian
//
//  Created by lujie on 14-7-27.
//  Copyright (c) 2014年 LuJie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) UIImage *thumbnailImage;
@property (nonatomic, strong) NSMutableArray *imageList;

@end
