//
//  CircleTalkViewController.h
//  KBLove
//
//  Created by 1124 on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "CircleRootViewController.h"
#import "KBMessageInfo.h"
#import "KBCircleInfo.h"
#import "KBFriendInfo.h"
@interface CircleTalkViewController : CircleRootViewController
- (void)setTalkEnvironment:(KBTalkEnvironmentType)type andId:(NSString *)tid;
- (void)setTalkEnvironment:(KBTalkEnvironmentType)type andModel:(id )model;
@end
