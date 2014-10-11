//
//  BannerView.m
//  KBLove
//
//  Created by 吴铭博 on 14-10-11.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "BannerView.h"
//#import "UIImageView+AFNetworking.h"

@implementation BannerView

/**
 *  从storyboard创建时调用
 */
- (void)awakeFromNib{
    // 添加ScrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    
    // 添加PageControl
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.center = CGPointMake(self.width * 0.5, self.height - 10);
    pageControl.bounds = CGRectMake(0, 0, 320, 20);
    
    // 设置非选中页的圆点颜色
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    // 设置选中页的圆点颜色
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    // 禁止默认的点击功能
    pageControl.enabled = NO;
    [self addSubview:pageControl];
    _pageControl = pageControl;
    // 将scrollView添加到视图
    [self insertSubview:_scrollView atIndex:0];
}

/**
 *  当被布局到某个view或者调用setNeedsDisplay时调用
 */
- (void)layoutSubviews {

    _scrollView.frame = CGRectMake(0, 0, self.width, self.height);
    
    _pageControl.center = CGPointMake(self.width * 0.5, self.height - 10);
    _pageControl.bounds = CGRectMake(0, 0, 320, 20);
    
}

//给banner赋值
- (void)setImageWithArray:(NSArray *)imageArray andIsAutoScroll:(BOOL)isAutoScroll{
    CGFloat w = self.size.width;
    CGFloat h = self.size.height;
    
    _imageArray = imageArray;
    
    // 添加内容图片视图imageView
    for (int i = 0; i<[_imageArray count]; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * w, 0, w, h)];
        imageView.image = [UIImage imageNamed:[_imageArray objectAtIndex:i]];
        [_scrollView addSubview:imageView];
        
    }
    // 在后面多加一页 实现循环滚动
    UIImageView *fristImageView = [[UIImageView alloc] initWithFrame:CGRectMake([_imageArray count] * w, 0, w, h)];
    fristImageView.image = [UIImage imageNamed:[_imageArray objectAtIndex:0]];
    
    [_scrollView addSubview:fristImageView];
    // 设置ScrollView属性 contentSize 加上最后多加的那一页
    _scrollView.contentSize = CGSizeMake(([_imageArray count] +1 ) * w, h);
    
    // 一共显示多少个圆点（多少页）
    _pageControl.numberOfPages = [_imageArray count];
    
    //是否自动滚动
    if (isAutoScroll) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(autoScroll:) userInfo:_scrollView repeats:YES];
    }
    
}

// 定时器响应方法，实现自动滚动
-(void)autoScroll:(NSTimer *)timer {
    CGPoint offset = _scrollView.contentOffset;
    CGFloat width = _scrollView.frame.size.width;
    // 设置偏移量到下一页
    offset.x += width;
    [_scrollView setContentOffset:offset animated:YES];
}

#pragma mark - UIScrollView Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat width = _scrollView.frame.size.width;
    // 循环滚动
    if (_scrollView.contentOffset.x / width == [_imageArray count]) {
        // 当翻转到‘假’的第一页，设置偏移量到真实的第一页 不开启动画
        [_scrollView setContentOffset:CGPointZero animated:NO];
    }
    if (_scrollView.contentOffset.x / width <0) {
        // 当翻转到‘假’的第一页，设置偏移量到真实的第一页 不开启动画
        [_scrollView setContentOffset:CGPointMake(320 * 5 + 300, 0) animated:NO];
    }
    // 根据偏移量计算页码
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    _pageControl.currentPage = page%[_imageArray count];
    if (page >= 6) {
        page = 0;
    }
    
}

@end
