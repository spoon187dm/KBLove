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
    
    // 设置输出框的白色placeholder
    NSDictionary *attr = @{ NSForegroundColorAttributeName : [UIColor whiteColor]};
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:self.EquipmentIMEINum.placeholder attributes:attr];
    [self.EquipmentIMEINum setAttributedPlaceholder:attrStr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)suerBtnClick:(id)sender
{
    //
    if (_EquipmentIMEINum.text.length!=15) {
        [UIAlertView showWithTitle:@"提示" Message:@"请输入正确设备号" cancle:@"确定" otherbutton:nil block:^(NSInteger index) {
            
        }];
    }else{
        BoundEquipmentInfo *_equipment=[BoundEquipmentInfo sharedInstance];
        
        _equipment.EquipmentIMEINum=self.EquipmentIMEINum.text;
        //    boundEquipment.EquipmentIMEINumString=self.EquipmentIMEINum.text;
        
//        BoundEquipmentDetailController *boundEquipment= [self.storyboard instantiateViewControllerWithIdentifier:@"BoundEquipmentDetailController"];
//        [self.navigationController pushViewController:boundEquipment animated:YES];
        [self performSegueWithIdentifier:@"AddEquipment2BoundEquipment" sender:nil];
    }
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
