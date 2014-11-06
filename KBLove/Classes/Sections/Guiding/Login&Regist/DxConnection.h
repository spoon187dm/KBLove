//
//  DxConnection.h
//  KBLove
//
//  Created by qianfeng on 14-10-11.
//  Copyright (c) 2014年 block. All rights reserved.
//

#ifndef KBLove_DxConnection_h
#define KBLove_DxConnection_h
typedef NS_ENUM(NSInteger, RegisterType)
{
    phone=1,
    email,
    userName,
    QQ,
    sinaWeibo,
    renren
};
//获取用户所有圈子
#define  Circle_URL NSString stringWithFormat:@"%@/api/group.all.do?user_id=%@&token=%@",SERVER_URL
//创建圈子
#define  Circle_Create_URL NSString stringWithFormat:@"%@/api/group.add.do?user_id=%@&token=%@&group_member=%@&group_member_type=%d&group_type=%d&receive_type=%d",SERVER_URL
//删除圈子
#define  Circle_Delete_URL NSString stringWithFormat:@"%@/api/group.del.do?user_id=%@&token=%@&group_id=%@",SERVER_URL
//更新圈子信息
#define  Circle_UpDate_URL NSString stringWithFormat:@"%@/api/group.update.do",SERVER_URL
//添加圈子成员
#define  Circle_AddMember_URL NSString stringWithFormat:@"%@/api/group.member.add.do?user_id=%@&token=%@&group_id=%@&group_member=%@",SERVER_URL
//删除成员信息
#define  Circle_DeleteMember_URL NSString stringWithFormat:@"%@/api/group.member.del.do?user_id=%@&token=%@&group_id=%@&group_member=%@",SERVER_URL
//获得所有群成员
#define  Circle_GetAllMember_URL NSString stringWithFormat:@"%@/api/group.list.do?user_id=%@&token=%@&group_id=%@",SERVER_URL
//发送群消息
#define  Circle_SendCircleMessage_URL NSString stringWithFormat:@"%@/api/group.send.message.do",SERVER_URL
//是否同意添加好友
#define  Circle_SendIsAGreeFriendMessage_URL NSString stringWithFormat:@"%@/api/friend.verify.pass.do",SERVER_URL


#define ScreenWidth  self.view.frame.size.width
#define ScreenHeight self.view.frame.size.height
#endif
