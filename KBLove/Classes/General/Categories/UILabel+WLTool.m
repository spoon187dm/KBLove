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
-(void)AdjustFontSizeWithMinSize:(CGFloat) min AndMaxSize:(CGFloat) max IsFull:(BOOL)isfull
{
    
    self.numberOfLines=0;
    self.lineBreakMode=NSLineBreakByCharWrapping;
    NSLog(@"%f",self.frame.size.width);
    
    //    CGSize Allsize=[self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(self.frame.size.width, 1000) lineBreakMode:NSLineBreakByCharWrapping];
    NSDictionary *dic =[NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName, nil];
    
    CGSize Allsize=[self getSizeWithattributes:dic];
    
    if (Allsize.height>self.frame.size.height) {
        [self AdjustFontSizeWithMinSize:min AndMaxSize:max];
    }else
    {
        if (isfull) {
            [self AdjustFontSizeWithMinSize:min AndMaxSize:max];
        }
    }
    
}
- (void)AdjustCurrentAttributeTextWithLineSpacing:(NSInteger)space
{
    if (self.text) {
        self.numberOfLines=0;
        self.lineBreakMode=NSLineBreakByCharWrapping;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        
        [paragraphStyle setLineSpacing:space];//调整行间距
        //
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
        self.attributedText = attributedString;
        
        NSDictionary *dic =[NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName,paragraphStyle,NSParagraphStyleAttributeName, nil];
        
        CGSize Allsize=[self getSizeWithattributes:dic];
        
        self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, Allsize.width, Allsize.height);
        
    }else
    {
        
    }
}
- (void)AdjustCurrentFont
{
    [self AdjustWithFont:self.font];
}
- (void)AdjustWithFont:(UIFont *)font
{
    self.numberOfLines=0;
    self.font=font;
    NSDictionary *dic =[NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName, nil];
    
    CGSize Allsize=[self getSizeWithattributes:dic];
    NSLog(@"%@",self.text);
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, Allsize.width, Allsize.height);
    self.lineBreakMode=NSLineBreakByCharWrapping;
    
}
- (CGSize)getSizeWithattributes:(NSDictionary *)dic
{
    CGSize Allsize=[self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, 1990) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|
                    NSStringDrawingUsesFontLeading       attributes:dic context:nil].size;
    return Allsize;
}
- (void)SetBorderWithcornerRadius:(CGFloat)radius BorderWith:(CGFloat)width AndBorderColor:(UIColor *)color
{
    self.layer.cornerRadius=radius;
    self.layer.borderWidth=width;
    self.layer.borderColor=[color CGColor];
}
-(void)AdjustFontSizeWithMinSize:(CGFloat) min AndMaxSize:(CGFloat) max
{
    BOOL isad=NO;
    
    for (CGFloat i=max; i>=min; i--) {
        NSDictionary *dic =[NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName, nil];
        CGSize Allsize=[self getSizeWithattributes:dic];
        if (Allsize.height<=self.frame.size.height) {
            isad=YES;
            self.font=[UIFont systemFontOfSize:i];
            break;
        }
    }
    if (!isad) {
        self.font=[UIFont systemFontOfSize:min];
    }
}



@end
