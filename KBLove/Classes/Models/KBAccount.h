//
//  KBAccount.h
//  KBLove
//
//  Created by block on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KBUserInfo;
@interface KBAccount : NSObject

@property (nonatomic, strong, readonly) KBUserInfo *userInfo;
@property (nonatomic, strong, readonly) NSMutableArray *devicesArray;


+ (KBAccount *)sharedAccount;

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
/**
 @Author block, 10-14 15:10
 
 获取设备列表
 
 @param userid  用户id
 @param pagenum 获取第几页
 @param size    回去数据个数
 @param token   用户token
 @param block   结果回调
 */
- (void)getDevicesArrayWithpageNumber:(NSInteger)pagenum pageSize:(NSInteger)size block:(devicesListLoadBlock)block;

/**
 @Author block, 10-14 19:10
 
 此方法用于获取设备状态，没有数据返回，数据会自动更新到设备数组中的每个设备中，返回yes表示状态更新成功
 
 @param block 结果状态返回
 */
- (void)getDevicesStatus:(boolReturnBlock)block;
@end
