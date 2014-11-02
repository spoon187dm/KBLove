//
//  Constants.h
//  Tracker
//
//  Created by apple on 13-11-5.
//  Copyright (c) 2013年 Capcare. All rights reserved.
//

#ifndef Tracker_ModelConstants_h
#define Tracker_ModelConstants_h

#define INVALID_ID              -1

// 刷新类型
#define REFRESH_BY_BACKGROUND   0
#define REFRESH_BY_MANUAL       1
#define REFRESH_BY_STARTUP      2

// 设备类型
#define DEVICE_UNKNOW           0
#define DEVICE_CAR              1
#define DEVICE_PET              2
#define DEVICE_PERSON           3

// for device setting
#define INVALID_SWITCH          -1
#define SWITCH_ON               1
#define SWITCH_OFF              2

// for DeviceStatus
#define ONLINE                  1
#define OFFLINE                 2
#define CANCEL                  3
#define OUTOFSERVICE            4
#define SERVICESTOP             5

// 性别
#define GENDER_MALE             1
#define GENDER_FEMAIL           0

// 无更新
#define UPDATE_NONE             1
// 公告
#define UPDATE_NOTICE           2
// 新版本
#define UPDATE_NEW_VERSION      3
// 强制更新
#define UPDATE_FORCE_UPGRADE    4

// 位置
#define SHARE_LOCATION          1
// 轨迹
#define SHARE_TRACK_PATH        2

// 隐私类型
#define PRIVACY_PUBLIC          1
#define PRIVACY_ALL_FRIENDS     2
#define PRIVACY_PART_FRIENDS    3

#define ADD 1
#define _DELETE 2

#define BIND 1
#define UNBIND 2
#define UPDATE 3
#define RESET 4
#define REBOOT 5

#define ADD_FENCE 1
#define MODIFY_FENCE 2
#define DELETE_FENCE 3

#define RESEARCH_SINGLE_CHIOCE  1
#define RESEARCH_MULTI_CHOICE   2


// 设备类型
static NSString * const kHW_M2616 = @"M2616";              // 跟屁虫
static NSString * const kHW_T1 = @"T1";                    // 小车机
static NSString * const kHW_MT90 = @"MT90";                // 人
static NSString * const kHW_SUPER1 = @"SUPER1";            // 人
static NSString * const kHW_DOG_MASTER = @"DOG_MASTER";    // 狗管家

// json key
static NSString * const kID = @"id";
static NSString * const kRET = @"ret";

static NSString * const kURL = @"url";

static NSString * const kAPP_NAME = @"app_name";
static NSString * const kVERSION = @"version";
static NSString * const kPTYPE = @"ptype";
static NSString * const kPVERSION = @"pversion";
static NSString * const kVERSIONCODE = @"versionCode";
static NSString * const kCONTENT = @"content";
static NSString * const kPLATFORM = @"platform";

static NSString * const kPRIVACY_TYPE = @"privacy_type";
static NSString * const kPUBLISH = @"publish";
static NSString * const kACT = @"act";
static NSString * const kEXPIRE = @"expire";
static NSString * const kCONTENT_TYPE = @"content_type";
static NSString * const kDEVICE_SNS = @"device_sns";

static NSString * const kRESEARCH = @"research";
static NSString * const kANSWERS = @"answers";
static NSString * const kTOPIC_ID = @"topic_id";

static NSString * const kIOS_DEVICE_TOKEN = @"ios_device_token";
static NSString * const kPUSH = @"push";
static NSString * const kVER = @"ver";
static NSString * const kDUID = @"duid";
static NSString * const kTS = @"ts";
static NSString * const kTABLE_NAME = @"account";
static NSString * const kUSR = @"usr";
static NSString * const kPWD = @"pwd";
static NSString * const kPASSWORD = @"password";
static NSString * const kNEW_PASSWORD = @"new_password";
static NSString * const kUSERID = @"user_id";
static NSString * const kTOKEN = @"token";
static NSString * const kTYPE = @"type";
static NSString * const kADDR = @"addr";
static NSString * const kSTATE = @"state";
static NSString * const kSTATES = @"states";
static NSString * const kALARM_ID = @"alarm_id";
static NSString * const kALARM = @"alarm";
static NSString * const kALARMS = @"alarms";
static NSString * const kTRACK = @"track";

static NSString * const kDESC = @"desc";
static NSString * const kAGE = @"age";
static NSString * const kCAR = @"car";

static NSString * const kSN = @"sn";
static NSString * const kSNS = @"sns";
static NSString * const kNAME = @"name";
static NSString * const kUSER_NAME = @"username";

