//
//  KBAlarm.h
//  KBLove
//
//  Created by block on 14-10-16.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KBAlarm : NSObject

@property (nonatomic, copy) NSNumber *id;
@property (nonatomic, copy) NSString *deviceSn;
@property (nonatomic, copy) NSNumber *lng;
@property (nonatomic, copy) NSNumber *lat;
@property (nonatomic, copy) NSNumber *speed;
@property (nonatomic, copy) NSNumber *read;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSNumber *type;
@property (nonatomic, copy) NSNumber *battery;
@property (nonatomic, copy) NSNumber *flow;
@property (nonatomic, copy) NSNumber *level;

@end
