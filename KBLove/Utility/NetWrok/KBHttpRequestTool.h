//
//  WLHttpRequestTool.h
//  Qtravel
//
//  Created by block on 14-10-8.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "WLCacheStrategy.h"
/**
 *  网络连接状态
 */
typedef NS_ENUM(NSInteger, WLHttpConnectStatue) {
    /**
     *  WIFI可用
     */
    WLHttpConnectStatueWIFIAvailable=1,
    /**
     *  3G网络可用
     */
    WLHttpConnectStatueInternetAvaliable=1<<1,
    /**
     *  无网络可用
     */
    WLHttpConnectStatueInternetNotAvaliable=1<<2
};

/**
 缓存策略类型
 */
typedef NS_ENUM(NSInteger, WLHttpCacheType){
    /**
     不使用缓存
     */
    WLHttpCacheTypeNO,
    /**
     缓存默认时长一小时
     */
    WLHttpCacheTypeHour,
    /**
     永久使用缓存
     */
    WLHttpCacheTypeAlways
};

/**
 *  网络请求类型(GET,POST)
 */
typedef NS_ENUM(NSInteger, KBHttpRequestType) {
    /**
     *  GET请求
     */
    KBHttpRequestTypeGet,
    /**
     *  POST请求
     */
    KBHttpRequestTypePost
};

typedef void (^KBHttpstatueBlock)(BOOL isconnect, WLHttpConnectStatue httpState);
typedef void (^KBHttpRequestFiniedBlock)(BOOL IsSuccess, id result);
typedef WLCacheStrategy* (^WLHttpCacheBlock)(BOOL isStrategyLegol);

@interface KBHttpRequestTool : NSObject

+ (instancetype)sharedInstance;

- (void)getInterNetAvailable:(KBHttpstatueBlock)block;

/**
 *  默认缓存请求数据
 *
 *  @param urlString   请求地址
 *  @param requestType 请求类型
 *  @param params      参数字典
 *  @param block       完成结果block
 */
- (void)request:(NSString *)urlString requestType:(KBHttpRequestType)requestType params:(NSDictionary *)params overBlock:(KBHttpRequestFiniedBlock)block;

/**
 *  可设置缓存策略的数据请求
 *
 *  @param urlString   请求地址
 *  @param requestType 请求类型
 *  @param params      参数字典
 *  @param cacheType   缓存类型
 *  @param block       完成结果block
 */
- (void)request:(NSString *)urlString requestType:(KBHttpRequestType)requestType params:(NSDictionary *)params cacheType:(WLHttpCacheType)cacheType overBlock:(KBHttpRequestFiniedBlock)block;

/**
 *  可自定义缓存策略的数据请求
 *
 *  @param urlString   请求地址
 *  @param requestType 请求类型
 *  @param params      参数字典
 *  @param cacheBlock  缓存获取block
 *  @param block       完成结果block
 */
- (void)request:(NSString *)urlString requestType:(KBHttpRequestType)requestType params:(NSDictionary *)params cacheStragety:(WLHttpCacheBlock)cacheBlock overBlock:(KBHttpRequestFiniedBlock)block;

/**
 *  清除所有缓存
 */
- (void)clearAllCache;

/**
 *  清除指定网络地址的缓存文件
 *
 *  @param urlString 网络地址
 */
- (void)clearCacheForUrl:(NSString *)urlString;

/**
 *  缓存文件大小（M）
 *
 *  @return 缓存文件大小
 */
- (CGFloat)cacheFileSize;

@end
