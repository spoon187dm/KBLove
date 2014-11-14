//
//  isAgreeViewController.h
//  KBLove
//
//  Created by 1124 on 14/11/12.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "CircleRootViewController.h"
#import "KBMessageInfo.h"
#import "KBFriendInfo.h"
@interface isAgreeViewController : CircleRootViewController
@property (weak, nonatomic) IBOutlet UIImageView *FriendImageView;
@property (weak, nonatomic) IBOutlet UILabel *FriendName;
@property (weak, nonatomic) IBOutlet UILabel *FriendDesLable;
@property (weak, nonatomic) IBOutlet UIButton *RejectBtn;
- (IBAction)RejectBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *AgreeBtn;
- (IBAction)agreeBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *ResultLable;
- (void)configUIWithMesageModel:(KBMessageInfo *)msgModel AndFriendModel:(KBFriendInfo *)friendModel ;
@end
