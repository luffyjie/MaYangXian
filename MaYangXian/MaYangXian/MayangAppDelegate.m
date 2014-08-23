//
//  MayangAppDelegate.m
//  MaYangXian
//
//  Created by lujie on 14-7-27.
//  Copyright (c) 2014年 LuJie. All rights reserved.
//

#import "MayangAppDelegate.h"
#import "MobClick.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation MayangAppDelegate

{
    UIImageView *welcomeImage;
    UIButton *welcomeBtn;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    //显示window 为了显示程序欢迎界面
    [self.window makeKeyAndVisible];
    
    //程序欢迎图片
    welcomeImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"welcome"]];
    welcomeImage.frame = CGRectMake(0, 0,self.window.bounds.size.width, self.window.bounds.size.height);
    //very good 用于屏蔽当前自己的点击事件,防止下层视图会响屏幕的点击
    welcomeImage.userInteractionEnabled = YES;
    
    //点击进入按钮
    welcomeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.window.bounds.size.width-140, self.window.bounds.size.height-80,131, 33)];
    [welcomeBtn setBackgroundImage:[UIImage imageNamed:@"welcomebtn"] forState:UIControlStateNormal];
    [welcomeBtn addTarget:self action:@selector(welcomeBtn:) forControlEvents:UIControlEventTouchDown];
    welcomeBtn.alpha = 0.0f;
   
    [self.window  addSubview:welcomeImage];
    [self.window  addSubview:welcomeBtn];
    
    //点击按钮淡入的动画效果
    welcomeBtn.alpha = 0.0f;
    [UIView beginAnimations:@"fadeIn" context:nil];
    [UIView setAnimationDuration: 2.f];
    welcomeBtn.alpha = 1.0f;
    [UIView commitAnimations];
    
    //设置全局的导航栏的颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//    [[UINavigationBar appearance] setBarStyle: UIBarStyleBlackOpaque];
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x00561f)];
    // 设置文本的属性
    NSDictionary *barAttributes = @{ NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
                                  NSForegroundColorAttributeName:[UIColor whiteColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:barAttributes];
    
    //友盟统计SDK
    [MobClick startWithAppkey:@"53f76a8cfd98c585f200ca45" reportPolicy:BATCH channelId:@"appStore"];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark welcomeBtn select

- (void)welcomeBtn:(id)sender
{
    //点击进入按钮后 图片和按钮的 淡出动画效果
    welcomeBtn.alpha = 1.0f;
    [UIView beginAnimations:@"fadeIn" context:nil];
    [UIView setAnimationDuration: 1.0f];
    welcomeBtn.alpha = 0.0f;
    [UIView commitAnimations];
    
    welcomeImage.alpha = 1.0f;
    [UIView beginAnimations:@"fadeIn" context:nil];
    [UIView setAnimationDuration: 1.5f];
    welcomeImage.alpha = 0.0f;
    [UIView commitAnimations];
    
}

@end
