//
//  BoundPetInfoController.h
//  KBLove
//
//  Created by qianfeng on 38-1-1.
//  Copyright (c) 2038年 block. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoundPetInfoController : UIViewController

//@property (nonatomic,strong)NSMutableDictionary *bounderInfoDic;

//宠物头像
@property (weak, nonatomic) IBOutlet UIButton *PetHeadImage;
//宠物名称
@property (weak, nonatomic) IBOutlet UITextField *PetName;
 //宠物品种
@property (weak, nonatomic) IBOutlet UITextField *PetBreed;
//宠物类型
@property (weak, nonatomic) IBOutlet UITextField *PetType;
//宠物生日
@property (weak, nonatomic) IBOutlet UITextField *PetBithday;
//宠物性别
@property (weak, nonatomic) IBOutlet UITextField *PetSex;
//宠物肩高
@property (weak, nonatomic) IBOutlet UITextField *PetHeight;
//体重
@property (weak, nonatomic) IBOutlet UITextField *PetWeight;


- (IBAction)rightNavBarButtonClick:(id)sender;


@end
