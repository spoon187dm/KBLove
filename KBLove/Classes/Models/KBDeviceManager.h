//
//  KBDeviceManager.h
//  KBLove
//
//  Created by block on 14/10/30.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KBDevices.h"
#import "KBDevicesStatus.h"
@interface KBDeviceManager : NSObject

+ (KBDeviceManager *)sharedManager;

/**
 获取设备详细信息
 
 @param device_sn 设备号
 @param block     结果回调
 */
+ (void)getDeviceInfo:(NSString *)device_sn finishBlock:(requestBlock)block;

/**
 获取所有设备列表
 
 @param block 结果回调
 */
+ (void)getDeviceList:(ListLoadBlock)block;

/**
 获取指定设备的状态
 
 @param device_sn 设备号
 @param block     结果回调
 */
+ (void)getDeviceStatus:(NSString *)device_sn finishBlock:(requestBlock)block;

/**
 获取所有设备状态列表
 
 @param block 结果回调
 */
+ (void)getDeviceStatusList:(ListLoadBlock)block;

/**
 获取所有警报列表  已转至alarmManager
 
 @param block 结果回调
 */
+ (void)getAllAlarmList:(ListLoadBlock)block;

/**
 获取设备的所有警告信息列表 已转至alarmManager
 
 @param device_sn 设备号
 @param block     结果回调
 */
+ (void)getAlarmListForDevice:(NSString *)device_sn finishBlock:(ListLoadBlock)block ;

@end
