//
//  BannerView.h
//  KBLove
//
//  Created by 吴铭博 on 14-10-11.
//  Copyright (c) 2014年 block. All rights reserved.
//  首页滚动横幅

#import <UIKit/UIKit.h>

@interface BannerView : UIView<UIScrollViewDelegate>
{
    NSArray *_imageArray;//图片数组
    UIPageControl *_pageControl;
    NSTimer *_timer;
    
}

@property (strong, nonatomic) UIScrollView *scrollView;

/**
 *  为首页滚动横幅赋值，并且设置是否自动滚动
 *
 *  @param imageArray   滚动横幅内容
 *  @param isAutoScroll 是否自动滚动
 */
- (void)setImageWithArray:(NSArray *)imageArray andIsAutoScroll:(BOOL)isAutoScroll;

@end
