//
//  AddListTableViewCell.h
//  KBLove
//
//  Created by 1124 on 14/11/12.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBMessageInfo.h"
#import "KBFriendInfo.h"
typedef void (^AgreeBlock)(UIButton *btn);
@interface AddListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *AddFriendImageView;
@property (weak, nonatomic) IBOutlet UILabel *FriendNameLable;
@property (weak, nonatomic) IBOutlet UIButton *AgreeBtn;
@property (weak, nonatomic) IBOutlet UILabel *frienDesLable;
- (IBAction)AgreeClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *FriendStatusLable;
- (void)configUIWithMesageModel:(KBMessageInfo *)msgModel AndFriendModel:(KBFriendInfo *)friendModel WithBlock:(AgreeBlock)agBlock;
@end
