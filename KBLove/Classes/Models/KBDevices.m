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
}



@end
