//
//  BoundAddEquipmentController.m
//  KBLove
//
//  Created by qianfeng on 38-1-1.
//  Copyright (c) 2038年 block. All rights reserved.
//

#import "BoundAddEquipmentController.h"
#import "BoundEquipmentDetailController.h"
#import "BoundEquipmentInfo.h"
#import "QRCodeScanViewController.h"
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
    //
    if (!self.EquipmentIMEINum.text || self.EquipmentIMEINum.text.length<=0 ) {
        [UIAlertView showWithTitle:@"提示" Message:@"请补全信息后提交" cancle:@"确定" otherbutton:nil block:^(NSInteger index) {
            
        }];
        return;
    }
    if (!self.EquipmentIMEINum.text || self.EquipmentIMEINum.text.length<=2 ) {
        [UIAlertView showWithTitle:@"提示" Message:@"IMEI错误" cancle:@"确定" otherbutton:nil block:^(NSInteger index) {
            
        }];
        return;
    }
    BoundEquipmentInfo *_equipment=[BoundEquipmentInfo sharedInstance];
    BoundEquipmentDetailController *boundEquipment= [self.storyboard instantiateViewControllerWithIdentifier:@"BoundEquipmentDetailController"];
    
    _equipment.EquipmentIMEINum=self.EquipmentIMEINum.text;
//    boundEquipment.EquipmentIMEINumString=self.EquipmentIMEINum.text;
    [self.navigationController pushViewController:boundEquipment animated:YES];
}

- (IBAction)backNavBarButtonClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)click_QECode:(id)sender {
    [[QRCodeTool sharedInstance]showQrScanOnView:self WithBlock:^(BOOL isSuccess, NSString *result) {
        if (isSuccess) {
            self.EquipmentIMEINum.text = result;
        }
    }];
}

- (IBAction)click_help:(id)sender {
}

- (IBAction)click_missDevice:(id)sender {
}

- (IBAction)click_changeUser:(id)sender {
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
