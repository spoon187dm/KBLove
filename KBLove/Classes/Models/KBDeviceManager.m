//
//  KBDeviceManager.m
//  KBLove
//
//  Created by block on 14/10/30.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "KBDeviceManager.h"
#import "KBHttpRequestTool.h"

@implementation KBDeviceManager

static KBDeviceManager *sharedManager = nil;
+ (KBDeviceManager *)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc]init];
    });
    return sharedManager;
}

+ (void)getDeviceInfo:(NSString *)device_sn finishBlock:(requestBlock)block{
    NSAssert(device_sn, @"设备号不能为空");
    
    NSString *user_id = [KBUserInfo sharedInfo].user_id;
    NSString *token  = [KBUserInfo sharedInfo].token;
    NSDictionary *params = @{@"user_id":user_id,
                             @"device_sn":device_sn,
                             @"token":token
                             };
    WLLog(@"开始获取设备信息:%@",device_sn);
    [[KBHttpRequestTool sharedInstance]request:Url_GetDeviceInfo requestType:KBHttpRequestTypePost params:params cacheType:WLHttpCacheTypeNO overBlock:^(BOOL IsSuccess, id result) {
        if (IsSuccess) {
            WLLog(@"设备获取信息网络成功");
            NSNumber *ret = result[@"ret"];
            if ([ret isEqualToNumber:@1]) {
                WLLog(@"~~获取设备信息成功");
                KBDevices *device = [[KBDevices alloc]init];
                [device setValuesForKeysWithDictionary:result[@"device"]];
                block(YES, device);
            }else{
                WLLog(@"!!获取设备信息出错");
                block(NO, [NSError errorWithDomain:@"返回结果错误" code:999 userInfo:nil]);
            }
        }else{
            WLLog(@"设备获取网络失败");
            block(NO, result);
        }
    }];
}

+ (void)getDeviceList:(ListLoadBlock)block{
    NSString *userid = [KBUserInfo sharedInfo].user_id;
    NSString *token = [KBUserInfo sharedInfo].token;
    
    NSParameterAssert(userid);
    NSParameterAssert(token);
    
    NSDictionary *params = @{@"user_id":userid,
                             @"page_number":@(kPageNumber),
                             @"page_size":@(kPageSize),
                             @"token":token
                             };
    
    [[KBHttpRequestTool sharedInstance]request:Url_GetDeviceList requestType:KBHttpRequestTypePost params:params cacheStragety:^WLCacheStrategy *(BOOL isStrategyLegol) {
        return [WLCacheStrategy cacheStrategyWithEffectTimeTravel:0 wifiOnly:NO];
    } overBlock:^(BOOL IsSuccess, id result) {
        if (IsSuccess) {
            NSMutableArray *resultArray = [NSMutableArray array];
            NSArray *devicesArray = [result objectForKey:@"devices"];
            for (NSDictionary *perDic in devicesArray) {
                KBDevices *device = [[KBDevices alloc]init];
                [device setValuesForKeysWithDictionary:perDic];
                [resultArray addObject:device];
            }
            if (block) {
                block(YES, [resultArray copy]);
            }
        }else{
            block(NO, nil);
        }
    }];
    
}

+ (void)getDeviceStatus:(NSString *)device_sn finishBlock:(requestBlock)block{
    NSAssert(device_sn, @"设备号不能为空");
    NSString *userid = [KBUserInfo sharedInfo].user_id;
    NSString *token = [KBUserInfo sharedInfo].token;
    NSDictionary *dic = @{@"user_id":userid,
                          @"device_sn":device_sn,
                          @"app_name":app_name,
                          @"token":token};

    WLLog(@"~~开始获取设备状态：%@",device_sn);
    [[KBHttpRequestTool sharedInstance]request:Url_GetDeviceStatus requestType:KBHttpRequestTypePost params:dic overBlock:^(BOOL IsSuccess, id result) {
        if (IsSuccess) {
            WLLog(@"~~获取设备状态网络请求成功");
            NSNumber *ret = result[@"ret"];
            if ([ret isEqualToNumber:@1]) {
                WLLog(@"~~获取设备状态成功");
                KBDevicesStatus *status = [[KBDevicesStatus alloc]init];
                [status setValuesForKeysWithDictionary:result[@"status"]];
                block(YES, status);
            }else{
                WLLog(@"!!获取设备状态出错");
                block(NO, [NSError errorWithDomain:@"返回结果错误" code:999 userInfo:nil]);
            }
        }else{
            WLLog(@"!!获取设备状态网络失败");
            block(NO, result);
        }
    }];
}

+ (void)getDeviceStatusList:(ListLoadBlock)block{
    
}

+ (void)getAlarmListForDevice:(NSString *)device_sn finishBlock:(ListLoadBlock)block{
    NSAssert(device_sn, @"请求出错，设备号为空");
    NSString *userid = [KBUserInfo sharedInfo].user_id;
    NSString *token = [KBUserInfo sharedInfo].token;
    NSDictionary *params = @{
                             @"user_id":userid,
                             @"device_sn":device_sn,
                             @"token":token
                             };
    [[KBHttpRequestTool sharedInstance]request:Url_GetAlarmList requestType:KBHttpRequestTypePost params:params overBlock:^(BOOL IsSuccess, id result) {
        
        if (IsSuccess) {
            NSMutableArray *resultArray = [NSMutableArray array];
            NSDictionary *root = [NSDictionary dictionaryWithDictionary:result];
            NSArray *alarms = [root objectForKey:@"alarms"];
            for (NSDictionary *perAlarm in alarms) {
                KBAlarm *alarm = [[KBAlarm alloc]init];
                [alarm setValuesForKeysWithDictionary:perAlarm];
                [resultArray addObject:alarm];
            }
            if (block) {
                block(YES,resultArray);
            }
        }else{
            if (block) {
                block(NO, result);
            }
        }
        
    }];
}

