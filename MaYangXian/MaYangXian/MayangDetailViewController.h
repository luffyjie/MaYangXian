//
//  MayangDetailViewController.h
//  MaYangXian
//
//  Created by lujie on 14-7-27.
//  Copyright (c) 2014年 LuJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"

@interface MayangDetailViewController : UIViewController <UITextViewDelegate>
@property (nonatomic, strong) Article *article;

@end
