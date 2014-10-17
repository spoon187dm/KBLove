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
/*2014-10-16
 *董新扩展
 *使用时须对Lable先设置大小，赋值之后调用
 */
//lable自适应字体
- (void)AdjustCurrentFont;
- (void)AdjustWithFont:(UIFont *)font;
//Lable自适应内容，可设置间距
- (void)AdjustCurrentAttributeTextWithLineSpacing:(NSInteger)space;
//lable不变情况下,在一定范围内动态调节字体
-(void)AdjustFontSizeWithMinSize:(CGFloat) min AndMaxSize:(CGFloat) max IsFull:(BOOL)isfull;
//设置边框弧度，宽度，颜色
- (void)SetBorderWithcornerRadius:(CGFloat)radius BorderWith:(CGFloat)width AndBorderColor:(UIColor *)color;

@end
