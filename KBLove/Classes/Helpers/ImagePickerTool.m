//
//  WLImagePickerTool.m
//  KBLove
//
//  Created by block on 14-10-10.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "ImagePickerTool.h"
#import <MobileCoreServices/MobileCoreServices.h>
@implementation ImagePickerTool{
    WLImagePickBlock _block;
    UIViewController *_vc;
}

static ImagePickerTool *tool = nil;
+ (ImagePickerTool *)sharedInstance{
    if (!tool) {
        tool = [[self alloc]init];
    }
    return tool;
}

- (void)dealloc{
    _block = nil;
}

- (void)pickImageWithType:(WLImagePickerType)pickType context:(id)context finishBlock:(WLImagePickBlock)block{
    
    if (![context isKindOfClass:[UIViewController class]]) {
        return;
    }
    _block = block;
    _vc = (UIViewController *)context;
    
    switch (pickType) {
        case WLImagePickerTypeCamera:
        {
            //            相机
            //            先判断资源是否可用
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                [self loadSourceWithType:UIImagePickerControllerSourceTypeCamera];
            }else{
                [self showAlterWithMessage:@"相机不可用"];
                if (_block) {
                    _block(NO, nil);
                }
            }
        }
            break;
        case WLImagePickerTypeLocal:{
            //            相册
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                [self loadSourceWithType:UIImagePickerControllerSourceTypePhotoLibrary];
            }else{
                [self showAlterWithMessage:@"相册不可用"];
                if (_block) {
                    _block(NO, nil);
                }
            }
        }
            break;
        default:{
            
        }
            break;
    }
}





- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //    先判断资源是否是图片资源
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    //    系统预置的图片类型常量
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        //        取得图片
        UIImage *image = info[UIImagePickerControllerEditedImage];
//        [self.view setBackgroundColor:[UIColor colorWithPatternImage:image]];
        if (_block) {
            _block(YES, image);
        }
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)loadSourceWithType:(UIImagePickerControllerSourceType)sourceType{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = sourceType;
    picker.delegate = self;
    //    是否对相册资源进行自动处理
    picker.allowsEditing = YES;
    //

    if (_vc) {
        [_vc presentViewController:picker animated:YES completion:nil];
    }
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:picker animated:YES completion:^{
////
//    }];
}

- (void)showAlterWithMessage:(NSString *)message{
    UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alt show];
}

@end
