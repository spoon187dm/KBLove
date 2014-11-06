//
//  KBTracePart.m
//  KBLove
//
//  Created by block on 14/11/6.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "KBTracePart.h"

@implementation KBTracePart

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if([key isEqualToString:@"states"]){
        NSDictionary *dic1 = [value firstObject];
        NSDictionary *dic2 = [value lastObject];
        _startSpot = [[KBSimpleSpot alloc]init];
        [_startSpot setValuesForKeysWithDictionary:dic1];
        _startTime = _startSpot.receive;
        _endSpot = [[KBSimpleSpot alloc]init];
        [_endSpot setValuesForKeysWithDictionary:dic2];
        _endTime = _endSpot.receive;
    }
}

@end
