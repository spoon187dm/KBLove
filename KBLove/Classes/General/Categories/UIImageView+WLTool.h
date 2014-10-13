//
//  UIImageView+WLTool.h
//  PoorTravel
//
//  Created by block on 14-10-8.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (CreateTool)

+ (UIImageView *)imageViewWithFrame:(CGRect)frame image:(UIImage *)image;
+ (UIImageView *)imageViewWithFrame:(CGRect)frame image:(UIImage *)image hightLightImage:(UIImage *)himage;

@end
