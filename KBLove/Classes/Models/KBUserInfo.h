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

@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *ios_token;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *qqId;
@property (nonatomic, copy) NSString *sinaId;
@property (nonatomic, copy) NSString *rrId;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *appName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *nick;
@property (nonatomic, copy) NSString *parentId;
@property (nonatomic, copy) NSString *role;
@property (nonatomic, copy) NSString *time;
//@property (nonatomic, copy) NSString *type;
//---------------------------------------
@property (nonatomic, copy) NSString *ret;//登陆返回结果
@property (nonatomic, copy) NSString *desc;//登陆返回描述
@property (nonatomic, copy) NSString *allinchina;
@property (nonatomic, copy) NSString *type;

+ (KBUserInfo *)sharedInfo;

/**
 *  保存所有用户信息
 */
- (void)save;
@end
