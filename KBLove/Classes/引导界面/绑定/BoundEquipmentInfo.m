//
//  BoundEquipmentInfo.m
//  KBLove
//
//  Created by qianfeng on 38-1-1.
//  Copyright (c) 2038年 block. All rights reserved.
//

#import "BoundEquipmentInfo.h"

@implementation BoundEquipmentInfo

+ (id)sharedInstance
{
    static BoundEquipmentInfo * info = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        info = [[[self class] alloc] init];
    });
    
    return info;
}

@end
