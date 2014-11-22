//
//  UIView+WLTool.m
//  KBLove
//
//  Created by block on 14/10/31.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "UIView+WLTool.h"

@implementation UIView (WLTool)

-(void)setBackgroundImage:(NSString *)imagename
{
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    UIImage *image = [UIImage imageNamed:imagename];
    //    获取目标图片指定区域内容
    CGImageRef imageref = CGImageCreateWithImageInRect([image CGImage], self.bounds);
    //    转化为新图片}
    imageView.image = [UIImage imageWithCGImage:imageref];
    [self addSubview:imageView];
}
@end
