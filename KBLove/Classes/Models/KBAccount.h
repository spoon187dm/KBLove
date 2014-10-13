//
//  KBAccount.h
//  KBLove
//
//  Created by block on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KBUserInfo;
@interface KBAccount : NSObject

@property (nonatomic, strong, readonly) KBUserInfo *userInfo;

- (void)login:(requestBlock)block;
- (void)logOut:(requestBlock)block;


@end
