//
//  TableViewFreshConst.h
//  TableRefresh
//
//  Created by Table on 14-1-3.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#ifdef DEBUG
#define DEBUGLog(...) NSLog(__VA_ARGS__)
#else
#define DEBUGLog(...)
#endif

#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 文字颜色
#define TableRefreshLabelTextColor RGBColor(150, 150, 150)

extern const CGFloat TableRefreshViewHeight;
extern const CGFloat TableRefreshFastAnimationDuration;
extern const CGFloat TableRefreshSlowAnimationDuration;

extern NSString *const TableRefreshBundleName;
#define TableRefreshSrcName(file) [TableRefreshBundleName stringByAppendingPathComponent:file]

extern NSString *const TableRefreshFooterPullToRefresh;
extern NSString *const TableRefreshFooterReleaseToRefresh;
extern NSString *const TableRefreshFooterRefreshing;

extern NSString *const TableRefreshHeaderPullToRefresh;
extern NSString *const TableRefreshHeaderReleaseToRefresh;
extern NSString *const TableRefreshHeaderRefreshing;
extern NSString *const TableRefreshHeaderTimeKey;

extern NSString *const TableRefreshContentOffset;
extern NSString *const TableRefreshContentSize;