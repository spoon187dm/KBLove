//
//  NSString+WLTooll.h
//  WLLib
//
//  Created by block on 14-10-10.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Localized)
+ (NSString *)stringForLocalizedKey:(NSString *)key;
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