//
//  KBAlarmManager.h
//  KBLove
//
//  Created by block on 14-10-16.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KBAlarm.h"
@class KBDevices;

@interface KBAlarmManager : NSObject


+ (KBAlarmManager *)sharedManager;

/**
 @Author block, 10-16 13:10
 
 获取指定设备的警告信息 不建议使用
 
 @param devices 指定设备
 @param block   结果回调
 */
- (void)getAlarmInfoForDevice:(KBDevices *)devices finishblock:(requestBlock)block;

//- (void)deleteAlarm:(KBAlarm *)alarm finishBlock:(requestBlock)block;


@end
