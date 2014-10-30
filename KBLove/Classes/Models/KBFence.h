//
//  KBFence.h
//  KBLove
//
//  Created by block on 14-10-16.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @Author block, 10-16 12:10
 
 围栏
 
 */
@interface KBFence : NSObject

@property (nonatomic, copy) NSString *device_sn;
@property (nonatomic, copy) NSNumber *radius;
@property (nonatomic, assign) CGPoint centerPoint;
@property (nonatomic, copy) NSNumber *type;
@property (nonatomic, copy) NSNumber *out;
@property (nonatomic, copy) id region;

@end
