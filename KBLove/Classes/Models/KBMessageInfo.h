//
//  KBMessageInfo.h
//  KBLove
//
//  Created by 1124 on 14-10-17.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, KBMessageType)
{
    //文本聊天信息
    KBMessageTypeTalkText=1,
    //图片聊天信息
    KBMessageTypeTalkImage,
    //位置聊天信息
    KBMessageTypeTalkPosition,
    //请求好友信息
    KBMessageTypeAddFriend,
    //拒绝好友消息
    KBMessageTypeRejectFriend,
    //同意好友消息
    KBMessageTypeAgreeFriend
    //可扩展警告等其他信息类型
    
};
typedef NS_ENUM(NSInteger, KBTalkEnvironmentType)
{
    //聊天环境为圈子
    KBTalkEnvironmentTypeCircle=1,
    //聊天环境为个人
    KBTalkEnvironmentTypeFriend
    //可扩展讨论组等其他聊天环境
    
    
};
typedef NS_ENUM(NSInteger, KBMessageStatus)
{
    //未读
    KBMessageStatusUnRead=1,
    //已读
    KBMessageStatusHaveRead,
    //好友申请信息
    KBMessageStatusAgree,
    //拒绝
    KBMessageStatusReject,
    //请求
    KBMessageStatusRequrest
};
#define KBMessageTalkNotification @"KBMessageTalkNotification"
#define KBMessageRequestNotification @"KBMessageRequestNotification"
#define KBMessageNotification @"KBMessageNotification"


@interface KBMessageInfo : NSObject
//聊天环境
@property (nonatomic,assign) KBTalkEnvironmentType TalkEnvironmentType;
//消息类型
@property (nonatomic,assign) KBMessageType MessageType;
//状态
@property (nonatomic,assign) KBMessageStatus status;
//群ID
@property (nonatomic,copy) NSString *Circle_id;
//来自 参数为用户ID
@property (nonatomic,copy) NSString *FromUser_id;
//发送 参数为接受者ID
@property (nonatomic,copy) NSString *ToUser_id;
//文本信息内容
@property (nonatomic,copy) NSString *text;
//图片信息
@property (nonatomic,copy) UIImage  *image;
//消息创建时间戳(时间戳为主键不可空)
@property (nonatomic,assign) long long int time;


@end
