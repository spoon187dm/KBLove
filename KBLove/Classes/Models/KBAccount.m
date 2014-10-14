//
//  KBAccount.m
//  KBLove
//
//  Created by block on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "KBAccount.h"
#import "KBHttpRequestTool.h"
#import "KBDevices.h"

@interface KBAccount ()

@property (nonatomic, strong) KBUserInfo *userInfo;
@property (nonatomic, strong) NSMutableArray *devicesArray;

@end

@implementation KBAccount

- (id)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    _userInfo = [KBUserInfo sharedInfo];
    return self;
}

static KBAccount *account = nil;
+ (KBAccount *)sharedAccount{
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

- (void)loadDevicesArrayWithpageNumber:(NSInteger)pagenum pageSize:(NSInteger)size block:(devicesListLoadBlock)block{
    NSString *userid = _userInfo.user_id;
    NSString *token = _userInfo.token;
    
    NSParameterAssert(userid);
    NSParameterAssert(token);
    
    NSDictionary *params = @{@"user_id":userid,
                             @"page_number":@(pagenum),
                             @"page_size":@(size),
                             @"token":token
                             };
    
    [[KBHttpRequestTool sharedInstance]request:Url_GetDeviceList requestType:KBHttpRequestTypePost params:params overBlock:^(BOOL IsSuccess, id result) {
        if (IsSuccess) {
            NSMutableArray *resultArray = [NSMutableArray array];
            NSArray *devicesArray = [result objectForKey:@"devices"];
            for (NSDictionary *perDic in devicesArray) {
                KBDevices *device = [[KBDevices alloc]init];
                [device setValuesForKeysWithDictionary:perDic];
                [resultArray addObject:device];
            }
            [KBAccount sharedAccount].devicesArray = [NSMutableArray arrayWithArray:resultArray];
            if (block) {
                block(YES, [resultArray copy]);
            }
        }else{
            block(NO, nil);
        }
    }];
}

- (void)freshDevicesStatus{
    
}

@end
