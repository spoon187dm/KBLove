//
//  AppDelegate.h
//  KBLove
//
//  Created by block on 14-10-10.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMKMapManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

{
    BMKMapManager *_mapManager;
}

@property (strong, nonatomic) UIWindow *window;

@end
