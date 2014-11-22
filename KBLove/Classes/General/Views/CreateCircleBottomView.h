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
typedef void (^CreateFinishedBlock)(NSInteger tag);
@interface CreateCircleBottomView : UIView
- (void)ConfigUIWith:(NSArray *)array AndBlock:(SelectViewBlock)block AndFinishedBlock:(CreateFinishedBlock )fblock;
- (void)configUIWithFriendArray:(NSArray *)farray FinishedBtnArray:(NSArray *)finishedArr AndBlock:(SelectViewBlock)block AndFinishedBlock:(CreateFinishedBlock )fblock IsDelete:(BOOL)isdelete AndCircleUser_id:(NSString *)create_id;
@property (strong,nonatomic) UIButton *FinishedBtn;
@end
