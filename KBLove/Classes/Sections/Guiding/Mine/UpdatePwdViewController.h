//
//  UpdatePwdViewController.h
//  KBLove
//
//  Created by Huang on 14/11/20.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdatePwdViewController : UIViewController
- (IBAction)backClicked:(UIButton *)sender;
- (IBAction)ContainClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *YesItem;
@property (weak, nonatomic) IBOutlet UITextField *oldPassword;

@property (weak, nonatomic) IBOutlet UITextField *ConfirmPassword;
@property (weak, nonatomic) IBOutlet UITextField *newtext;



@end
