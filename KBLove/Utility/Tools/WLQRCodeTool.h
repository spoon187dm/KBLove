//
//  WLQRCodeTool.h
//  KBLove
//
//  Created by block on 14-10-10.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^WLQRcodeScanFinishBlock)(BOOL isSuccess, NSString *result);
@interface WLQRCodeTool : NSObject

+ (WLQRCodeTool *)sharedInstance;

- (UIImage *)qrImageForString:(NSString *)str imageWidth:(CGFloat)width;

- (void)showQrScanViewWithBlock:(WLQRcodeScanFinishBlock)block;

@end
