//
//  UIViewController+NavigationItemSettingTool.m
//  WellKnow
//
//  Created by block on 14-9-20.
//  Copyright (c) 2014年 Block. All rights reserved.
//

#import "UIViewController+NavigationItemSettingTool.h"

@implementation UIViewController (NavigationItemSettingTool)

- (void)changeNavigationBarToClear{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"TMD"] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setTranslucent:YES];
    //    为什么要加这个呢，shadowImage 是在ios6.0以后才可用的。但是发现5.0也可以用。不过如果你不判断有没有这个方法，
    //    而直接去调用可能会crash，所以判断下。作用：如果你设置了上面那句话，你会发现是透明了。但是会有一个阴影在，下面的方法就是去阴影
    if ([self.navigationController.navigationBar respondsToSelector:@selector(shadowImage)])
    {
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    }
}

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
