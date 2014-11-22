//
//  JudgeDate.h
//  哈哈
//
//  Created by Ming on 14-11-19.
//  Copyright (c) 2014年 MJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JudgeDate : NSObject

{
    void (^dayCountBlock)(int);
}
-(void)setYear:(NSString *)yearStr andMonth:(NSString *)monthStr dayCountBlick:(void (^)(int))blick;

@end
