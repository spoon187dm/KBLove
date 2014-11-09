//
//  KBFreash.m
//  LoveFreeTrip
//
//  Created by 1124 on 14-10-14.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "KBFreash.h"
#import "FreashManager.h"
@implementation KBFreash
{
    UIActivityIndicatorView  *_activityView;
    UIView *_bgView;
    UILabel *_titleLble;
    
}
- (id)init
{
    self=[super init];
    if (self) {
        _activityView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _titleLble=[[UILabel alloc] init];
        _titleLble.textAlignment=NSTextAlignmentCenter;
        _titleLble.textColor=[UIColor whiteColor];
        _bgView=[[UIView alloc]init];
        _bgView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    }
    return self;
}
+ (void)startRefreshWithTitle:(NSString *)title inView:(UIView *)view
{
    KBFreash *freash=[[KBFreash alloc]init];
    NSLog(@"%@",[view.description componentsSeparatedByString:@";"][0]);
    [[FreashManager DefaultManager]addFreash:freash andKey:[[view.description componentsSeparatedByString:@";"][0] componentsSeparatedByString:@" "][1]];
    [freash startRefreshWithTitle:title inView:view];
}
- (void)startRefreshinView:(UIView *)view
{
    [self startRefreshWithTitle:@"" inView:view];
}
- (void)setTitle:(NSString *)title
{
    _titleLble.text=title;
}
- (void)startRefreshWithTitle:(NSString *)title inView:(UIView *)view
{
    _bgView.frame=view.bounds;
    _activityView.center=CGPointMake(view.bounds.size.width/2, view.bounds.size.height/2-60);
    CGSize size=[title sizeToFont:_titleLble.font WithWidth:kScreenWidth];
    CGRect fr=_activityView.frame;
    _titleLble.text=title;
    //_titleLble.backgroundColor=[UIColor redColor];
    _titleLble.frame=CGRectMake(0, _activityView.center.y+fr.size.height/2, _bgView.frame.size.width, size.height);
    [_activityView startAnimating];
    [_bgView addSubview:_activityView];
    [_bgView addSubview:_titleLble];
    [view addSubview:_bgView];
    
}
+ (void)StopRefreshinView:(UIView *)view
{
   
   [[FreashManager DefaultManager]removeFreashWithKey:[[view.description componentsSeparatedByString:@";"][0] componentsSeparatedByString:@" "][1]];
}
- (void)StopRefresh
{
    [_activityView stopAnimating];
    [_bgView removeFromSuperview];
}

@end
