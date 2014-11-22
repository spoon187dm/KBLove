//
//  KBSpot.h
//  KBLove
//
//  Created by block on 14-10-16.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KBSpot : NSObject

@property (nonatomic, copy) NSNumber *id;
@property (nonatomic, copy) NSString *deviceSn;
@property (nonatomic, copy) NSNumber *receive;
@property (nonatomic, copy) NSNumber *lng;
@property (nonatomic, copy) NSNumber *lat;
@property (nonatomic, copy) NSNumber *speed;
@property (nonatomic, copy) NSNumber *stayed;
@property (nonatomic, copy) NSNumber *direction;
@property (nonatomic, copy) NSString *mode;


@end
