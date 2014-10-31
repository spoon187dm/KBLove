//
//  KBMessageInfo.m
//  KBLove
//
//  Created by 1124 on 14-10-17.
//  Copyright (c) 2014年 block. All rights reserved.
//
/*2014-10-16
 *添加凯步关爱数据模型
 *
 *by 董新
 */
#import "KBMessageInfo.h"

@implementation KBMessageInfo
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
- (id)init
{
    self=[super init];
    if (self) {
        _TalkEnvironmentType=0;
        _MessageType=0;
        _status=0;
        _Circle_id=@"";
        _FromUser_id=@"";
        _ToUser_id=@"";
        _text=@"";
        _time=0;
    }
    return self;
}
@end
