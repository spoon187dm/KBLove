//
//  WLQRCodeTool.m
//  KBLove
//
//  Created by block on 14-10-10.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "WLQRCodeTool.h"
#import "QRCodeGenerator.h"
#import "ZCZBarViewController.h"
@implementation WLQRCodeTool{
    WLQRcodeScanFinishBlock _block;
}

static WLQRCodeTool *tool = nil;
+ (WLQRCodeTool *)sharedInstance{
    if (!tool) {
        tool = [[self alloc]init];
    }
    return tool;
}

- (UIImage *)qrImageForString:(NSString *)str imageWidth:(CGFloat)width{
    return [QRCodeGenerator qrImageForString:str imageSize:width];
}

- (void)showQrScanViewWithBlock:(WLQRcodeScanFinishBlock)block{
    _block = block;
    ZCZBarViewController*vc=[[ZCZBarViewController alloc]initWithBlock:^(NSString *str, BOOL isScceed) {
        if (isScceed) {
            if (_block) {
                _block(YES, str);
            }
        }
    }];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
}


@end
