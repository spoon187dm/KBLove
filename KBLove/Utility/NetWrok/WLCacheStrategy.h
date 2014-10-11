//
//  WLCacheStrategy.h
//  WLLib
//
//  Created by block on 14-10-9.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLCacheStrategy : NSObject

//缓存路径
@property (nonatomic, copy) NSString *cacheDirectory;
//缓存有效时长
@property (nonatomic, assign) CGFloat cacheEffectTimeTravel;
//是否仅在wifi下使用
@property (nonatomic, assign) BOOL isWifyOnly;
//是否在超时之后自动删除
@property (nonatomic, assign) BOOL isSelfDelete;

+ (WLCacheStrategy *)sharedStrategy;

/**
 *  获取缓存策略-时长-WiFi
 *
 *  @param timeTravel 缓存有效时长
 *  @param wifyOnly   是否在仅在WiFi下使用
 *
 *  @return 目标策略
 */
+ (WLCacheStrategy *)cacheStrategyWithEffectTimeTravel:(NSTimeInterval)timeTravel wifiOnly:(BOOL)wifyOnly;

/**
 *  获取缓存策略-时长-WiFi-自删除
 *
 *  @param timeTravel 缓存有效时长
 *  @param wifyOnly   是否仅在WiFi下使用
 *  @param selfDelete 是否在超时之后自动删除缓存
 *
 *  @return 目标策略
 */
+ (WLCacheStrategy *)cacheStrategyWithEffectTimeTravel:(NSTimeInterval)timeTravel wifiOnly:(BOOL)wifyOnly selfDelete:(BOOL)selfDelete;

/**
 *  获取缓存策略-路径-时长-WiFi-自动删除
 *
 *  @param directry   缓存路径
 *  @param timeTravel 缓存有效时长
 *  @param wifyOnly   是否仅在WiFi下使用
 *  @param selfDelete 是否在超时之后自动删除缓存
 *
 *  @return 目标策略
 */
+ (WLCacheStrategy *)cacheStrategyWithDirecty:(NSString *)directry effectTimeTravel:(NSTimeInterval)timeTravel wifiOnly:(BOOL)wifyOnly selfDelete:(BOOL)selfDelete;

//- (void)read;
//- (void)effective;

@end
