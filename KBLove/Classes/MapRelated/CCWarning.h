//
//  CCWarning.h
//  Tracker
//
//  Created by apple on 13-11-5.
//  Copyright (c) 2013年 Capcare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCJASONObject.h"
//#import "CCGeoHelper.h"

@interface CCWarning : NSObject<CCJASONObject>

@property (nonatomic, assign) long long time;
@property (nonatomic, assign) NSInteger type;           // 警报类型
@property (nonatomic, assign) long long serialNum;      // 警报编号
@property (nonatomic, assign) long long uid;            // 警报id
@property (nonatomic, assign) NSInteger lang;           // 精度
@property (nonatomic, assign) NSInteger lat;            // 纬度
@property (nonatomic, assign) float speed;              // 速度
@property (nonatomic, copy) NSString* info;             // 警报描述信息
@property (nonatomic, assign) NSInteger level;          // 警报等级（高：0，中：1，低：2）
//@property (nonatomic, strong) id<CCGeoHelperDelegate> geoDelegate;

//	高：通知栏+铃声+震动
//	中：通知栏
//	低：软件内提示

@property (nonatomic, assign) NSInteger battery;
@property (nonatomic, assign) NSInteger flow;
@property (nonatomic, assign) NSInteger readState;        // 已读未读状态
@property (nonatomic, copy) NSString* address;
@property (nonatomic, copy) NSString* timeStr;
@property (nonatomic, copy) NSString* sn;
@property (nonatomic, assign) BOOL addressRequested;

-(NSString*) getTimeStr;
-(NSString*) getAddress;
-(NSString*) getWarningDetailDes:(BOOL)isFullTime;
-(NSString*) getWarningDialogMessage:(NSString*)deviceName;

-(void)readFromArray:(id)array;


@end
