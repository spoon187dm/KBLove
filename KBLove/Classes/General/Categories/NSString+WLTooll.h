//
//  NSString+WLTooll.h
//  WLLib
//
//  Created by block on 14-10-10.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Localized)
/**
 获取本地化的字符串
 
 @param key 本地化字符串对应的key
 
 @return 对应的字符
 */
+ (NSString *)stringForLocalizedKey:(NSString *)key;
@end

@interface NSString (wldate)
+ (NSString *)stringFromDateNumber:(NSNumber *)number;
@end

@interface NSString (Font)

/**
 *  获取字符串应用到Label中的Size
 *
 *  @param font  字体大小
 *  @param width label宽度最大值
 *
 *  @return 返回对应的Size
 */
- (CGSize)sizeToFont:(UIFont*)font WithWidth:(CGFloat)width;

/**
 *  判断是否是邮箱
 *
 *  @return 结果
 */
-(BOOL)isValidateEmail;
/**
 *  判断是否是手机号
 *
 *  @return 结果
 */
-(BOOL) isValidateMobile;
/**
 *  判断车牌号是否合法
 *
 *  @return 结果
 */
- (BOOL) isValidateCarNo;
@end

@interface NSString (NSString_Hashing)

- (NSString *)MD5Hash;

@end

/*董新扩展2014-10-16*/
@interface NSString (WMString_Utilities)
/*!
 @function   string2Date:
 @abstract   Change given string to NSDate
 @discussion If the given str is wrong, should return the current system date
 @param      dateStr A string include the date like "2009-11-09 11:14:41"
 @result     The NSDate object with given format
 */

+ (NSDate *)string2Date:(NSString *)dateStr;

/*!
 @function   stringFromCurrent:
 @abstract   Change given date string to "xxx ago" format
 @discussion If the given str is wrong, should return the current date
 @param      dateStr A string include the date like "2009-11-09 11:14:41" at least 10 characters
 @result     The string with "xxx ago", xxx: years, months, days, hours, minutes, seconds
 */
+ (NSString *)stringFromCurrent:(NSString *)dateStr;

//时间戳转化为时间字符串
+(NSString*)timeStamp:(NSString *)stamp;
+(NSString*)timeStampWithYMD:(NSString *)stamp;
+ (NSString*)timeStampWithHM:(NSString *)stamp;
//生成当前时间戳,两种格式
+(NSString*)TimeJab;
+ (long long int)TimeJabLong;

@end