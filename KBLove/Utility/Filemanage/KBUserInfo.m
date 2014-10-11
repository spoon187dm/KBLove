//
//  KBUserInfo.m
//  KBLove
//
//  Created by block on 14-10-9.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "KBUserInfo.h"

@implementation KBUserInfo

KBUserInfo *info = nil;
+ (KBUserInfo *)sharedInfo{
    if (!info) {
        info = [[self alloc]init];
    }
    return info;
}

- (instancetype)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    [self read];
    return self;
}

- (void)read{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    _userName = [ud objectForKey:@"username"];
    _passWord = [ud objectForKey:@"password"];
    _isPasswordRecord = [[ud objectForKey:@"isPasswordRecord"] boolValue];
    _token = [ud objectForKey:@"token"];
    _phone = [ud objectForKey:@"phone"];
    _email = [ud objectForKey:@"email"];
    _qqId = [ud objectForKey:@"qqId"];
    _sinaId = [ud objectForKey:@"sinaId"];
    _rrId = [ud objectForKey:@"rrId"];
}

- (void)save{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:_userName forKey:@"username"];
    [ud setObject:_passWord forKey:@"password"];
    [ud setObject:[NSNumber numberWithBool:_isPasswordRecord] forKey:@"isPasswordRecord"];
    [ud setObject:_token forKey:@"token"];
    
    [ud setObject:_phone forKey:@"phone"];
    [ud setObject:_email forKey:@"email"];
    [ud setObject:_qqId forKey:@"qqId"];
    [ud setObject:_sinaId forKey:@"sinaId"];
    [ud setObject:_rrId forKey:@"rrId"];
    [ud synchronize];
}

@end
