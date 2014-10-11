//
//  UIViewController+NavigationItemSettingTool.h
//  WellKnow
//
//  Created by block on 14-9-20.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CustomNavigationitemtag 983364
@interface UIViewController (NavigationItemSettingTool)

- (void)addCustomNavigationItemWithImageName:(NSString *)imageName;

- (void)setNavigationTitle:(NSString *)title;
- (void)setNavigationItems:(NSArray *)itemsArray onLeft:(BOOL)onLeft;

- (void)addSimpleNavigationBackButton;

@end
