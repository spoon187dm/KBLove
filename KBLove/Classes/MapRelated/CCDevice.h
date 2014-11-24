//
//  CCDevice.h
//  Tracker
//
//  Created by apple on 13-11-5.
//  Copyright (c) 2013年 Capcare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCDeviceStatus.h"
#import "CCWarning.h"
#import "CCFence.h"
#import "CCJASONObject.h"
#import "CCBaseRelation.h"

@interface CCDevice : NSObject<CCJASONObject>

@property (assign, nonatomic) long long uid;                // 设备id
@property (copy, nonatomic) NSString* sn;                   // 设备sn
@property (nonatomic, assign) NSInteger type;

@property (copy, nonatomic) NSString* name;                 // 名称
@property (copy, nonatomic) NSString* email;                // 邮箱
@property (copy, nonatomic) NSString* avatarUrl;            // 头像的url
@property long long avatarStamp;
@property (strong, nonatomic) UIImage* avatar;              // 头像
@property (copy, nonatomic) NSString* phoneNumber;          // 电话号码
@property (copy, nonatomic) NSString* hardware;             // 硬件类型
@property (strong, nonatomic) CCBaseRelation* relation;     // 设备关联的对象 关联人，宠物，汽车信息
@property (assign, nonatomic) NSInteger tick;               // 上传位置频率（60s一次）

@property (assign, nonatomic) NSInteger warningBattery;     // 电量报警条件，如低于30%报警
@property (assign, nonatomic) NSInteger warningFlow;        // 流量报警条件，如低于5m报警
@property (assign, nonatomic) NSInteger speedThreshold;     // 超速条件

@property (assign, nonatomic) NSInteger overItemIndex;

@property (strong, nonatomic) CCDeviceStatus* status;

@property (strong, nonatomic) NSMutableArray* warnings;

@property (strong, nonatomic) CCFence* regionFence;         // 围栏
@property (nonatomic, copy) NSString* address;

@property (assign, nonatomic) NSInteger movingSwitch;             // 移动
@property (assign, nonatomic) NSInteger speedingSwitch;           // 超速
@property (assign, nonatomic) NSInteger breakAwaySwitch;          // 脱离
@property (assign, nonatomic) NSInteger fenceWarningSwitch;       // 围栏警报开关
@property (assign, nonatomic) NSInteger smsWarningSwitch;       // 短信警报开关

@property (strong, nonatomic) NSMutableArray* sosNums;

@property (assign, nonatomic) float flow;
@property (assign, nonatomic) float battery;

-(id) initWithSn:(NSString*)aSn;
-(long long) getLastWarningTime;
-(NSString*) getName;
-(BOOL)hasUnreadWarning;
-(NSInteger) getUnreadWarnNum;
-(bool) isAddressChanged:(NSInteger)lat lng:(NSInteger)lng;
-(void) updateInfo:(CCDevice*)result;

-(NSString*) getDefaultAvatar;


@end
