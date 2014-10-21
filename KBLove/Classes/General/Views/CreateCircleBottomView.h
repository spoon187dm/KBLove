//
//  CreateCircleBottomView.h
//  KBLove
//
//  Created by 1124 on 14-10-15.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBFriendInfo.h"
typedef void (^SelectViewBlock)(NSInteger tag);
typedef void (^CreateFinishedBlock)();
@interface CreateCircleBottomView : UIView
- (void)ConfigUIWith:(NSArray *)array AndBlock:(SelectViewBlock)block AndFinishedBlock:(CreateFinishedBlock )fblock;
@property (strong,nonatomic) UIButton *FinishedBtn;
@end
