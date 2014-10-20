//
//  CircleFriendCell.h
//  KBLove
//
//  Created by 1124 on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBFriendInfo.h"
//typedef void (^FriendCellSelectBtnClickBlock)(NSIndexPath *patn,BOOL isselect);
@interface CircleFriendCell : UITableViewCell
- (IBAction)SelectBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *SelectBtn;
@property (weak, nonatomic) IBOutlet UIImageView *CircleFriendImageView;
@property (weak, nonatomic) IBOutlet UILabel *CircleFriendName;
@property (strong,nonatomic) NSIndexPath *path;
- (void)configUIWithModel:(KBFriendInfo *)finfo Path:(NSIndexPath *)path isSleect:(BOOL) iss;
@end
