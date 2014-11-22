//
//  KBAlarm.m
//  KBLove
//
//  Created by block on 14-10-16.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "KBAlarm.h"

@implementation KBAlarm

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
//1 出围栏报警
//2 进围栏报警
//3 低电报警
//4 超速报警
//5 SOS报警
//6 振动报警
//7 外电报警
//8 防盗报警
//9 低速报警
//10蓝牙
//11流量;
//12脱离;
//13移动
- (NSString *)getTypeString{
    NSArray *array = @[@"出围栏报警",@"进围栏报警",@"低电报警",@"超速报警",@"SOS报警",@"振动报警",@"外电报警",@"防盗报警",@"低速报警",@"蓝牙",@"流量",@"脱离",@"移动"];
    NSInteger index = [_type integerValue];
    return [array objectAtIndex:index];
}

@end
