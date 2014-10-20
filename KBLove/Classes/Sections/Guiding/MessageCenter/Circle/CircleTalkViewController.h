//
//  CircleTalkViewController.h
//  KBLove
//
//  Created by 1124 on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "CircleRootViewController.h"
#import "KBMessageInfo.h"
@interface CircleTalkViewController : CircleRootViewController
- (void)setTalkEnvironment:(KBTalkEnvironmentType)type andId:(NSString *)tid;
@end
