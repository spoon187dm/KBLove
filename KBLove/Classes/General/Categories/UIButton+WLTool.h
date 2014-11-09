//
//  UIButton+WLTool.h
//  PoorTravel
//
//  Created by block on 14-10-8.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^block)();

@interface UIButton (CreateTool)

/**
 @Author block
 
 使用frame和title初始化按钮
 
 @param frame frame
 @param title 按钮
 
 @return 按钮实例
 */
+ (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title;

/**
 @Author block
 
 使用frame,title和选择器初始化按钮
 
 @param frame    frame
 @param title    title
 @param target   代理目标
 @param selector 选择器
 
 @return 按钮实例
 */
+ (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title target:(id)target Action:(SEL)selector;

/**
 @Author block
 
 使用frame,title和回调block初始化按钮
 
 @param frame  frame
 @param title  title
 @param block  回调block
 
 @return 按钮实例
 */
+ (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title clickBlock:(void(^)(UIButton *button))block;

- (void)setClickBlock:(void(^)(UIButton *button))block;

@end
