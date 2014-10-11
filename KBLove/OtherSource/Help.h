//
//  Help.h
//  KBLove
//
//  Created by block on 14-10-10.
//  Copyright (c) 2014年 block. All rights reserved.
//

#ifndef KBLove_Help_h
#define KBLove_Help_h

//    使用本地化字符串-中英文支持时使用
//    NSLog(@"%@",NSLocalizedStringFromTable(@"name", @"InfoPlist", nil));
//    NSLog(@"%@", [NSString stringForLocalizedKey:@"name"]);

//    手机屏幕相关
//    屏幕宽高
//kScreenWidth
//kScreenHeight

/*
 快速选择图片
 
 [[WLImagePickerTool sharedInstance] pickImageWithType:WLImagePickerTypeLocal context:self finishBlock:^(BOOL isSuccess, UIImage *image) {
    if(isSuccess){
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:image]];
    }
 }];
 
 快速生成二维码图片
 
 UIImage *image =[[WLQRCodeTool sharedInstance] qrImageForString:@"hehe" imageWidth:100];
 
 快速扫描二维码
 [[WLQRCodeTool sharedInstance]showQrScanViewWithBlock:^(BOOL isSuccess, NSString *result) {
    if (isSuccess) {
        NSLog(@"%@",result);
    }
 }];
 
 */

#endif
