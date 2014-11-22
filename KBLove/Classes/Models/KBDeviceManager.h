//
//  KBDeviceManager.h
//  KBLove
//
//  Created by block on 14/10/30.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KBDevices.h"
#import "KBAlarm.h"
#import "KBDevicesStatus.h"
#import "KBFence.h"
#import "KBTracePart.h"
#import "CCDeviceStatus.h"
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
 获取所有警报列表
 
 @param block 结果回调
 */
+ (void)getAllAlarmList:(ListLoadBlock)block;

/**
 获取设备的所有警告信息列表
 
 @param device_sn 设备号
 @param block     结果回调
 */
+ (void)getAlarmListForDevice:(NSString *)device_sn finishBlock:(ListLoadBlock)block ;

/**
 删除指定警告信息
 
 @param alarm 警告
 @param block 结果回调
 */
+ (void)deleteAlarm:(KBAlarm *)alarm block:(requestBlock)block;

/**
 删除一组警告信息
 
 @param array 警告数组
 @param block 结果回调
 */
+ (void)deleteAlarmList:(NSArray *)array block:(requestBlock)block;

/**
 设置指定警告信息为已读
 
 @param alarm 警告信息
 @param block 结果回调
 */
+ (void)readAlarm:(KBAlarm *)alarm block:(requestBlock)block;

/**
 设置一组警告信息为已读
 
 @param array 警告数组
 @param block 结果回调
 */
+ (void)readAlarmList:(NSArray *)array block:(requestBlock)block;

/**
 更新围栏信息
 
 @param fence 新的围栏
 @param block 结果回调
 */
+ (void)updateFence:(KBFence *)fence block:(requestBlock)block;

/**
 获取轨迹回放信息
 
 @param device_sn 设备号
 @param beginDate 起始时间
 @param endDate   结束时间
 @param block     结果回调
 */
+ (void)getDeviceTrack:(NSString *)device_sn from:(long)beginDate to:(long)endDate block:(requestBlock)block;

/**
 获取轨迹分段信息
 
 @param device_sn 设备号
 @param beginDate 起始时间
 @param endDate   结束时间
 @param block     结果回调
 */
+ (void)getDevicePart:(NSString *)device_sn from:(long)beginDate to:(long)endDate block:(requestBlock)block;

@end
