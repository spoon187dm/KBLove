//
//  CCTimeUtils.h
//  Tracker
//
//  Created by apple on 13-11-16.
//  Copyright (c) 2013年 Capcare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWL_TimeUtils : NSObject

+(NSInteger)year:(NSDate*)aDate;
+(NSInteger)month:(NSDate*)aDate;
+(NSInteger)day:(NSDate*)aDate;
+(NSInteger)dayOfYear:(NSDate*)aTime;
+(NSInteger)dayOfMonth:(NSDate*)aTime;

+(NSString*)formateTime:(long long)aTime aFormater:(NSString*)aFormater;
+(NSString*)formateDate:(NSDate*)aTime aFormater:(NSString*)aFormater;

+(NSString*)getFullDate:(NSDate*)aTime;

+(long long)getCurrentTime;
//+(NSDate*) today;
+(NSString*)getFullTime:(long long)aTime;

+(NSString*)getDayAndTime:(long long)aTime;
+(NSString*)getHourTime:(long long)aTime;
+(NSString*)getAppleTimeFormat:(long long)aTime;

+(long long)getTodayStartTime;
+(long long)date2Longlong:(NSDate*)time;
+(NSDate*)longlong2Date:(long long)time;

@end
