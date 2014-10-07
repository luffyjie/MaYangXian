//
//  MayangAboutViewController.m
//  MaYangXian
//
//  Created by lujie on 14-7-31.
//  Copyright (c) 2014年 LuJie. All rights reserved.
//

#import "MayangAboutViewController.h"
#import <ShareSDK/ShareSDK.h>

@interface MayangAboutViewController ()
@property (weak, nonatomic) IBOutlet UITextView *aboutView;

@end

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation MayangAboutViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    
    UILabel *navtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [navtitleLabel setTextColor:[UIColor whiteColor]];
    navtitleLabel.textAlignment = NSTextAlignmentCenter;
    [navtitleLabel setText:@"关于风情麻阳"];
    navtitleLabel.font = [UIFont boldSystemFontOfSize:17];
    self.navigationItem.titleView = navtitleLabel;
    
    [self.aboutView setBackgroundColor: [UIColor clearColor]];
    [self.aboutView setDelegate:self];
    [self.aboutView setEditable:YES];
    
    self.aboutView.showsVerticalScrollIndicator = NO;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineHeightMultiple = 10.f;
    paragraphStyle.maximumLineHeight = 20.f;
    paragraphStyle.minimumLineHeight = 15.f;
    paragraphStyle.firstLineHeadIndent = 10.f;
    paragraphStyle.paragraphSpacing = 5.f;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:13], NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName:[UIColor blackColor]};
    NSString *about = @"风情麻阳 (版本1.3)\n开发目的及数据来源：\n全部来自互联网，麻阳政府门户网站。出于自己兴趣爱好，目的介绍宣传自己的家乡，详细介绍了各个乡镇特色，是了解麻阳的最佳应用。也是麻阳自助游的最佳应用。\n本软件开发者：路杰 \n个人简介：05年毕业于麻阳民族中学，12年毕业于中南民族大学 曾在同花顺，唯品会工作，目前是一名软件工程师。\n联系方式：lujie2012@163.com \n最后感谢我的家人 感谢分享麻阳相关资料的朋友";
    self.aboutView .attributedText = [[NSAttributedString alloc]initWithString: about attributes:attributes];
    self.aboutView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
}

- (IBAction)doneButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^(void){
        
    }];
}

- (IBAction)shareButton:(id)sender {
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK"  ofType:@"jpg"];
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"分享内容"
                                       defaultContent:@"默认分享内容，没内容时显示"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"ShareSDK"
                                                  url:@"http://www.sharesdk.cn"
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK showShareActionSheet:nil
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions: nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                }
                            }];
}


-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return NO;
}


@end
