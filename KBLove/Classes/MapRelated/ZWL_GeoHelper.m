//
//  CCGeoHelper.m
//  Tracker
//
//  Created by apple on 13-12-30.
//  Copyright (c) 2013年 Capcare. All rights reserved.
//

#import "ZWL_GeoHelper.h"
#import "ZWL_Utils.h"

@implementation CCGeoQueryPrams

@end

@implementation ZWL_GeoHelper
//
//+ (ZWL_GeoHelper *)sharedClient {
//    static ZWL_GeoHelper *_sharedClient = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _sharedClient = [[ZWL_GeoHelper alloc] init];
//    });
//    
//    return _sharedClient;
//}
//
//- (id)init
//{
//    self = [super init];
//    if (self) {
//        _geoCache = [[NSMutableDictionary alloc] init];
//        _queryList = [[NSMutableArray alloc] init];
//        _search = [[BMKSearch alloc] init];
//        _search.delegate = self;
//    }
//    return self;
//}

//-(CLLocationCoordinate2D) adjustPrecision:(CLLocationCoordinate2D) coord
//{
//    CLLocationCoordinate2D newCoord;
//    // 由于精度问题， 查询和返回的地址经纬度并不是完全一致的，特此处理精度，精确到小数点后面4位
//    int lang = (int)(coord.longitude * 1e6) / 200 * 200;
//    int lat =  (int)(coord.latitude * 1e6) / 200 * 200;
//    newCoord.longitude = lang / 1e6;
//    newCoord.latitude = lat / 1e6;
//    return newCoord;
//}
//
//-(NSString*) getAddress:(CLLocationCoordinate2D)coord delegate:(id)delegate
//{
////    coord = [self adjustPrecision:coord];
//    
//    NSDictionary *Dic_fixlocation = BMKBaiduCoorForWgs84(coord);
//    CLLocationCoordinate2D fixLocationCoordiante = BMKCoorDictionaryDecode(Dic_fixlocation);
//    
//    NSString* key = [self genCoordKey:coord];
//
//    NSString* address = [_geoCache objectForKey:key];
//    if (![ZWL_Utils isEmpty:address]) {
//        return address;
//    }
//    
//    [_search reverseGeocode:fixLocationCoordiante];
//    CCGeoQueryPrams* queryParam = [[CCGeoQueryPrams alloc] init];
//    queryParam.coord = coord;
//    queryParam.delegate = delegate;
//    [_queryList addObject:queryParam];
//
//    return @"";
//}
//
//-(void)cleanQueryList
//{
//    [_queryList removeAllObjects];
//}
//
//- (void)clean
//{
//    [_queryList removeAllObjects];
//    [_geoCache removeAllObjects];
//}
//
//-(NSString*) genCoordKey:(CLLocationCoordinate2D)coord
//{
//    return [NSString stringWithFormat:@"%f, %f", coord.latitude, coord.longitude];
//}
//
//- (void)onGetAddrResult:(BMKAddrInfo*)result errorCode:(int)error
//{
//    NSInteger size = _queryList.count;
//    if (size <= 0) {
//        return;
//    }
//    
//    CCGeoQueryPrams* lastPrams = [_queryList objectAtIndex:size - 1];
//    [_queryList removeLastObject];
//
//    if (result) {
//        NSString* key = [self genCoordKey:lastPrams.coord];
//        
//        // 添加到缓存
//        [_geoCache setObject:result.strAddr forKey:key];
//        
//        id delegate = lastPrams.delegate;
//        if (delegate && [delegate conformsToProtocol:@protocol(CCGeoHelperDelegate)]) {
//            [delegate performSelector:@selector(onGetAddress:) withObject:result.strAddr];
//        }
//    }
//}


@end
