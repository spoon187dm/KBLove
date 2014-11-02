//
//  CCTimeUtils.m
//  Tracker
//
//  Created by apple on 13-11-16.
//  Copyright (c) 2013年 Capcare. All rights reserved.
//

#import "CCTimeUtils.h"

@implementation CCTimeUtils

+(NSInteger)year:(NSDate*)aDate
{
	unsigned units = NSYearCalendarUnit;
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [calendar components:units fromDate:aDate];
	return [components year];
}

+(NSInteger)month:(NSDate*)aDate
{
	unsigned units = NSMonthCalendarUnit;
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [calendar components:units fromDate:aDate];
	return [components month];
}

+(NSInteger)day:(NSDate*)aDate
{
	unsigned units = NSDayCalendarUnit;
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [calendar components:units fromDate:aDate];
	return [components day];
}

+(long long)getCurrentTime
{
    return (long long)([[NSDate date] timeIntervalSince1970] * 1000.0);
//    return (long long)([[CCTimeUtils today] timeIntervalSince1970] * 1000.0);
}

//+(NSDate*) today
//{
//    NSDate* sourceDate = [NSDate date];
//    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
//    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
//    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
//    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
//    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
//    return  [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
//}

+(NSString*) formateTime:(long long)aTime aFormater:(NSString*)aFormater
{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:aFormater];
    return [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:aTime / 1000.0]];
}

+(NSString*)formateDate:(NSDate*)aTime aFormater:(NSString*)aFormater
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:aFormater];
    return [dateFormatter stringFromDate:aTime];
}

+(NSString*)getFullDate:(NSDate*)aTime
{
    return [CCTimeUtils formateDate:aTime aFormater:@"yyyy年MM月dd日 HH时mm分"];
}

+(NSString*)getFullTime:(long long)aTime
{
    //实例化一个NSDateFormatter对象
    return [CCTimeUtils formateTime:aTime aFormater:@"yyyy年MM月dd日 HH时mm分"];
}

+(NSString*)getDayAndTime:(long long)aTime
{
    return [CCTimeUtils formateTime:aTime aFormater:@"MM-dd HH:mm"];
}

+(NSInteger) dayOfYear:(NSDate*)aTime
{
    NSUInteger dayOfYear = [[NSCalendar currentCalendar] ordinalityOfUnit:NSDayCalendarUnit
                                                                   inUnit:NSYearCalendarUnit forDate:aTime];
    return dayOfYear;
}

+(NSString*)getHourTime:(long long)aTime
{
    return [CCTimeUtils formateTime:aTime aFormater:@"HH:mm"];
}

+(NSInteger)dayOfMonth:(NSDate*)aTime
{
    NSRange days = [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit
                                  inUnit:NSMonthCalendarUnit
                                 forDate:aTime];
    return days.length;
}

+(NSString*)getAppleTimeFormat:(long long)aTime
{
    NSDate* time = [NSDate dateWithTimeIntervalSince1970:aTime / 1000.0];
    int year = [CCTimeUtils year:time];
//    int month = [CCTimeUtils month:time];
    int dayY = [CCTimeUtils dayOfYear:time];
//    int dayM = [CCTimeUtils dayOfMonth:time];

    NSDate *today = [NSDate date];
    int yearN = [CCTimeUtils year:today];
    int dayN = [CCTimeUtils dayOfYear:today];
    
    NSMutableString* ret = [[NSMutableString alloc]init];
    if (yearN > year) {
        [ret appendString:[CCTimeUtils formateTime:aTime aFormater:@"yyyy.MM.dd"]];
    } else {
        if (dayN == dayY) {
            [ret appendString:@"今天"];
        } else if (dayN - dayY == 1) {
            [ret appendString:@"昨天"];
        } else {
            [ret appendString:[CCTimeUtils formateTime:aTime aFormater:@"MM.dd"]];
        }
    }
    
    NSString* housrDes = [CCTimeUtils getHourTime:aTime];
    [ret appendString:@" "];
    [ret appendString:housrDes];
    return [NSString stringWithString:ret];
}

+(long long)getTodayStartTime
{
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *nowComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:today];
    today = [calendar dateFromComponents:nowComponents];
    return [today timeIntervalSince1970] * 1000;
}

+(long long)date2Longlong:(NSDate*)time
{
    return [time timeIntervalSince1970] * 1000;
}

+(NSDate*)longlong2Date:(long long)time
{
   return [NSDate dateWithTimeIntervalSince1970:time / 1000.0];
}

@end
