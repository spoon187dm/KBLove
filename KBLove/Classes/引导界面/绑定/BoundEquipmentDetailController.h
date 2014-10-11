//
//  BoundEquipmentDetailController.h
//  KBLove
//
//  Created by qianfeng on 38-1-1.
//  Copyright (c) 2038年 block. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoundEquipmentDetailController : UIViewController

@property (nonatomic,strong)NSString *EquipmentIMEINumString;

@property (weak, nonatomic) IBOutlet UILabel *EquipmentIMEINum;

@property (weak, nonatomic) IBOutlet UITextField *EquipmentSIMNum;

@property (weak, nonatomic) IBOutlet UITextField *LinkmanPhoneNum;

//右上方 点击事件
- (IBAction)rightNavBarButtonClick:(id)sender;

@end
