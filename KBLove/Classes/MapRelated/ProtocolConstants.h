//
//  Constants.h
//  Tracker
//
//  Created by apple on 13-11-5.
//  Copyright (c) 2013年 Capcare. All rights reserved.
//

#ifndef Tracker_ProtocolConstants_h
#define Tracker_ProtocolConstants_h

static NSString * const kCOMMOND = @"cmd";
static NSString * const kPROTOCOL = @"protocol";
static NSString * const kOPERATE = @"operate";
static NSString * const KOBJ_EXT1 = @"obj_ext1";
static NSString * const KOBJ_EXT2 = @"obj_ext2";
static NSString * const KOBJ_EXT3 = @"obj_ext3";

// 协议号

#define Protocol_Register           1
#define Protocol_NickNameAvailable  2
#define Protocol_Login              3
#define Protocol_ModifyPwd          4
#define Protocol_SetHeadImg         6
#define Protocol_BindDevice         7
#define Protocol_GetDeviceInfo      8
#define Protocol_GetDeviceWarnings  9
#define Protocol_AllDeviceStatus    10
#define Protocol_GetAllDevices      11
#define Protocol_ModifyFenceInfo    12
#define Protocol_AddDevice2Fence    13
#define Protocol_GetAllReplayInfos  14
#define Protocol_DeleteWarning      15
#define Protocol_SetImageInfo       16
#define Protocol_GetAllFences       18
#define Protocol_GetFenceInfo       19

#define Protocol_MarkWarningReaded  20
#define Protocol_GetSegReplayInfos  24
#define Protocol_GET_STATS          27

#define Protocol_GetReplayInfos     29
#define Protocol_GetDeviceStatus    30
#define Protocol_GetAllWarnings     31
#define Protocol_SetPushChanged     32
#define Protocol_Logout             33

#define Protocol_Update             34
#define Protocol_Share              35
#define Protocol_Research           36
#define Protocol_Research_Answer    37
#define Protocol_GET_PET_STATS      38

#define Protocol_GET_CARD_FEE      39
#endif
