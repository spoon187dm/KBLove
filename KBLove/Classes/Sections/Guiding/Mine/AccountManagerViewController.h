//
//  AccountManagerViewController.h
//  KBLove
//
//  Created by 吴铭博 on 14/10/17.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountManagerViewController : UITableViewController
//邮箱label
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
//手机号码label
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

//返回按钮点击事件
- (IBAction)backItemClicked:(id)sender;

@end
