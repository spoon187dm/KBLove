//
//  WLImagePickerTool.h
//  KBLove
//
//  Created by block on 14-10-10.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, WLImagePickerType) {
    WLImagePickerTypeCamera,
    WLImagePickerTypeLocal
};

typedef void (^WLImagePickBlock)(BOOL isSuccess, UIImage *image);
@interface ImagePickerTool : NSObject<UIImagePickerControllerDelegate ,UINavigationControllerDelegate>

+ (ImagePickerTool *)sharedInstance;

- (void)pickImageWithType:(WLImagePickerType)pickType context:(id)context finishBlock:(WLImagePickBlock)block;

@end
