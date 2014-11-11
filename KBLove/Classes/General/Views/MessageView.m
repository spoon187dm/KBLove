//
//  MessageView.m
//  DrawRect
//
//  Created by 1124 on 14/11/10.
//  Copyright (c) 2014年 Dx. All rights reserved.
//

#import "MessageView.h"

@implementation MessageView
{
    NSString *_contentString;
    NSMutableArray *_nameArr;
    NSMutableArray *_imageArr;
    CGFloat _maxwidth;
    NSDictionary *_sDic;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (id)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"Face" ofType:@"plist"];
        NSDictionary *dic=[NSDictionary dictionaryWithContentsOfFile:path];
        _nameArr=[[NSMutableArray alloc]init];
        _imageArr=[[NSMutableArray alloc]init];
        for (int i=0; i<105; i++) {
            //NSInteger hehe=1000+i;
            NSString *str=[NSString stringWithFormat:@"%d",1000+i];
            [_imageArr addObject:[str substringFromIndex:1]];
            
            // self.frame.size.width
        }
        for (int j=0; j<_imageArr.count; j++) {
            [_nameArr addObject:[dic objectForKey:_imageArr[j]]];
        }
    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
    NSRange startran=NSMakeRange(0, 1);
    CGPoint currentpoint=CGPointMake(0, 0);
    CGSize imageSize=CGSizeMake(25, 25);
    CGSize size;
    if (_contentString) {
        for (int i=0; i<_contentString.length; i++) {
            NSString *onestr=[_contentString substringWithRange:startran];
            NSLog(@"%@",onestr);
            size=[onestr sizeWithAttributes:_sDic];
            if ([onestr isEqualToString:@"["]) {
                NSRange ran=[_contentString rangeOfString:@"]" options:NSCaseInsensitiveSearch range:NSMakeRange(startran.location+1, _contentString.length-startran.location-1)];
                NSString *smileStr=[_contentString substringWithRange:NSMakeRange(startran.location+1, ran.location-startran.location-1)];
                NSLog(@"%@",smileStr);
                if ([_nameArr containsObject:smileStr]) {
                    
                    NSString *imagename=_imageArr[[_nameArr indexOfObject:smileStr]];
                    UIImage *image=[UIImage imageNamed:imagename];
                    size=imageSize;
                    if ((currentpoint.x+size.width)>_maxwidth) {
                        if (size.height>imageSize.height) {
                            currentpoint.y+=size.height;
                        }else
                        {
                            currentpoint.y+=imageSize.height;
                        }
                        currentpoint.x=0;
                    }else
                    {
                        
                    }
                    [image drawInRect:CGRectMake(currentpoint.x, currentpoint.y, size.width, size.height)];
                    currentpoint.x+=size.width;
                    startran.location=ran.location+1;
                    i=(int)startran.location-1;
                }else
                {
                    if ((currentpoint.x+size.width)>_maxwidth) {
                        if (size.height>imageSize.height) {
                            currentpoint.y+=size.height;
                        }else
                        {
                            currentpoint.y+=imageSize.height;
                        }
                        currentpoint.x=0;
                    }else
                    {
                        
                    }
                    
                    [onestr drawInRect:CGRectMake(currentpoint.x, currentpoint.y, size.width, size.height) withAttributes:_sDic];
                    currentpoint.x+=size.width;
                    startran.location+=1;
                }
                
                
            }else
            {
                if ((currentpoint.x+size.width)>_maxwidth) {
                    if (size.height>imageSize.height) {
                        currentpoint.y+=size.height;
                    }else
                    {
                        currentpoint.y+=imageSize.height;
                    }
                    currentpoint.x=0;
                }else
                {
                    
                }
                
                [onestr drawInRect:CGRectMake(currentpoint.x, currentpoint.y, size.width, size.height) withAttributes:_sDic];
                currentpoint.x+=size.width;
                startran.location+=1;
            }
            
        }
    }
}
- (CGSize)getAllSize
{
    
    CGSize allsize=CGSizeMake(0, 30);
    NSRange startran=NSMakeRange(0, 1);
    CGPoint currentpoint=CGPointMake(0, 0);
    CGSize imageSize=CGSizeMake(25, 25);
    CGSize size;
    NSString *onestr1=[_contentString substringWithRange:startran];
    size=[onestr1 sizeWithAttributes:_sDic];
    if (size.height>imageSize.height) {
        allsize.height=size.height;
    }else
    {
        allsize.height=imageSize.height;
    }
    
    if (_contentString) {
        for (int i=0; i<_contentString.length; i++) {
            NSString *onestr=[_contentString substringWithRange:startran];
            NSLog(@"%@",onestr);
            size=[onestr sizeWithAttributes:_sDic];
            if ([onestr isEqualToString:@"["]) {
                NSRange ran=[_contentString rangeOfString:@"]" options:NSCaseInsensitiveSearch range:NSMakeRange(startran.location+1, _contentString.length-startran.location-1)];
                NSString *smileStr=[_contentString substringWithRange:NSMakeRange(startran.location+1, ran.location-startran.location-1)];
                NSLog(@"%@",smileStr);
                if ([_nameArr containsObject:smileStr]) {
                    
                    //                    NSString *imagename=_imageArr[[_nameArr indexOfObject:smileStr]];
                    //                    UIImage *image=[UIImage imageNamed:imagename];
                    size=imageSize;
                    if ((currentpoint.x+size.width)>_maxwidth) {
                        if (size.height>imageSize.height) {
                            currentpoint.y+=size.height;
                            
                        }else
                        {
                            currentpoint.y+=imageSize.height;
                        }
                        allsize.height=currentpoint.y+(size.height>imageSize.height?size.height:imageSize.height);
                        currentpoint.x=0;
                    }else
                    {
                        
                    }
                    //                    [image drawInRect:CGRectMake(currentpoint.x, currentpoint.y, size.width, size.height)];
                    currentpoint.x+=size.width;
                    if (allsize.width<currentpoint.x) {
                        allsize.width=currentpoint.x;
                    }
                    startran.location=ran.location+1;
                    i=(int)startran.location-1;
                }else
                {
                    if ((currentpoint.x+size.width)>_maxwidth) {
                        if (size.height>imageSize.height) {
                            currentpoint.y+=size.height;
                        }else
                        {
                            currentpoint.y+=imageSize.height;
                        }
                        allsize.height=currentpoint.y+(size.height>imageSize.height?size.height:imageSize.height);
                        currentpoint.x=0;
                    }else
                    {
                        
                    }
                    
                    //                    [onestr drawInRect:CGRectMake(currentpoint.x, currentpoint.y, size.width, size.height) withAttributes:_sDic];
                    currentpoint.x+=size.width;
                    if (allsize.width<currentpoint.x) {
                        allsize.width=currentpoint.x;
                    }
                    startran.location+=1;
                }
                
                
            }else
            {
                if ((currentpoint.x+size.width)>_maxwidth) {
                    if (size.height>imageSize.height) {
                        currentpoint.y+=size.height;
                    }else
                    {
                        currentpoint.y+=imageSize.height;
                    }
                    allsize.height=currentpoint.y+(size.height>imageSize.height?size.height:imageSize.height);
                    currentpoint.x=0;
                }else
                {
                    
                }
                currentpoint.x+=size.width;
                if (allsize.width<currentpoint.x) {
                    allsize.width=currentpoint.x;
                }
                startran.location+=1;
            }
            
        }
    }
    
    return allsize;
}
- (void)setString:(NSString *)str WithMaxWidth:(CGFloat)maxwidth AndAttributris:(NSDictionary *)sdic
{
    _contentString=str;
    self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0 ];
    _maxwidth=maxwidth;
    _sDic=sdic;
    CGRect rec=self.frame;
    rec.size=[self getAllSize];
    self.frame=rec;
    [self setNeedsLayout];
    [self setNeedsDisplay];
}
@end
