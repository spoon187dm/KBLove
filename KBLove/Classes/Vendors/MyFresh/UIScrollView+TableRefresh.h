//
//  UIScrollView+TableRefresh.h
//  TableRefreshExample
//
//  Created by Table Lee on 14-5-28.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (TableRefresh)
#pragma mark - 下拉刷新
/**
 *  添加一个下拉刷新回调
 *
 *  @param callback 回调
 */
- (void)addHeaderWithCallback:(void (^)())callback;

/**
 *  添加一个下拉刷新头部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)addHeaderWithTarget:(id)target action:(SEL)action;

/**
 *  移除下拉刷新回调
 */
- (void)removeHeader;

/**
 *  主动进入刷新状态
 */
- (void)headerBeginRefreshing;

/**
 *  停止刷新状态
 */
- (void)headerEndRefreshing;

/**
 *  下拉刷新头部控件的可见性
 */
@property (nonatomic, assign, getter = isHeaderHidden) BOOL headerHidden;

#pragma mark - 上拉刷新
/**
 *  添加一个上拉刷新回调
 *
 *  @param callback 回调
 */
- (void)addFooterWithCallback:(void (^)())callback;

/**
 *  添加一个上拉刷新选择器
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)addFooterWithTarget:(id)target action:(SEL)action;

/**
 *  移除上拉刷新
 */
- (void)removeFooter;

/**
 *  主动进入上拉刷新状态
 */
- (void)footerBeginRefreshing;

/**
 *  让上拉刷新停止刷新状态
 */
- (void)footerEndRefreshing;

/**
 *  下拉刷新头部控件的可见性
 */
@property (nonatomic, assign, getter = isFooterHidden) BOOL footerHidden;
@end
