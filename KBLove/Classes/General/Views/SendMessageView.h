//
//  SendMessageView.h
//  KBLove
//
//  Created by 1124 on 14/10/17.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBMessageInfo.h"
typedef void (^SendMessageBlock)(KBMessageInfo *msg);
@interface SendMessageView : UIView<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *SendMessageBgImageView;
@property (weak, nonatomic) IBOutlet UIButton *SengImageBtn;
@property (weak, nonatomic) IBOutlet UITextField *SendMsgTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *SendPositionBtn;
@property (weak, nonatomic) IBOutlet UIButton *SendTextBtn;
@property (weak,nonatomic) UIViewController *delegate;
//发送图片信息
- (IBAction)SendImageBtnClick:(id)sender;
//发送地址信息
- (IBAction)SendPositionClick:(id)sender;
//发送文本信息
- (IBAction)SendTextClick:(id)sender;
- (void)setBlock:(SendMessageBlock)block AndDelegate:(UIViewController *)delegate;
@end
