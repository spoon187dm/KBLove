//
//  UIButton+WLTool.m
//  PoorTravel
//
//  Created by block on 14-10-8.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "UIButton+WLTool.h"

@implementation UIButton (CreateTool)

+ (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title{
    return [self buttonWithFrame:frame title:title target:nil Action:nil];
}

+ (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title target:(id)target Action:(SEL)selector{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

@end
