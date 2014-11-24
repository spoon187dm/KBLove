//
//  KBDevicesStatus.h
//  KBLove
//
//  Created by block on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KBDevicesStatus : NSObject

@property (nonatomic, copy) NSNumber *alarm;
@property (nonatomic, copy) NSNumber *battery;
@property (nonatomic, copy) NSString *deviceSn;
@property (nonatomic, copy) NSNumber *direction;
@property (nonatomic, copy) NSNumber *flow;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSNumber *lat;
@property (nonatomic, copy) NSNumber *lng;
@property (nonatomic, copy) id mode;
@property (nonatomic, copy) NSNumber *receive;
@property (nonatomic, copy) NSNumber *speed;
@property (nonatomic, copy) id stamp;
@property (nonatomic, copy) NSNumber *status;
@property (nonatomic, copy) NSNumber *stayed;
@property (nonatomic, copy) NSNumber *systime;


@end
