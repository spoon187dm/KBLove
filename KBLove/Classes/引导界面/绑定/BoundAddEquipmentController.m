//
//  BoundAddEquipmentController.m
//  KBLove
//
//  Created by qianfeng on 38-1-1.
//  Copyright (c) 2038年 block. All rights reserved.
//

#import "BoundAddEquipmentController.h"
#import "BoundEquipmentDetailController.h"
@interface BoundAddEquipmentController ()

@end

@implementation BoundAddEquipmentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)rightNavBarButtonClick:(id)sender
{
    BoundEquipmentDetailController *boundEquipment=[[BoundEquipmentDetailController alloc]init];
    boundEquipment.EquipmentIMEINumString=self.EquipmentIMEINum.text;
    [self.navigationController pushViewController:boundEquipment animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
