//
//  NSString+WLTooll.m
//  WLLib
//
//  Created by block on 14-10-10.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "NSString+WLTooll.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Localized)

+ (NSString *)stringForLocalizedKey:(NSString *)key{
    return NSLocalizedStringFromTable(key, @"InfoPlist", nil);
}

@end

#pragma mark -
#pragma mark Font
@implementation NSString (Font)

- (CGSize)sizeToFont:(UIFont *)font WithWidth:(CGFloat)width{
    CGSize size;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    //optinos 前两个参数是匹配换行方式去计算，最后一个参数是匹配字体去计算
    //attributes 传入使用的字体
    //boundingRectWithSize 计算的范围
    size = [self boundingRectWithSize:CGSizeMake(width,999) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size;
}

/*邮箱验证 MODIFIED BY HELENSONG*/
-(BOOL)isValidateEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}


-(BOOL) isValidateMobile
{
    if (!self) {
        return NO;
    }
    if ([self length] == 0) {
        return NO;
    }
    
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:self];
}

/*车牌号验证 MODIFIED BY HELENSONG*/
- (BOOL) isValidateCarNo{
    NSString *carRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:self];
}

@end

#pragma mark -
#pragma mark HashMD5
@implementation NSString (NSString_Hashing)

- (NSString *)MD5Hash
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}
@end

#define MINUTES		60
#define HOURS		3600
#define DAYS		86400
#define MONTHS		(86400 * 30)
#define YEARS		(86400 * 30 * 12)

@implementation NSString (WMString_Utilities)

/*!
 @function   string2Date:
 @abstract   Change given string to NSDate
 @discussion If the given str is wrong, should return the current system date
 @param      dateStr A string include the date like "2009-11-09 11:14:41"
 @result     The NSDate object with given format
 */
+ (NSDate *)string2Date:(NSString *)dateStr {
    
    if (10 > [dateStr length]) {
        
        return [NSDate date];
    }
    NSRange range;
    NSString *year, *month, *day, *hr, *mn, *sec;
    range.location = 0;
    range.length = 4;
    year = [dateStr substringWithRange:range];
    
    range.location = 5;
    range.length = 2;
    month = [dateStr substringWithRange:range];
    
    range.location = 8;
    range.length = 2;
    day = [dateStr substringWithRange:range];
    
    if (11 < [dateStr length]) {
        
        range.location = 11;
        range.length = 2;
        hr = [dateStr substringWithRange:range];
    } else {
        hr = @"0";
    }
    
    if (14 < [dateStr length]) {
        
        range.location = 14;
        range.length = 2;
        mn = [dateStr substringWithRange:range];
    } else {
        mn = @"0";
    }
    
    if (17 < [dateStr length]) {
        
        range.location = 17;
        range.length = 2;
        sec = [dateStr substringWithRange:range];
    } else {
        sec = @"0";
    }
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:		[year integerValue]];
    [comps setMonth:	[month integerValue]];
    [comps setDay:		[day integerValue]];
    [comps setHour:		[hr integerValue]];
    [comps setMinute:	[mn integerValue]];
    [comps setSecond:	[sec integerValue]];
    
    NSCalendar *gregorian = [NSCalendar autoupdatingCurrentCalendar];
    NSDate *returnDate = [gregorian dateFromComponents:comps];
    //[comps release];
    return returnDate;
}

/*!
 @function   stringFromCurrent:
 @abstract   Change given date string to "xxx ago" format
 @discussion If the given str is wrong, should return the current date
 @param      dateStr A string include the date like "2009-11-09 11:14:41" at least 10 characters
 @result     The string with "xxx ago", xxx: years, months, days, hours, minutes, seconds
 */
+ (NSString *)stringFromCurrent:(NSString *)dateStr {
    
    NSDate *earlierDate = [NSString string2Date:dateStr];
    
    NSDate *sysDate = [NSDate date];
    //	 //NSLog(@"now from System [%@]", [sysDate description]);
    double timeInterval = [sysDate timeIntervalSinceDate:earlierDate];
    //	 //NSLog(@"[%f]", timeInterval);
    
    NSInteger yearsAgo = timeInterval / YEARS;
    if (1 < yearsAgo) {
        
        return [NSString stringWithFormat:@"%d 年以前", yearsAgo];
    } else if (1 == yearsAgo) {
        
        return @"1 年以前";
    }
    
    NSInteger monthsAgo = timeInterval / MONTHS;
    if (1 < monthsAgo) {
        
        return [NSString stringWithFormat:@"%d 月以前", monthsAgo];;
    } else if (1 == monthsAgo) {
        
        return [NSString stringWithFormat:@"1 月以前"];
    }
    
    NSInteger daysAgo = timeInterval / DAYS;
    if (1 < daysAgo) {
        
        return [NSString stringWithFormat:@"%d 天以前", daysAgo];
    } else if (1 == daysAgo) {
        
        return @"1 天以前";
    }
    
    NSInteger hoursAgo = timeInterval / HOURS;
    if (1 < hoursAgo) {
        
        return [NSString stringWithFormat:@"%ld 小时以前", hoursAgo];
    } else if (1 == hoursAgo) {
        
        return @"1小时以前";
    }
    
    NSInteger minutesAgo = timeInterval / MINUTES;
    if (1 < minutesAgo) {
        
        return [NSString stringWithFormat:@"%ld 分钟以前", minutesAgo];
    } else if (1 == minutesAgo) {
        
        return @"1 分钟以前";
    }
    // 1 sceond ago? we ignore this time
    return [NSString stringWithFormat:@"%ld 秒以前", (NSInteger)timeInterval];
}

//时间戳转化为时间字符串
+(NSString*)timeStamp:(NSString *)stamp{
    NSTimeInterval time=[stamp doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    return [formatter stringFromDate:detaildate];
}

+ (NSString*)timeStampWithYMD:(NSString *)stamp{
    NSTimeInterval time=[stamp doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:detaildate];
}
+ (NSString*)timeStampWithHM:(NSString *)stamp{
    NSTimeInterval time=[stamp doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm"];
    return [formatter stringFromDate:detaildate];
}

//生成时间戳
//获取当前时间戳
+(NSString*)TimeJab {
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    long long int newTime = time * 1000;
    //    timeSecond = newTime;
    NSString * timeStr = [NSString stringWithFormat:@"%lld", newTime];
    return timeStr;
}
+ (long long int)TimeJabLong
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    long long int newTime = time * 1000;
    return newTime;
}

@end