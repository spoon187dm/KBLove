//
//  KBStatisticsNetTool.m
//  KBLove
//
//  Created by yuri on 14-11-21.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "KBStatisticsNetTool.h"
#import "KBHttpRequestTool.h"
#import "KBDevicesStatus.h"

@implementation KBStatisticsNetTool

+ (void)statistics:(NSDictionary *)para block:(void (^)(BOOL, id))requestBlock
{
    [[KBHttpRequestTool sharedInstance]request:Url_GetDeviceStatus requestType:KBHttpRequestTypePost params:para overBlock:^(BOOL IsSuccess, id result) {
        if (IsSuccess) {
            WLLog(@"~~获取设备状态网络请求成功");
            NSNumber *ret = result[@"ret"];
            if ([ret isEqualToNumber:@1]) {
                WLLog(@"~~获取设备状态成功");
                KBDevicesStatus *status = [[KBDevicesStatus alloc]init];
                [status setValuesForKeysWithDictionary:result[@"status"]];
                requestBlock(YES, status);
            }else{
                WLLog(@"!!获取设备状态出错");
                requestBlock(NO, [NSError errorWithDomain:@"返回结果错误" code:999 userInfo:nil]);
            }
        }else{
            WLLog(@"!!获取设备状态网络失败");
            requestBlock(NO, result);
        }
    }];
}

@end
