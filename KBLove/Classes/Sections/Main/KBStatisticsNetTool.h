//
//  KBStatisticsNetTool.h
//  KBLove
//
//  Created by yuri on 14-11-21.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 cmd        int     2403
 user_id    string  用户id
 target_id  string  下属id
 device_sn  string  设备序列号
 begin      long    时间起始点
 end        long    时间结束点
 app_name   string  区分业务类型
 */

@interface KBStatisticsNetTool : NSObject

+ (void)statistics:(NSDictionary *)para block:(void (^)(BOOL isSuccess, id result))requestBlock;

@end
