//
//  UIViewController+NavigationItemSettingTool.m
//  WellKnow
//
//  Created by block on 14-9-20.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import "UIViewController+NavigationItemSettingTool.h"

@implementation UIViewController (NavigationItemSettingTool)

- (void)addCustomNavigationItemWithImageName:(NSString *)imageName{
    [self.navigationController setNavigationBarHidden:YES];
    
    UIView *navigationItemView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    UIImageView *background = [UIImageView imageViewWithFrame:navigationItemView.bounds image:[UIImage imageNamed:imageName]];
    [navigationItemView addSubview:background];
    [navigationItemView setTag:CustomNavigationitemtag];

    UIView *view = [self.view viewWithTag:CustomNavigationitemtag];
    if (view) {
        [view removeFromSuperview];
    }
    
    [self.view addSubview:navigationItemView];
}

- (void)setNavigationTitle:(NSString *)title{
    UIView *navigationItem = [self.view viewWithTag:CustomNavigationitemtag];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,100,40)];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:@"Arial" size:22];
    label.center = CGPointMake(kScreenWidth/2, 42);
    [navigationItem addSubview:label];
}

- (void)setNavigationItems:(NSArray *)itemsArray onLeft:(BOOL)onLeft{
    for (id obj in itemsArray) {
        if (![obj isKindOfClass:[UIView class]]) {
            return;
        }
    }
    
    UIView *navigationitem = [self.view viewWithTag:CustomNavigationitemtag];
    if (onLeft) {
//        左侧
        for (NSInteger i = 0; i<itemsArray.count; i++) {
            UIView *view =itemsArray[i];
            view.x = 10+i*30;
            view.y = 20+22;
            [navigationitem addSubview:view];
        }
    }else{
//        右侧
        for (NSInteger i = 0; i<itemsArray.count; i++) {
            UIView *view =itemsArray[i];
            view.x = kScreenWidth-10-i*30;
            view.y = 20+22;
            [navigationitem addSubview:view];
        }
    }
    
}

- (void)addSimpleNavigationBackButton{
    
}

- (void)navigationBackButtonClicked:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
