//
//  KBFreash.h
//  LoveFreeTrip
//
//  Created by 1124 on 14-10-14.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KBFreash : NSObject
//开启加载
+ (void)startRefreshWithTitle:(NSString *)title inView:(UIView *)view;
//结束加载
+ (void)StopRefreshinView:(UIView *)view;

- (void)StopRefresh;
@end
