//
//  UIImageView+WLTool.m
//  PoorTravel
//
//  Created by block on 14-10-8.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "UIImageView+WLTool.h"

@implementation UIImageView (CreateTool)

+ (UIImageView *)imageViewWithFrame:(CGRect)frame image:(UIImage *)image{
    return [self imageViewWithFrame:frame image:image hightLightImage:nil];
}

+ (UIImageView *)imageViewWithFrame:(CGRect)frame image:(UIImage *)image hightLightImage:(UIImage *)himage{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    imageView.image = image;
    imageView.highlightedImage = himage;
    return imageView;
}


@end
