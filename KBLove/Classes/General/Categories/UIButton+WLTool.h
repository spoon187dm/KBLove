//
//  UIButton+WLTool.h
//  PoorTravel
//
//  Created by block on 14-10-8.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CreateTool)

+ (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title;
+ (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title target:(id)target Action:(SEL)selector;

@end
