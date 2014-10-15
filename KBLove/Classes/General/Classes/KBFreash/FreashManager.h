//
//  FreashManager.h
//  LoveFreeTrip
//
//  Created by 1124 on 14-10-14.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KBFreash.h"
@interface FreashManager : NSObject
+ (id)DefaultManager;
- (void)addFreash:(KBFreash *)freash andKey:(NSString *)key;
- (void)removeFreashWithKey:(NSString *)key;
@end
