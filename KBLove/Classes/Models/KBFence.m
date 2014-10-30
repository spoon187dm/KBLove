//
//  KBFence.m
//  KBLove
//
//  Created by block on 14-10-16.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "KBFence.h"

@implementation KBFence

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"center"]) {
        _centerPoint.x = [[value objectAtIndex:0] floatValue];
        _centerPoint.y = [[value objectAtIndex:1] floatValue];
    }
}

@end
