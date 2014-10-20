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
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav_Bacground"] forBarMetrics:UIBarMetricsDefault];
    [[UITableView appearance] setBackgroundColor:SYSTEM_COLOR];
    [[UITableViewCell appearance]setBackgroundColor:[UIColor colorWithRed:0.000 green:0.569 blue:0.588 alpha:1.000]];
//    [[UIView appearance]setBackgroundColor:SYSTEM_COLOR];
    [[UILabel appearance]setTextColor:[UIColor whiteColor]];
//    UIStoryboard *stb = [UIStoryboard storyboardWithName:@"Regist_Login_Storyboard" bundle:nil];
//    UIViewController *vc = [stb instantiateViewControllerWithIdentifier:@"WelcomeViewController"];
    
    UIStoryboard *stb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UIViewController *vc = [stb instantiateViewControllerWithIdentifier:@"AlarmListViewController"];
//    [self presentViewController:vc animated:YES completion:^{
//        
//    }];
    
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
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

@end
