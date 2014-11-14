//
//  UIAlertView+EasyTool.m
//  KBLove
//
//  Created by block on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "UIAlertView+EasyTool.h"
#import <ReactiveCocoa.h>
@implementation UIAlertView (EasyTool)

+ (void)showWithTitle:(NSString *)title Message:(NSString *)message cancle:(NSString *)cancle otherbutton:(NSString *)other block:(alertClickblock)block{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:cancle otherButtonTitles:other, nil];
    [[alert rac_buttonClickedSignal] subscribeNext:^(NSNumber *index){
        if (block) {
            block([index integerValue]);
        }
    }];
    [alert show];
}

@end
