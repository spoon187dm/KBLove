//
//  WLCacheStrategy.m
//  WLLib
//
//  Created by block on 14-10-9.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "WLCacheStrategy.h"

@implementation WLCacheStrategy

static WLCacheStrategy *strategy = nil;
+ (WLCacheStrategy *)sharedStrategy{
    if (!strategy) {
        strategy = [[self alloc]init];
    }
    [strategy read];
    return strategy;
}

- (instancetype)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    [self read];
    return self;
}


/**
 *  获取缓存策略
 *
 *  @param timeTravel 缓存有效时长
 *  @param wifyOnly   是否在仅在WiFi下使用
 *
 *  @return 目标策略
 */
+ (WLCacheStrategy *)cacheStrategyWithEffectTimeTravel:(NSTimeInterval)timeTravel wifiOnly:(BOOL)wifyOnly{
    return [self cacheStrategyWithDirecty:[self sharedStrategy].cacheDirectory effectTimeTravel:timeTravel wifiOnly:wifyOnly selfDelete:NO];;
}

/**
 *  获取缓存策略
 *
 *  @param timeTravel 缓存有效时长
 *  @param wifyOnly   是否仅在WiFi下使用
 *  @param selfDelete 是否在超时之后自动删除缓存
 *
 *  @return 目标策略
 */
+ (WLCacheStrategy *)cacheStrategyWithEffectTimeTravel:(NSTimeInterval)timeTravel wifiOnly:(BOOL)wifyOnly selfDelete:(BOOL)selfDelete{
    return [self cacheStrategyWithDirecty:[self sharedStrategy].cacheDirectory effectTimeTravel:timeTravel wifiOnly:wifyOnly selfDelete:selfDelete];;
}

/**
 *  获取缓存策略-路径文件夹-时长-WiFi-自动删除
 *
 *  @param directry   缓存路径
 *  @param timeTravel 缓存有效时长
 *  @param wifyOnly   是否仅在WiFi下使用
 *  @param selfDelete 是否在超时之后自动删除缓存
 *
 *  @return 目标策略
 */
+ (WLCacheStrategy *)cacheStrategyWithDirecty:(NSString *)directry effectTimeTravel:(NSTimeInterval)timeTravel wifiOnly:(BOOL)wifyOnly selfDelete:(BOOL)selfDelete{
    WLCacheStrategy *strategy = [[WLCacheStrategy alloc]init];
    if (![directry isEqualToString:[strategy defaultCacheDirectry]]) {
//        不是默认缓存地址
        //TODO 非默认缓存地址--F:自定义缓存
        [strategy changeCacheDirectry:directry];
    }
    strategy.cacheDirectory = directry;
    strategy.cacheEffectTimeTravel = timeTravel;
    strategy.isWifyOnly = wifyOnly;
    strategy.isSelfDelete = selfDelete;
    return strategy;
}



- (void)read{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    _cacheDirectory = [ud objectForKey:@"_wlcacheDirectory"];
    _cacheEffectTimeTravel = [[ud objectForKey:@"wlcacheEffectTimeTravel"] floatValue];
    _isWifyOnly = NO;
    _isSelfDelete = NO;
    if (!_cacheDirectory) {
        //自定义缓存路径不存在
        NSString *cachePath = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp/WLCache"];
        //确保缓存路径存在
        NSFileManager *fm = [NSFileManager defaultManager];
        if (![fm fileExistsAtPath:cachePath]) {
            [fm createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        _cacheDirectory = cachePath;
        [ud setObject:_cacheDirectory forKey:@"_wlcacheDirectory"];
        [ud synchronize];
    }
}

- (void)effective{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:_cacheDirectory forKey:@"_wlcacheDirectory"];
    [ud setObject:[NSNumber numberWithFloat:_cacheEffectTimeTravel] forKey:@"wlcacheEffectTimeTravel"];
    [ud synchronize];
}

/**
 *  获取默认缓存文件夹
 *
 *  @return 缓存文件夹路径
 */
- (NSString *)defaultCacheDirectry{
    NSString *cachePath = [[NSUserDefaults standardUserDefaults] objectForKey:@"_wlcacheDirectory"];
    return cachePath;
}


/**
 *  修改缓存路径文件夹
 *
 *  @param newDirecty 新的缓存文件夹
 *
 *  @return 成功与否
 */
- (BOOL)changeCacheDirectry:(NSString *)newDirecty{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *oldCacheDirectry = [ud objectForKey:@"wlcacheDirectory"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:newDirecty]) {
        [fm createDirectoryAtPath:newDirecty withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    [fm removeItemAtPath:oldCacheDirectry error:nil];
    return YES;
}

@end
