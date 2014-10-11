//
//  KBUserInfo.h
//  KBLove
//
//  Created by block on 14-10-9.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KBUserInfo : NSObject

@property (nonatomic, assign) long id;

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *passWord;

@property (nonatomic, assign) BOOL isPasswordRecord;
//用户唯一标识 addByDX
@property (nonatomic,copy)NSString *userId;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *qqId;
@property (nonatomic, copy) NSString *sinaId;
@property (nonatomic, copy) NSString *rrId;

+ (KBUserInfo *)sharedInfo;

/**
 *  保存所有用户信息
 */
- (void)save;
@end
