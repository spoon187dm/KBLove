//
//  CCDeviceStatus.h
//  Tracker
//
//  Created by apple on 13-11-5.
//  Copyright (c) 2013年 Capcare. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "
#import "BMapKit.h"
#import "CCJASONObject.h"
#import "ZWL_GeoHelper.h"
//#import <MAMapKit/MAMapKit.h>

@interface CCDeviceStatus : NSObject<CCJASONObject, CCGeoHelperDelegate>

@property (nonatomic, assign) long long uid;            // 设备id
@property (nonatomic, assign) NSInteger lang;           // 经度
@property (nonatomic, assign) NSInteger lat;            // 纬度
@property (nonatomic, assign) float speed;              // 速度
@property (nonatomic, assign) float heading;            // 方向 direction
@property (nonatomic, assign) float flowTotal;          // 总计流量
@property (nonatomic, assign) float flow;               // 剩余流量
@property (nonatomic, assign) NSInteger battery;        // 电量百分比
@property (nonatomic, assign) NSInteger status;         // 1：在线	2：离线	3：注销	4：过期	5：服务停止
@property (nonatomic, copy) NSString* sn;               // sn
@property (nonatomic, assign) long long receive;        // 时间
@property (nonatomic, assign) NSInteger stayed;
@property (nonatomic, copy) NSString* address;
@property (nonatomic, assign) long long stamp;

@property (nonatomic, assign) BMKGeoPoint point;
@property (nonatomic, assign) MAMapPoint gaode_point;
@property (nonatomic, assign) BOOL addressRequested;

@property (nonatomic, strong) id<CCGeoHelperDelegate> geoDelegate;

-(void) convertPoint;

-(NSString*)getAddress;

-(void)readFromArray:(id)array;

@end
