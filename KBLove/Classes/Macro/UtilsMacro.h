//
//  UtilsMacro.h
//  KBLove
//
//  Created by block on 14-10-13.
//  Copyright (c) 2014年 block. All rights reserved.
//

#ifndef KBLove_UtilsMacro_h
#define KBLove_UtilsMacro_h

/**
 @Author block, 10-13 23:10
 
 该头文件主要用于定义一些常用工具宏
 */

#if DEBUG
#define WLLog(fmt, ...) NSLog(fmt, ##__VA_ARGS__)
#else
#define WLLog(fmt, ...)
#endif

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)


#define IsIOS7 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]==7)
#define IsIOS8 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=8)
#define IOSVersion [[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]


#define FormatString(fmt, ...) [NSString stringWithFormat:fmt, ##__VA_ARGS__]


#endif
