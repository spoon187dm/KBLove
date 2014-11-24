//
//  Circle_ShareViewController.h
//  KBLove
//
//  Created by 1124 on 14/10/22.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "CircleRootViewController.h"
#import "KBPositionInfo.h"
typedef void (^SharePositionBlock)(KBPositionInfo *pos);
@interface Circle_ShareViewController : CircleRootViewController
- (void)setBlock:(SharePositionBlock)block;
@property (nonatomic,copy) NSMutableDictionary *locationDic;

@end
