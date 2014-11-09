//
//  UIAlertView+EasyTool.m
//  KBLove
//
//  Created by block on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "UIAlertView+EasyTool.h"
//#import <ReactiveCocoa.h>
#import <objc/runtime.h>
static char * const kWL_block_AlerViewClick = "kWL_block_AlerViewClick";
@implementation UIAlertView (EasyTool)

+ (void)showWithTitle:(NSString *)title Message:(NSString *)message cancle:(NSString *)cancle otherbutton:(NSString *)other block:(alertClickblock)block{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:cancle otherButtonTitles:other, nil];
//    [[alert rac_buttonClickedSignal] subscribeNext:^(NSNumber *index){
//        if (block) {
//            block([index integerValue]);
//        }
//    }];
    [alert setDelegate:self];
    objc_setAssociatedObject(alert, kWL_block_AlerViewClick, block, OBJC_ASSOCIATION_COPY);
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    alertClickblock block = objc_getAssociatedObject(alertView, kWL_block_AlerViewClick);
    if (block) {
        block(buttonIndex);
    }
}

@end
