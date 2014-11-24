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


/**
 将自身的navigaionbar设置为透明
 */
- (void)changeNavigationBarToClear;

/**
 使用指定图，截取出适合navigationbar的一部分
 
 @param imageName 图片名
 */
- (void)changeNavigationBarFromImage:(NSString *)imagename;






- (void)addCustomNavigationItemWithImageName:(NSString *)imageName;

- (void)setNavigationTitle:(NSString *)title;
- (void)setNavigationItems:(NSArray *)itemsArray onLeft:(BOOL)onLeft;

- (void)addSimpleNavigationBackButton;

@end
