//
//  CircleSettingViewController.h
//  KBLove
//
//  Created by 1124 on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "CircleRootViewController.h"
#import "KBCircleInfo.h"
@protocol DeleteCircleDelegate <NSObject>

- (void)deleteCircleWithId:(NSString *)circle_id;


@end
@interface CircleSettingViewController : CircleRootViewController<UIAlertViewDelegate>
@property (nonatomic,weak) id<DeleteCircleDelegate>  delegate;
- (void)setCircle_id:(NSString *)cid;
- (void)setCircleModel:(KBCircleInfo *)model;
@end
