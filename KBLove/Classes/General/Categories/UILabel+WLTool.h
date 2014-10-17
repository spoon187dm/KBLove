//
//  UILabel+WLTool.h
//  PoorTravel
//
//  Created by block on 14-10-8.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (CreateTool)

+ (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text;
+ (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text font:(CGFloat)font;
+ (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text fontName:(NSString *)fontName fontSize:(CGFloat)fontSize;

/**
 *  用给定的最大宽度调整label大小
 *
 *  @param width 最大限制宽度
 */
- (void)addjustSizeWithMaxWith:(CGFloat)width;

@end
