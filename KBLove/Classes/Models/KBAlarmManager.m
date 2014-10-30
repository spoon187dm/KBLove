//
//  KBAlarmManager.m
//  KBLove
//
//  Created by block on 14-10-16.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "KBAlarmManager.h"
#import "KBDevices.h"
#import "KBUserInfo.h"
#import "KBHttpRequestTool.h"

@implementation KBAlarmManager

static KBAlarmManager *manager = nil;
+ (KBAlarmManager *)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[KBAlarmManager alloc]init];
    });
    return manager;
}

- (void)getAlarmInfoForDevice:(KBDevices *)devices finishblock:(requestBlock)block{
    
    if (!devices) {
        return;
    }
    NSString *userid = [KBUserInfo sharedInfo].user_id;
    NSString *deviceSn = devices.sn;
    NSString *token = [KBUserInfo sharedInfo].token;
    NSDictionary *params = @{
                             @"user_id":userid,
                             @"device_sn":deviceSn,
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

- (void)deleteAlarm:(KBAlarm *)alarm finishBlock:(requestBlock)block{
    if (!alarm) {
        return;
    }
    NSString *userid = [KBUserInfo sharedInfo].user_id;
    NSString *alarm_id = [NSString stringWithFormat:@"%@",alarm.id];
    NSString *token = [KBUserInfo sharedInfo].token;
    NSDictionary *params = @{
                             @"user_id":userid,
                             @"alarm_id":alarm_id,
                             
                             @"token":token
                             };
    [[KBHttpRequestTool sharedInstance]request:Url_EditAlarmInfo requestType:KBHttpRequestTypePost params:params overBlock:^(BOOL IsSuccess, id result) {
        
    }];
}

@end
