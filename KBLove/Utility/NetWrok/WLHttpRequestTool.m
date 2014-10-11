//
//  WLHttpRequestTool.m
//  Qtravel
//
//  Created by block on 14-10-8.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "WLHttpRequestTool.h"
#import "AFHTTPRequestOperationManager.h"
#import "NSFileManager+pathMethod.h"
@implementation WLHttpRequestTool{
    /**
     *  请求的存储字典
     */
    NSMutableDictionary *_requestDictionary;
    
    WLHttpConnectStatue _httpState;
    
    WLReachability *_internetReachability;
    WLReachability *_wifiReachability;
}

- (instancetype)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    _requestDictionary = [NSMutableDictionary dictionary];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    _internetReachability = [WLReachability reachabilityForInternetConnection];
    [_internetReachability startNotifier];
    [self updateInterfaceWithReachability:_internetReachability];
    
    _wifiReachability = [WLReachability reachabilityForLocalWiFi];
    [_wifiReachability startNotifier];
    [self updateInterfaceWithReachability:_wifiReachability];
    return self;
}

/**
 *  移除通知中心
 */
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

static WLHttpRequestTool *tool = nil;
+ (instancetype)sharedInstance{
    if (!tool) {
        tool = [[self alloc]init];
    }
    return tool;
}

/**
 *  获取当前网络连接状态，通过block回调信息
 *
 *  @param block 网络信息回调
 */
- (void)getInterNetAvailable:(WLHttpstatueBlock)block{
    if (_httpState != WLHttpConnectStatueInternetNotAvaliable) {
        block(NO, _httpState);
    }
    block(YES, _httpState);
}

/**
 *  请求网络
 *
 *  @param urlString   请求地址
 *  @param requestType 请求类型
 *  @param params      参数字典
 *  @param block       回调block
 */
- (void)request:(NSString *)urlString requestType:(WLHttpRequestType)requestType params:(NSDictionary *)params overBlock:(WLHttpRequestFiniedBlock)block{
    [self request:urlString requestType:requestType params:params cacheType:WLHttpCacheTypeNO overBlock:block];
}

/**
 *  请求网络
 *
 *  @param urlString   请求地址
 *  @param requestType 请求类型
 *  @param params      参数字典
 *  @param cacheType   缓存类型
 *  @param block       回调block
 */
- (void)request:(NSString *)urlString requestType:(WLHttpRequestType)requestType params:(NSDictionary *)params cacheType:(WLHttpCacheType)cacheType overBlock:(WLHttpRequestFiniedBlock)block{
    
//    请求已存在
    if ([_requestDictionary objectForKey:urlString]) {
        return;
    }
    
    
    CGFloat cacheEffectTime = [self cacheEffectTimeTravelOnType:cacheType];
    
    WLCacheStrategy *strategy = [WLCacheStrategy cacheStrategyWithEffectTimeTravel:cacheEffectTime wifiOnly:NO];
    
    [self request:urlString requestType:requestType params:params cacheStragety:^WLCacheStrategy *(BOOL isStrategyLegol) {
        return strategy;
    } overBlock:block];
    
}


/**
 *  可自定义缓存策略的数据请求
 *
 *  @param urlString   请求地址
 *  @param requestType 请求类型
 *  @param params      参数字典
 *  @param cacheBlock  缓存获取block
 *  @param block       完成结果block
 */
- (void)request:(NSString *)urlString requestType:(WLHttpRequestType)requestType params:(NSDictionary *)params cacheStragety:(WLHttpCacheBlock)cacheBlock overBlock:(WLHttpRequestFiniedBlock)block{
    
    WLCacheStrategy *strategy = cacheBlock(YES);
    
    if (![NSFileManager isTimeOutWithPath:[self cachePathForUrl:urlString] time:strategy.cacheEffectTimeTravel]) {
        NSData *date = [NSData dataWithContentsOfFile:[self cachePathForUrl:urlString]];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:date options:NSJSONReadingMutableContainers error:nil];
        block(YES, dic);
        return;
    }
    
    switch (requestType) {
        case WLHttpRequestTypeGet:{
            AFHTTPRequestOperation *op = [[AFHTTPRequestOperationManager manager]GET:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                [self writeToFileWithUrl:urlString obj:responseObject];
                block(YES, responseObject);
                [_requestDictionary removeObjectForKey:urlString];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                block(NO, error);
                [_requestDictionary removeObjectForKey:urlString];
            }];
            [_requestDictionary setObject:op forKey:urlString];
        }
            break;
        case WLHttpRequestTypePost:{
            AFHTTPRequestOperation *op = [[AFHTTPRequestOperationManager manager]POST:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                [self writeToFileWithUrl:urlString obj:responseObject];
                block(YES, responseObject);
                [_requestDictionary removeObjectForKey:urlString];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                block(NO, error);
                [_requestDictionary removeObjectForKey:urlString];
            }];
            [_requestDictionary setObject:op forKey:urlString];
        }
            break;
        default:
            break;
    }
}
#pragma mark - private

