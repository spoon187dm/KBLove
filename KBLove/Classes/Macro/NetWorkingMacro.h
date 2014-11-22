//
//  NetWorkingMacro.h
//  KBLove
//
//  Created by block on 14-10-13.
//  Copyright (c) 2014年 block. All rights reserved.
//

#ifndef KBLove_NetWorkingMacro_h
#define KBLove_NetWorkingMacro_h

#define app_name @"M2616_BD"
#define  SERVER_URL @"http://test.capcare.com.cn:8081"

#define SYSTEM_COLOR [UIColor colorWithRed:16/255.0 green:127/255.0 blue:136/255.0 alpha:1]
//测试账号 董新加
#define kTRIAL_ACCOUNT_NAME @"demo@capcare.com.cn"
#define kTRIAL_ACCOUNT_PWD @"123456"

//注册
static NSString *const REGRSTER_URL = @"http://test.capcare.com.cn:8081/api/register.do?type=%d&name=%@&pwd=%@";
//登陆
static NSString *const LOGIN_URL = @"http://test.capcare.com.cn:8081/api/logon.do?username=%@&pwd=%@&ts=%@&cmd=%d";
//修改密码
#define ALTER_PASSWORD_URL  NSString stringWithFormat:@"%@/api/update.pwd.do?user_id=%@&password=%@&ts=%@&new_password=%@",SERVER_URL
//修改昵称
#define ALTER_NAME_URL  NSString stringWithFormat:@"%@/api/update.nick.do?user_id=%@&nick=%@",SERVER_URL
//忘记密码
#define FORGET_PASSWORD_URL  NSString stringWithFormat:@"%@api/forget.pwd.do?username=%@&cmd=%d",SERVER_URL
//设置用户模式
#define BACKENT_USER_MODE_URL NSString stringWithFormat:@"%@/api/backend.mode.do?user_id=%@&user_mode=%d",SERVER
//设置用户类型
#define BACKENT_USER_TYPE_URL NSString stringWithFormat:@"%@/api/backend.type.do?user_id=%@&user_type=%d",SERVER



//企业用户获取下属用户目录树
#define GET_USERTREE_URL NSString stringWithFormat:@"%@/api/get.usertree.do?user_id=%@&app_name=%@",SERVER
//企业用户编辑下属用户(添加)
#define EDIT_USER_ADD_URL NSString stringWithFormat:@"%@/api/edit.user.do?operate=%@&user_id=%@&username=%@&pwd=%@&parent_id=%@&role=%@&nick=%@&type=%@",SERVER
//企业用户编辑下属用户(修改)
#define EDIT_USER_ALTER_URL NSString stringWithFormat:@"%@/api/edit.user.do?operate=%@&user_id=%@&target_id=%@&pwd=%@&nick=%@&ts=%@&app_name=%@",SERVER
//企业用户设置下级密码
#define SET_PASSWORD_URL NSString stringWithFormat:@"%@/api/set.pwd.do?user_id=%@&target_id=%@&pwd=%@&ts=%@&app_name=%@&target_pwd=%@",SERVER
/*轨迹回放接口*/
/*报警模块接口*/
/*所有警告接口*/

//好友列表请求
static NSString *const FriendList_URL = @"http://test.capcare.com.cn:8081/api/friend.list.do?user_id=%@&token=%@&cmd=%d";
//好友搜索请求
static NSString *const SEARCHFRIEND_URL = @"http://test.capcare.com.cn:8081/api/friend.res.do?user_id=%@&token=%@&friend_name=%@&cmd=%d";
//发送验证信息
static NSString *const VERIFYMESSAGE_URL = @"http://test.capcare.com.cn:8081/api/friend.verify.message.do?user_id=%@&token=%@&friend_id=%@&is_pass=1&cmd=%d&app_name=%@";
static NSString *const SENDMSGTOFRIEND_URL = @"http://test.capcare.com.cn:8081/api/friend.send.message.do";
//删除好友
#define  DeleteFriendUrl NSString stringWithFormat:@"%@/api/friend.del.do",SERVER_URL
/**
 @Author block, 10-14 15:10
 
 请求设备，警报信息
 
 */

static int const kPageNumber = 1;
static int const kPageSize = 20;
static NSString * const Url_HostName = @"http://test.capcare.com.cn:8081";
/**
 获取设备信息接口
 */
#define Url_GetDeviceInfo [NSString stringWithFormat:@"%@/api/device.get.do",Url_HostName]

/**
 获取设备列表接口
 */
#define Url_GetDeviceList [NSString stringWithFormat:@"%@/api/device.list.do",Url_HostName]

/**
 获取设备状态接口
 */
#define Url_GetDeviceStatus [NSString stringWithFormat:@"%@/api/get.status.do",Url_HostName]

/**
 获取设备警告接口
 */
#define Url_GetAlarmList [NSString stringWithFormat:@"%@/api/alarm.list.do",Url_HostName]

#define Url_GetAllAlarmList [NSString stringWithFormat:@"%@/api/alarm.all.do",Url_HostName]

/**
 修改警告信息接口
 */
#define Url_EditAlarmInfo [NSString stringWithFormat:@"%@/api/alarm.edit.do",Url_HostName]

/**
 获取轨迹回放信息接口
 */
#define Url_GetTrack [NSString stringWithFormat:@"%@/api/get.track.do",Url_HostName]

/**
 获取轨迹分段信息
 */
#define Url_Getpart [NSString stringWithFormat:@"%@/api/get.part.do",Url_HostName]

#endif
