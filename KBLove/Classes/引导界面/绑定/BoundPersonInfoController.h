//
//  BoundPersonInfoController.h
//  KBLove
//
//  Created by qianfeng on 38-1-1.
//  Copyright (c) 2038年 block. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoundPersonInfoController : UIViewController

//@property (nonatomic,strong)NSMutableDictionary *bounderInfoDic;

//人物头像
@property (weak, nonatomic) IBOutlet UIButton *PersonHeadImage;
//人物名称
@property (weak, nonatomic) IBOutlet UITextField *PersonName;
//生日
@property (weak, nonatomic) IBOutlet UITextField *PersonBirthday;
//性别
@property (weak, nonatomic) IBOutlet UITextField *PersonSex;
//身高
@property (weak, nonatomic) IBOutlet UITextField *PersonHeight;
//体重
@property (weak, nonatomic) IBOutlet UITextField *PersonWeight;

- (IBAction)rightNavBarButtonClick:(id)sender;
- (IBAction)backNavBarButtonClick:(id)sender;
@end
