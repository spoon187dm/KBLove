//
//  CarOBDViewController.h
//  KBLove
//
//  Created by qianfeng on 14-11-18.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarOBDViewController : UIViewController
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *OBDDataArrayLabel;

- (IBAction)home_btn:(UIButton *)sender;

- (IBAction)back_btn:(UIButton *)sender;

@end