+ (void)getAllAlarmList:(ListLoadBlock)block{
    NSString *userId = [KBUserInfo sharedInfo].user_id;
    NSString *token = [KBUserInfo sharedInfo].token;
    NSDictionary *params = @{@"user_id":userId,
                             @"app_name":app_name,
                             @"begin":@(-1),
                             @"end":@(-1),
                             @"token":token
                             };
    [[KBHttpRequestTool sharedInstance]request:Url_GetAllAlarmList requestType:KBHttpRequestTypePost params:params overBlock:^(BOOL IsSuccess, id result) {
        if (IsSuccess) {
            NSMutableArray *resultArray = [NSMutableArray array];
            NSDictionary *root = [NSDictionary dictionaryWithDictionary:result];
            NSArray *alarms = [root objectForKey:@"alarms"];
            for (NSDictionary *perAlarm in alarms) {
                KBAlarm *alarm = [[KBAlarm alloc]init];
                [alarm setValuesForKeysWithDictionary:perAlarm];
                [resultArray addObject:alarm];
            }
            if (block) {
                block(YES,resultArray);
            }
        }else{
            if (block) {
                block(NO, result);
            }
        }
    }];
}

+ (void)deleteAlarm:(KBAlarm *)alarm block:(requestBlock)block{
    [self deleteAlarmList:@[alarm] block:block];
}

+ (void)deleteAlarmList:(NSArray *)array block:(requestBlock)block{
    [self operateAlarmList:array mode:@2 block:block];
}

+ (void)readAlarm:(KBAlarm *)alarm block:(requestBlock)block{
    [self readAlarmList:@[alarm] block:block];
}

+ (void)readAlarmList:(NSArray *)array block:(requestBlock)block{
    [self operateAlarmList:array mode:@1 block:block];
}

+ (void)operateAlarmList:(NSArray *)array mode:(NSNumber *)mode block:(requestBlock)block{
    NSMutableArray *alarmIdArray = [NSMutableArray array];
    for (KBAlarm *alarm in array) {
        [alarmIdArray addObject:alarm.id];
    }
    NSDictionary *params = @{@"user_id":[KBUserInfo sharedInfo].user_id,
                             @"mode":mode,
                             @"alarm_id":alarmIdArray,
                             @"token":[KBUserInfo sharedInfo].token};
    [[KBHttpRequestTool sharedInstance]request:Url_EditAlarmInfo requestType:KBHttpRequestTypePost params:params overBlock:^(BOOL IsSuccess, id result) {
        
    }];
}

+ (void)updateFence:(KBFence *)fence block:(requestBlock)block{
    
}

+ (void)getDeviceTrack:(NSString *)device_sn from:(long)beginDate to:(long)endDate block:(requestBlock)block{
    NSAssert(device_sn, @"设备号不能为空");
    NSAssert(beginDate, @"");
    NSAssert(endDate, @"");
    
    NSString *userid = [[KBUserInfo sharedInfo] user_id];
    NSString *token = [KBUserInfo sharedInfo].token;
    NSDictionary *params = @{@"user_id":userid,
                             @"device_sn":device_sn,
                             @"begin":@(beginDate*1000),
                             @"end":@(endDate*1000),
                             @"page_number":@1,
                             @"page_size":@20,
                             @"app_name":app_name,
                             @"token":token};
    [[KBHttpRequestTool sharedInstance]request:Url_GetTrack requestType:KBHttpRequestTypePost params:params overBlock:^(BOOL IsSuccess, id result) {
        if(IsSuccess){
            NSDictionary *data=(NSDictionary *)result;
            NSArray *data_Array=data[@"track"];
            NSMutableArray *_statusArray = [NSMutableArray array];
            for (int i=0; i< data_Array.count; i++) {
                CCDeviceStatus * device=[[CCDeviceStatus alloc]init];
                NSString *lngstr=data_Array[i][@"lng"];
                device.lang=[lngstr doubleValue]*1e6;
                device.lat=[data_Array[i][@"lat"] doubleValue]*1e6;
                device.speed=[data_Array[i][@"speed"] floatValue];
                device.receive=[data_Array[i][@"receive"] longLongValue];
                device.sn=data_Array[i][@"deviceSn"];
                device.stayed=[data_Array[i][@"stayed"] floatValue];
                device.heading=[data_Array[i][@"direction"] floatValue];
                
            }
        }
    }];
}

+ (void)getDevicePart:(NSString *)device_sn from:(long)beginDate to:(long)endDate block:(requestBlock)block{
    NSAssert(device_sn, @"设备号不能为空");
    NSAssert(beginDate, @"");
    NSAssert(endDate, @"");
    
    NSString *userid = [[KBUserInfo sharedInfo] user_id];
    NSString *token = [KBUserInfo sharedInfo].token;
    NSDictionary *params = @{@"user_id":userid,
                             @"device_sn":device_sn,
                             @"begin":@(beginDate*1000),
                             @"end":@(endDate*1000),
                             @"app_name":app_name,
                             @"token":token};
    [[KBHttpRequestTool sharedInstance]request:Url_Getpart requestType:KBHttpRequestTypePost params:params overBlock:^(BOOL IsSuccess, id result) {
        
    }];
}

@end
