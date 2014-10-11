//
//  UILabel+WLTool.m
//  PoorTravel
//
//  Created by block on 14-10-8.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "UILabel+WLTool.h"

@implementation UILabel (CreateTool)

+ (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text{
    return [self labelWithFrame:frame text:text font:15];
}
+ (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text font:(CGFloat)font{
    return [self labelWithFrame:frame text:text fontName:@"Arial" fontSize:font];
}
+ (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text fontName:(NSString *)fontName fontSize:(CGFloat)fontSize{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = text;
    label.font = [UIFont fontWithName:fontName size:fontSize];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (void)addjustSizeWithMaxWith:(CGFloat)width{
    CGSize size = [self.text sizeToFont:self.font WithWidth:width];
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
@end
