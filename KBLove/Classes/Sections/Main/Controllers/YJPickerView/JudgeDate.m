//
//  JudgeDate.m
//  哈哈
//
//  Created by Ming on 14-11-19.
//  Copyright (c) 2014年 MJ. All rights reserved.
//

#import "JudgeDate.h"

@implementation JudgeDate

-(void)setYear:(NSString *)yearStr andMonth:(NSString *)monthStr dayCountBlick:(void (^)(int))blick
{
    int dayCount;
    switch ([monthStr intValue]) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            dayCount = 31;
            break;
        case 2:
        {
            int year = [yearStr intValue];
            if ((year%4 == 0 && year%100 != 0)|| year%400 == 0) {
                dayCount = 28;
            } else {
                dayCount = 29;
            }
        }
            break;
        case 4:
        case 6:
        case 9:
        case 11:
            dayCount = 30;
            break;
            
        default:
            break;
    }
    dayCountBlock = blick;
    dayCountBlock(dayCount);
    NSLog(@"%d",[monthStr intValue]);
    NSLog(@"%d",[yearStr intValue]);
}

@end
