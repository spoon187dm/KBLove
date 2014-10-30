//
//  KBAccount.h
//  KBLove
//
//  Created by block on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KBUserInfo;
@interface KBUserManager : NSObject

@property (nonatomic, strong, readonly) KBUserInfo *userInfo;
@property (nonatomic, strong, readonly) NSMutableArray *devicesArray;


+ (KBUserManager *)sharedAccount;

/**
 @Author block, 10-14 15:10
 
 用户直接登录
 
 @param block 登陆结果回调
 */
- (void)login:(requestBlock)block;

/**
 @Author block, 10-14 15:10
 
 用户登出
 
 @param block 登出结果回调
 */
- (void)logOut:(requestBlock)block;

/**
 @Author block, 10-14 15:10
 
 修改用户密码
 
 @param newPassword 新密码
 @param block       修改结果回调
 */
- (void)changePassword:(NSString *)newPassword finish:(requestBlock)block;

@end
