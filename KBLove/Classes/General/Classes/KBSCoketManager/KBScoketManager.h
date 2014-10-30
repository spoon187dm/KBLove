//
//  KBScoketManager.h
//  KBChatDemo
//
//  Created by 1124 on 14/10/25.
//  Copyright (c) 2014年 Dx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"
@interface KBScoketManager : NSObject<AsyncSocketDelegate>
+ (KBScoketManager *)ShareManager;

@end
