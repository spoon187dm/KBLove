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

@end
