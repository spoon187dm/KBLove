//
//  AlterUserDataViewController.m
//  KBLove
//
//  Created by 吴铭博 on 14-10-17.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "AlterUserDataViewController.h"
#import "ImagePickerTool.h"

@interface AlterUserDataViewController () <UIActionSheetDelegate>

@end

@implementation AlterUserDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self loadData];
}

#pragma mark - loadData
//从本地NSUserDefault中读取信息
- (void)loadData {
    KBUserInfo *info = [KBUserInfo sharedInfo];
    _nickNameTextField.text = info.nick;
//    _birthdayBtn setTitle:info. forState:<#(UIControlState)#>
    
}

#pragma mark - configUI
- (void)configUI {
    //设定日期选择器frame
    _birthdayPicker.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height + _alertBirthdayBtn.bounds.size.height, _birthdayPicker.bounds.size.width, _birthdayPicker.bounds.size.height);
    _alertBirthdayBtn.frame = CGRectMake(_alertBirthdayBtn.frame.origin.x, [UIScreen mainScreen].bounds.size.height, _alertBirthdayBtn.bounds.size.width, _alertBirthdayBtn.bounds.size.height);
}

#pragma mark - 内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 点击事件
- (IBAction)headPortraitBtnClicked:(id)sender {
    [[ImagePickerTool sharedInstance] pickImageWithType:WLImagePickerTypeLocal context:self finishBlock:^(BOOL isSuccess, UIImage *image) {
        if (isSuccess) {
            _headPortrait.image = image;
        } else {
            [UIAlertView showWithTitle:@"温馨提示" Message:@"调取本地相册失败" cancle:@"确定" otherbutton:nil block:^(NSInteger index) {
                
            }];
        }
    }];
}

- (IBAction)backItemClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)ConfirmAlterItemClicked:(id)sender {
    
}

- (IBAction)birthdayBtnClicked:(id)sender {
    [UIView animateWithDuration:0.5f animations:^{
       _birthdayPicker.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - _birthdayPicker.bounds.size.height, _birthdayPicker.bounds.size.width, _birthdayPicker.bounds.size.height);
        _alertBirthdayBtn.frame = CGRectMake(_alertBirthdayBtn.frame.origin.x, [UIScreen mainScreen].bounds.size.height - _birthdayPicker.bounds.size.height - _alertBirthdayBtn.bounds.size.height, _alertBirthdayBtn.bounds.size.width, _alertBirthdayBtn.bounds.size.height);
    }];
}

- (IBAction)sexBtnClicked:(id)sender {
    UIActionSheet *sexCheckAS = [[UIActionSheet alloc] initWithTitle:@"请选择性别" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
    [sexCheckAS showInView:self.view];
    
}

#pragma mark - 修改生日
//确定修改
- (IBAction)alertBirthdayBtnClicked:(id)sender {
    //将选择器中的日期赋值
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSString *birthday = [formatter stringFromDate:_birthdayPicker.date];
    [_birthdayBtn setTitle:birthday forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.5f animations:^{
        _birthdayPicker.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height + _alertBirthdayBtn.bounds.size.height, _birthdayPicker.bounds.size.width, _birthdayPicker.bounds.size.height);
        _alertBirthdayBtn.frame = CGRectMake(_alertBirthdayBtn.frame.origin.x, [UIScreen mainScreen].bounds.size.height, _alertBirthdayBtn.bounds.size.width, _alertBirthdayBtn.bounds.size.height);
    }];
}

#pragma mark - ActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [_sexBtn setTitle:@"男" forState:UIControlStateNormal];
    } else if (buttonIndex == 1) {
        [_sexBtn setTitle:@"女" forState:UIControlStateNormal];    
    }
}
@end
