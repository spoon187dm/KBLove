//
//  FriendSetHeadView.h
//  KBLove
//
//  Created by 1124 on 14/11/7.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendSetHeadView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *FriendImageView;
@property (weak, nonatomic) IBOutlet UILabel *RemarkLable;
- (IBAction)RemarkBtnClick:(id)sender;

@end
