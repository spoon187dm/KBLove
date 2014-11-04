//
//  AppDelegate.m
//  KBLove
//
//  Created by block on 14-10-10.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "AppDelegate.h"
#import "ImagePickerTool.h"
#import "QRCodeTool.h"
#import "BMapKit.h"
#import <MAMapKit/MAMapKit.h>
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    

    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    BMKMapManager *_mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"HekPo3DvBn5qiKG3sC3aUpjE"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    [MAMapServices sharedServices].apiKey = @"d0818c7e92d2f86978158044c99fb47b";
    
    // Override point for customization after application launch.
//    KBMessageInfo *msginf=[[KBMessageInfo alloc]init];
//    [[KBDBManager shareManager]insertDataWithModel:msginf];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav_Bacground"] forBarMetrics:UIBarMetricsDefault];
    [[UITableView appearance] setBackgroundColor:SYSTEM_COLOR];
    [[UITableViewCell appearance]setBackgroundColor:[UIColor colorWithRed:0.000 green:0.569 blue:0.588 alpha:1.000]];
    //    [[UIView appearance]setBackgroundColor:SYSTEM_COLOR];
    [[UILabel appearance]setTextColor:[UIColor whiteColor]];
    UIStoryboard *stb = [UIStoryboard storyboardWithName:@"Regist_Login_Storyboard" bundle:nil];
    UIViewController *vc = [stb instantiateViewControllerWithIdentifier:@"WelcomeViewController"];
    
    //    UIStoryboard *stb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    //    UIViewController *vc = [stb instantiateViewControllerWithIdentifier:@"AlarmListViewController"];
    //    [self presentViewController:vc animated:YES completion:^{
    //
    //    }];
    
    
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    //链接APNS服务器
    if ([launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey] != nil) {
        //获取应用程序消息通知标记数（即小红圈中的数字）
        NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
        if (badge>0) {
            //如果应用程序消息通知标记数（即小红圈中的数字）大于0，清除标记。
            badge--;
            //清除标记。清除小红圈中数字，小红圈中数字为0，小红圈才会消除。
            [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
        }
    }
    [KBUserInfo sharedInfo].token=@"";
    //初始化 ios_token
    [KBUserInfo sharedInfo].ios_token=[NSString stringWithFormat:@"%@",@" "];
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    NSLog(@"%@",NSHomeDirectory());
    UIUserNotificationSettings *s=[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:s];
#else
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge];
#endif
    
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
    [[KBUserInfo sharedInfo]save];
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
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
    //    NSString *token=[[NSString alloc]initWithData:deviceToken encoding:NSUTF8StringEncoding];
    NSString *pushToken = [[[[deviceToken description]
                             stringByReplacingOccurrencesOfString:@"<" withString:@""]
                            stringByReplacingOccurrencesOfString:@">" withString:@""]
                           stringByReplacingOccurrencesOfString:@" " withString:@""] ;
    //存储token
    KBUserInfo *user=[KBUserInfo sharedInfo];
    user.ios_token=pushToken;
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"%@",error.localizedDescription);
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"%@",userInfo);
    [[KBScoketManager ShareManager] analyseMessage:userInfo];
    //收到相应消息
}

@end
