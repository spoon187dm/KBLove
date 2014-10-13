//
//  WLQRCodeTool.m
//  KBLove
//
//  Created by block on 14-10-10.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "QRCodeTool.h"
#import "QRCodeGenerator.h"
#import "QRCodeScanViewController.h"
@implementation QRCodeTool{
    WLQRcodeScanFinishBlock _block;
}

static QRCodeTool *tool = nil;
+ (QRCodeTool *)sharedInstance{
    if (!tool) {
        tool = [[self alloc]init];
    }
    return tool;
}

- (UIImage *)qrImageForString:(NSString *)str imageWidth:(CGFloat)width{
    return [QRCodeGenerator qrImageForString:str imageSize:width];
}

- (void)showQrScanOnView:(UIViewController *)vc WithBlock:(WLQRcodeScanFinishBlock)block{
    _block = block;
    QRCodeScanViewController *qrViewcontroller=[[QRCodeScanViewController alloc]initWithBlock:^(NSString *str, BOOL isScceed) {
        if (isScceed) {
            if (_block) {
                _block(YES, str);
            }
        }
    }];
    [vc presentViewController:qrViewcontroller animated:YES completion:^{
        _block = nil;
    }];
}

- (void)showQrScanViewWithBlock:(WLQRcodeScanFinishBlock)block{
    _block = block;
    QRCodeScanViewController*vc=[[QRCodeScanViewController alloc]initWithBlock:^(NSString *str, BOOL isScceed) {
        if (isScceed) {
            if (_block) {
                _block(YES, str);
            }
        }
    }];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
}


@end
