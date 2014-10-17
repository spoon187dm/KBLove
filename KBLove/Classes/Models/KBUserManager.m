//
//  KBAccount.m
//  KBLove
//
//  Created by block on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "KBUserManager.h"
#import "KBHttpRequestTool.h"
#import "KBDevices.h"
#import "KBDevicesStatus.h"
@interface KBUserManager ()

@property (nonatomic, strong) KBUserInfo *userInfo;
@property (nonatomic, strong) NSMutableArray *devicesArray;

@end

@implementation KBUserManager

- (id)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    _userInfo = [KBUserInfo sharedInfo];
    return self;
}

static KBUserManager *account = nil;
+ (KBUserManager *)sharedAccount{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        account = [[self alloc]init];
    });
    return account;
}

- (void)login:(requestBlock)block{
    
}

- (void)logOut:(requestBlock)block{
    
}

- (void)changePassword:(NSString *)newPassword finish:(requestBlock)block{
    
}

- (void)getDevicesArrayWithpageNumber:(NSInteger)pagenum pageSize:(NSInteger)size block:(devicesListLoadBlock)block{
    NSString *userid = _userInfo.user_id;
    NSString *token = _userInfo.token;
    
    NSParameterAssert(userid);
    NSParameterAssert(token);
    
    NSDictionary *params = @{@"user_id":userid,
                             @"page_number":@(kPageNumber),
                             @"page_size":@(kPageSize),
                             @"token":token
                             };
    
    [[KBHttpRequestTool sharedInstance]request:Url_GetDeviceList requestType:KBHttpRequestTypePost params:params cacheType:WLHttpCacheTypeAlways overBlock:^(BOOL IsSuccess, id result) {
        if (IsSuccess) {
            NSMutableArray *resultArray = [NSMutableArray array];
            NSArray *devicesArray = [result objectForKey:@"devices"];
            for (NSDictionary *perDic in devicesArray) {
                KBDevices *device = [[KBDevices alloc]init];
                [device setValuesForKeysWithDictionary:perDic];
                [resultArray addObject:device];
            }
            [KBUserManager sharedAccount].devicesArray = [NSMutableArray arrayWithArray:resultArray];
            if (block) {
                block(YES, [resultArray copy]);
            }
        }else{
            block(NO, nil);
        }
    }];
//    [[KBHttpRequestTool sharedInstance]request:Url_GetDeviceList requestType:KBHttpRequestTypePost params:params overBlock:^(BOOL IsSuccess, id result) {
//        if (IsSuccess) {
//            NSMutableArray *resultArray = [NSMutableArray array];
//            NSArray *devicesArray = [result objectForKey:@"devices"];
//            for (NSDictionary *perDic in devicesArray) {
//                KBDevices *device = [[KBDevices alloc]init];
//                [device setValuesForKeysWithDictionary:perDic];
//                [resultArray addObject:device];
//            }
//            [KBUserManager sharedAccount].devicesArray = [NSMutableArray arrayWithArray:resultArray];
//            if (block) {
//                block(YES, [resultArray copy]);
//            }
//        }else{
//            block(NO, nil);
//        }
//    }];
}

- (void)getDevicesStatus:(boolReturnBlock)block{
    if (!_devicesArray) {
//        设备列表未获取
        [self getDevicesArrayWithpageNumber:kPageNumber pageSize:kPageSize block:^(BOOL isSuccess, NSArray *deviceArray) {
            if (isSuccess) {
                [self freshDevicesStatus];
            }else{
                [UIAlertView showWithTitle:@"抱歉" Message:@"设备列表获取失败" cancle:@"确定" otherbutton:nil block:nil];
            }
        }];
    }else{
        [self freshDevicesStatus];
    }
}

- (void)freshDevicesStatus{
    NSString *userid = _userInfo.user_id;
    NSString *token = _userInfo.token;
    
    NSParameterAssert(userid);
    NSParameterAssert(token);
    NSParameterAssert(_devicesArray);
    NSDictionary *params = @{@"user_id":userid,
                             @"app_name":app_name,
                             @"token":token
                             };
    [[KBHttpRequestTool sharedInstance] request:Url_GetDeviceStatus requestType:KBHttpRequestTypePost params:params overBlock:^(BOOL IsSuccess, id result) {
        if (IsSuccess) {
            NSArray *statusArray = [result objectForKey:@"statuss"];
            for(NSInteger i =0 ; i < statusArray.count; i++){
                NSDictionary *perDic = statusArray[i];
                KBDevicesStatus *status = [[KBDevicesStatus alloc]init];
                [status setValuesForKeysWithDictionary:perDic];
                [[_devicesArray objectAtIndex:i] setValue:status forKey:@"devicesStatus"];
            }
        }
    }];
}

@end
