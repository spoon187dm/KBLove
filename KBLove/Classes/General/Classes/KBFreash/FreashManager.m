//
//  FreashManager.m
//  LoveFreeTrip
//
//  Created by 1124 on 14-10-14.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "FreashManager.h"
static FreashManager *manager;
@implementation FreashManager
{
    NSMutableDictionary *_freashList;
}
- (id)init
{
    self=[super init];
    if (self) {
        _freashList=[[NSMutableDictionary alloc]init];
    }
    return self;
}
+ (id)DefaultManager
{
    if (manager==nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            manager=[[FreashManager alloc]init];
            
        });
    }
    return manager;
}
- (void)addFreash:(KBFreash *)freash andKey:(NSString *)key
{
    [_freashList setObject:freash forKey:key];
}
- (void)removeFreashWithKey:(NSString *)key
{
    KBFreash *freash=[_freashList objectForKey:key];
    [freash StopRefresh];
    [_freashList removeObjectForKey:key];
    
}
@end
