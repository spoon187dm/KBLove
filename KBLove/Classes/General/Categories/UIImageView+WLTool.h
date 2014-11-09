//
//  UIImageView+WLTool.h
//  PoorTravel
//
//  Created by block on 14-10-8.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (CreateTool)

/**
 @Author block
 
 获取使用指定frame和图片初始化的实例
 
 @param frame frame
 @param image image
 
 @return 实例
 */
+ (UIImageView *)imageViewWithFrame:(CGRect)frame image:(UIImage *)image;

/**
 @Author block
 
 获取使用指定frame image和hightlight的图片实例
 
 @param frame  frame
 @param image  image
 @param himage himage
 
 @return 实例
 */
+ (UIImageView *)imageViewWithFrame:(CGRect)frame image:(UIImage *)image hightLightImage:(UIImage *)himage;

@end
