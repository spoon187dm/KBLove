//
//  CCTrackerUtils.h
//  Tracker
//
//  Created by apple on 13-11-28.
//  Copyright (c) 2013年 Capcare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCDevice.h"

@interface CCTrackerUtils : NSObject

+(void)updateDeviceAvatar:(UIImageView*)view device:(CCDevice*)device;
+(void) setDeviceAvatar:(UIImageView*)view device:(CCDevice*)device;
+(UIButton*) createBtn:(NSString*) title target:(id)target action:(SEL)action;
+(CCDevice *)getDeviceBySn:(NSString *)sn;
+(UIImage*) deviceAnnotationMarker:(CCDevice*)device;
+(UINavigationController*) navigationController;

+(void) showUrlInternal:(UIViewController*)parent title:(NSString*)title url:(NSString*)url;

+(void) setCommonButtonBg:(UIButton*)button;
+(void) setCommonTextFieldBg:(UITextField*)textField;
+(void) setRatioButton:(UIButton*)button selectedImage:(UIImage*)selectedImage unselectedImage:(UIImage*)unselectedImage;

+(UIImage*) loadImageFromCache:(NSString*)imageName;

@end
