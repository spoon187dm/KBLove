//
//  DXLog.h
//  KBLove
//
//  Created by 1124 on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#ifndef KBLove_DXLog_h
#define KBLove_DXLog_h

/*********************************2014-10-13******************************
 *2014-10-13
 *FirstDayWork:
 *一。进度
 *1.实现注册功能及相应界面跳转。
 *2.阅读开发及接口文档，为下一步开发做准备
 *二。
 *发现以下三个问题：
 *1.发送验证信息 接口 返回失败信息 而且不知道什么意思（com.unistrong.tracker.model.IcVerifyMessage）导致无法添加好友 进而测试其他功能 接口
 *2.发送验证信息之后没有相应的推送
 *3.注册成功后，选择好友设备，无相应接口及好友
 *********************************2014-10-14******************************
 *2014-10-14
 *在classes/General中 添加KBFreash加载类
 *在header.h文件中加入相应 头文件
 *实现 圈子页面 ，创建圈子页面 基本功能，导入相应搜索类库PinYin
 ********************************2014-10-15******************************
 *2014-10-15
 *1.修复KBFreash无法停止加载问题
 *2.完善创建圈子UI逻辑功能
 *********************************2014-10-16******************************
 *2014-10-16
 *1.实现JPUSHDemo
 *2.休息
 *********************************2014-10-17******************************
 *2014-10-17
 *1.创建消息模型KBMessageInfo
 *2.扩展UILableCategory 字体自适应方法
 *3.搭建数据库
 *4.添加NSString 对时间戳处理的扩展WMString_Utilities
 **********************************2014-10-18******************************
 *1.封装发送信息视图
 *2.实现聊天界面功能
 *3.扩展数据库部分获取数据功能
 **********************************2014-10-18******************************
 *1.修复聊天界面键盘非正常弹出BUG
 *2.事件圈子设置界面
 *3.实现圈子删除好友界面 
 **********************************2014-10-21******************************
 *1.完善设置界面功能
 *2.修复邮箱注册不成功BUG
 *3.修复绑定设备崩溃问题
 ***********************************2014-10-22******************************
 *1.自定制DXSwitch
 *2.完善设置界面功能
 ***********************************2014-10-29******************************
 *1.实现聊天信息向服务器 发送 功能
 *2.实现scoket推送接收功能
 *3.加入推代码
 *4.修复删除圈子成员崩溃bug
 *
 ***********************************2014-10-30******************************
 *1.实现消息本地化存储及加载功能
 *2.实现圈子聊天功能
 *3.实现好友聊天功能
 ************************************2014-11-02******************************
 *1.实现添加好友功能
 *2.修复接收消息解析BUG
 *3.增加回执信息功能
 ************************************2014-11-03******************************
 *1.合并朋友和圈子
 *2.实现加哈有功能
 */

#endif
