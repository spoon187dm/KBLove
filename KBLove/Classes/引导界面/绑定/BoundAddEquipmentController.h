//
//  BoundAddEquipmentController.h
//  KBLove
//
//  Created by qianfeng on 38-1-1.
//  Copyright (c) 2038年 block. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoundAddEquipmentController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *EquipmentIMEINum;

//右上方确定按钮 点击事件
- (IBAction)rightNavBarButtonClick:(id)sender;

@end
