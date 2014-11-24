//
//  KBDevices.m
//  KBLove
//
//  Created by block on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "KBDevices.h"
#import "KBHttpRequestTool.h"
#import "KBDevicesStatus.h"
@implementation KBDevices

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"position"]) {
        _devicesStatus = [[ KBDevicesStatus alloc]init];
        [_devicesStatus setValuesForKeysWithDictionary:value];
    }
    
    if ([key isEqualToString:@"fence"]) {
        _device_fence = [[KBFence alloc]init];
        [_device_fence setValuesForKeysWithDictionary:value];
    }
}

- (UIImage *)getDefaultHeadImage{
    return [UIImage imageNamed:@"页面列表1_22"];
}

- (UIImage *)getDeviceTypeImage{
    switch ([_type intValue]) {
        case 1:{
            return kImage_car;
        }
            break;
        case 2:{
            return  kImage_pet;
        }
            break;
        case 3:{
            return kImage_person;
        }
            break;
        default:{
            return nil;
        }
            break;
    }
}

- (UIImage *)getDeviceAlarmStatusImage{
    if ([_devicesStatus.alarm integerValue]>0) {
        return kImage_deviceAlarm_yes;
    }else{
        return kImage_deviceAlarm_no;
    }
}

- (BOOL)isMoving{
    if ([_devicesStatus.speed floatValue]>=1) {
        return YES;
    }else{
        return NO;
    }
}

@end