/**
 *  网络状态变更
 *
 *  @param note 通知
 */
- (void) reachabilityChanged:(NSNotification *)note
{
    WLReachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[WLReachability class]]);
    [self updateInterfaceWithReachability:curReach];
}

- (void)updateInterfaceWithReachability:(WLReachability *)reachability
{
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    BOOL connectionRequired = [reachability connectionRequired];

    
    switch (netStatus)
    {
        case NotReachable:        {
            connectionRequired = NO;
            break;
        }
            
        case ReachableViaWWAN:        {
            _httpState = WLHttpConnectStatueInternetAvaliable;
            return;
        }
        case ReachableViaWiFi:        {
            _httpState = WLHttpConnectStatueWIFIAvailable;
            return;
        }
    }
    //TODO FIWI 情况下可进行特殊处理
//    此处暂不处理
//    if (reachability == _internetReachability)
//    {
//        
//    }
//    
//    if (reachability == _wifiReachability)
//    {
//        
//    }
}

/**
 *  根据类型获取缓存有效时长
 *
 *  @param type 缓存策略
 *
 *  @return 有效时长
 */
- (CGFloat)cacheEffectTimeTravelOnType:(WLHttpCacheType)type{
    switch (type) {
        case WLHttpCacheTypeNO:{
            return 0;
        }
            break;
        case WLHttpCacheTypeHour:{
            return 60*60;
        }
            break;
        case WLHttpCacheTypeAlways:{
            return -1;
        }
            break;
        default:
            return 0;
            break;
    }
}

/**
 *  获取缓存文件夹
 *
 *  @return 缓存文件夹路径
 */
- (NSString *)cacheDirectry{
    NSString *cachePath = [WLCacheStrategy sharedStrategy].cacheDirectory;
    return cachePath;
}

/**
 *  获取缓存文件
 *
 *  @param urlString 缓存网络地址
 *
 *  @return 缓存路径
 */
- (NSString *)cachePathForUrl:(NSString *)urlString{
    NSString *cacheName = [urlString MD5Hash];
    NSString *cachePath = [[self cacheDirectry] stringByAppendingPathComponent:cacheName];
    return cachePath;
}

/**
 *  写缓存
 *
 *  @param urlString 请求地址
 *  @param obj       缓存数据
 */
- (void)writeToFileWithUrl:(NSString *)urlString obj:(id)obj{
    NSString *cachePath = [self cachePathForUrl:urlString];
    NSData *data ;
    if ([obj isKindOfClass:[NSData class]]) {
        data = (NSData *)obj;
    }else if ([obj isKindOfClass:[NSString class]]){
        data = [((NSString *)obj)dataUsingEncoding:NSUTF8StringEncoding];
    }else{
        data = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:nil];
    }
    [data writeToFile:cachePath atomically:YES];
}

/**
 *  清除所有缓存
 */
- (void)clearAllCache{
    NSFileManager *fm = [NSFileManager defaultManager];
    [fm removeItemAtPath:[self cacheDirectry] error:nil];
}

/**
 *  清除指定网络地址的缓存文件
 *
 *  @param urlString 网络地址
 */
- (void)clearCacheForUrl:(NSString *)urlString{
    NSFileManager *fm = [NSFileManager defaultManager];
    [fm removeItemAtPath:[self cachePathForUrl:urlString] error:nil];
}

/**
 *  缓存文件大小（M）
 *
 *  @return 缓存文件大小
 */
- (CGFloat)cacheFileSize{
    //FIXME 暂时未完成功能
    return 0;
}

@end
