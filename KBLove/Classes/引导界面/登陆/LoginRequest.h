//
//  LoginRequest.h
//  KBLove
//
//  Created by 吴铭博 on 14-10-11.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <Foundation/Foundation.h>

//登陆请求完成时回调block
typedef void(^LoginFinishedBlock)();
typedef void (^LoginFailedBlock)(NSString *desc);

@interface LoginRequest : NSObject

+ (LoginRequest *)shareInstance;
/**
 *  发起登陆请求的方法
 *
 *  @param userName 用户名
 *  @param passWord 用户密码
 *  @param block    请求完成时的回调block
 */
- (void)requestWithUserName:(NSString *)userName andPassWord:(NSString *)passWord andLoginFinishedBlock:(LoginFinishedBlock)finishedBlock andLoginFaildeBlock:(LoginFailedBlock)failedBlock;

@end