static NSString * const kEMAIL = @"email";
static NSString * const kICON = @"icon";
static NSString * const kSTAMP = @"stamp";
static NSString * const kPHONE_NUMBER = @"phone_number";
static NSString * const kPHONE = @"phone";
static NSString * const kRELATION_OBJ = @"relationObj";
static NSString * const kREGION = @"region";
static NSString * const kREGIONS = @"regions";
static NSString * const kTICK = @"tick";
static NSString * const kWARNINGS = @"warnings";
static NSString * const kWARNING_BATTERY = @"warning_battery";
static NSString * const kWARNING_FLOW = @"warning_flow";
static NSString * const kSOS_NUM = @"sosNum";
static NSString * const kSMS_NUM = @"contact";
static NSString * const kSPEED_THRESHOLD = @"speedThreshold";
static NSString * const kSPEEDING_SWITCH = @"speedingSwitch";
static NSString * const kMOVING_SWITCH = @"moveSwitch";
static NSString * const kBREAK_AWAY_SWITCH = @"breakawaySwitch";
static NSString * const kFENCE_SWITCH = @"fenceSwitch";
static NSString * const kSMS_SWITCH = @"enableSmsAlarm";

static NSString * const kLANG = @"lng";
static NSString * const kLAT = @"lat";
static NSString * const kSPEED = @"speed";

static NSString * const kFLOW_TOTLE = @"flow_total";
static NSString * const kFLOW = @"flow";
static NSString * const kBATTERY = @"battery";
static NSString * const kSTATUS = @"status";
static NSString * const kHEAD = @"head";
static NSString * const kDIRECTION = @"direction";
static NSString * const kDEVICE = @"device";
static NSString * const kDEVICE_SN = @"device_sn";
static NSString * const kDEVICESN = @"deviceSn";        // TODO 操蛋的协议，deviceSn 还有device_sn
static NSString * const kDEVICES = @"devices";
static NSString * const kDEVICE_STATUSS = @"statuss";
static NSString * const kRECEIVE = @"receive";
static NSString * const kSTAYED = @"stayed";
static NSString * const kHARDWARE = @"hardware";

// from warning
#define LEVEL_HIGH 0
#define LEVEL_NORMAL 1
#define LEVEL_LOW 2

static NSString * const kSERIALNUM = @"serialnum";
static NSString * const kINFO = @"info";
static NSString * const kLEVEL = @"level";
static NSString * const kREADED = @"read";
static NSString * const kTIME = @"time";

/** 出围栏报警 */
#define ALARM_OUT 1
/** 进围栏报警 */
#define ALARM_IN 2
/** 低电报警 */
#define ALARM_LOW_BATTERY 3
/** 超速报警 */
#define ALARM_SPDHI 4
/** SOS报警 */
#define ALARM_SOS 5
///** 振动报警 */
//#define ALARM_VIB 6
///** 外电报警 */
//#define ALARM_EPD 7
///** 防盗报警 */
//#define ALARM_BAT 8
///** 低速报警 */
//#define ALARM_SPDLO 9
///** 蓝牙*/
//#define ALARM_BLUETOOTH 10
///** 流量*/
#define ALARM_FLOW 11
/** 脱离*/
#define ALARM_BREAKAWAY 7
/**移动警报*/
#define ALARM_MOVING 6

// 已读未读状态
#define READ 1
#define UNREAD 2

// from fence.java

static NSString * const kOUTSTR = @"out";
static NSString * const kRADIUS = @"radius";
static NSString * const kCENTER = @"center";
static NSString * const kLNG = @"lng";

// 篱笆的形状
#define CIRCLE 1
#define RECT 2
#define POLYGON 3

#define IN_FENCE 1
#define OUT_FENCE 2

#define FENCE_MIN_RADIUS 20
#define FENCE_MAX_RADIUS 50000

#define DEFAULT_CORDINATE_DELTA 50000

static NSString * const kPOSITION_INFOS = @"position_infos";
static NSString * const kPOSITION = @"position";
static NSString * const kFENCE = @"fence";
static NSString * const kFENCE_ID = @"fence_id";
static NSString * const kFENCES = @"fences";

static NSString * const kDATE = @"day";
static NSString * const kDISTANCE = @"distance";
static NSString * const kSTOP = @"stop";
static NSString * const kSPEEDING = @"speeding";

static NSString * const kGENDER = @"gender";
static NSString * const kHEIGHT = @"height";
static NSString * const kWEIGHT = @"weight";

static NSString * const kBIRTH = @"birth";
static NSString * const kDOGFIGURE = @"dogFigure";
static NSString * const kDOGFIGURE_SEND = @"dog_figure";
static NSString * const kDOGBREED = @"dogBreed";
static NSString * const kDOGBREED_SEND = @"dog_breed";
static NSString * const kDOGAGE = @"sage";

static NSString * const kSHOW = @"show";
static NSString * const kPERCENT = @"percent";

static NSString * const kBEGIN = @"begin";
static NSString * const kEND = @"end";
static NSString * const kPART = @"part";

static NSString * const kDISTRIBUTED = @"distributed";
static NSString * const kMILEAGES = @"mileages";
static NSString * const kUNIT = @"unit";
static NSString * const kSTANDARD = @"standard";
static NSString * const kSTATISTIC = @"statistic";
static NSString * const kENERGY = @"energy";

#endif
