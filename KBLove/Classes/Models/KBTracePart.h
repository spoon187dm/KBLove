//
//  KBTracePart.h
//  KBLove
//
//  Created by block on 14/11/6.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KBSimpleSpot.h"

@interface KBTracePart : NSObject

/**
 行驶距离
 */
@property (nonatomic, copy) NSNumber *distance;
/**
 起始点
 */
@property (nonatomic, strong) KBSimpleSpot *startSpot;
/**
 结束点
 */
@property (nonatomic, strong) KBSimpleSpot *endSpot;

/**
 起始时间
 */
@property (nonatomic, copy) NSNumber *startTime;
/**
 结束时间
 */
@property (nonatomic, copy) NSNumber *endTime;


@end
