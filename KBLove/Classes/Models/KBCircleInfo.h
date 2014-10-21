//
//  KBCircleInfo.h
//  KBLove
//
//  Created by 1124 on 14/10/21.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KBCircleInfo : NSObject
//群组成员类型
@property (nonatomic,copy)NSNumber *groupMemberType;
//群组ID
@property (nonatomic,copy)NSNumber *id;
//
@property (nonatomic,copy)NSNumber *modifyTime;
//群组名
@property (nonatomic,copy)NSString *name;
//接受消息类型
@property (nonatomic,copy)NSNumber *receiveMessageType;
//时间
@property (nonatomic,copy)NSNumber *time;
//群类型
@property (nonatomic,copy)NSNumber *type;
//创建者ID
@property (nonatomic,copy)NSNumber *userId;

@end
