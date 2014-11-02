//
//  CCUtils.h
//  Tracker
//
//  Created by apple on 13-11-1.
//  Copyright (c) 2013年 Capcare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CSLinearLayoutView.h"
#import "CCDevice.h"

@interface CCUtils : NSObject

+(void) presentViewControllerCompat:(UIViewController*) controller viewControllerToPresent:(UIViewController *)viewControllerToPresent
                           animated:(BOOL)flag completion:(void (^)(void))completion;

+(void)dismissViewControllerCompat:(UIViewController*)controller animated:(BOOL)flag completion:(void (^)())completion;

+ (UIViewController *)topViewController:(UIViewController *)rootViewController;
+ (UIViewController *)topViewController;

+(void)hideKeyboard:(UIViewController*)controller;

+(float) left:(UIView*)view;
+(float) right:(UIView*)view;
+(float) top:(UIView*)view;
+(float) bottom:(UIView*)view;
+(CGFloat) width:(UIView*)view;
+(CGFloat) height:(UIView*)view;

+(float) centerX:(UIView*)view;
+(float) centerY:(UIView*)view;

//+ (UIImage *)loadImage:(NSString *)imageName scaleIfNotRetina:(BOOL)scaleIfNotRetina;

+(UIImage*) genStretchImage:(NSString*)imageName
           scaleIfNotRetina:(BOOL)scaleIfNotRetina
                       left:(NSInteger)left
                        top:(NSInteger)top
                      right:(NSInteger)right
                     bottom:(NSInteger)bottom;

+(void)setBackgroundImage:(UIView*)view
                imageName:(NSString*)imageName
         scaleIfNotRetina:(BOOL)scaleIfNotRetina;

+(void)setUIImageViewStretchImage:(UIImageView*) view
                        imageName:(NSString*)imageName
                 scaleIfNotRetina:(BOOL)scaleIfNotRetina
                             left:(NSInteger)left
                              top:(NSInteger)top
                            right:(NSInteger)right
                           bottom:(NSInteger)bottom;

+ (void)setUIButtonStretchBackgroundImage:(UIButton*) button
                                imageName:(NSString*)imageName
                         scaleIfNotRetina:(BOOL)scaleIfNotRetina
                                     left:(NSInteger)left
                                      top:(NSInteger)top
                                    right:(NSInteger)right
                                   bottom:(NSInteger)bottom;

+ (void)setUITextFieldStretchBackgroundImage:(UITextField*) view
                                   imageName:(NSString*)imageName
                            scaleIfNotRetina:(BOOL)scaleIfNotRetina
                                        left:(NSInteger)left
                                         top:(NSInteger)top
                                       right:(NSInteger)right
                                      bottom:(NSInteger)bottom;

+(void)setUIViewStretchBackground:(UIView*) view
                        imageName:(NSString*)imageName
                 scaleIfNotRetina:(BOOL)scaleIfNotRetina
                             left:(NSInteger)left
                              top:(NSInteger)top
                            right:(NSInteger)right
                           bottom:(NSInteger)bottom;

+(void)setUITextFieldPaddingLeft:(UITextField *)view width:(int)width height:(int)height;
+(void)setUITextFieldPaddingRight:(UITextField *)view width:(int)width height:(int)height;

+(void)setUITextFieldDrawbleRight:(UITextField *)view
                        imageName:(NSString*)imageName
                 scaleIfNotRetina:(BOOL)scaleIfNotRetina;

+(void)setBtnSelector:(UIButton*)btn
      normalImageName:(NSString*)normalImageName
     pressedImageName:(NSString*)pressedImageName
     scaleIfNotRetina:(BOOL)scaleIfNotRetina;

+(void)setBtnIconSelector:(UIButton*)btn
          normalImageName:(NSString*)normalImageName
         pressedImageName:(NSString*)pressedImageName
         scaleIfNotRetina:(BOOL)scaleIfNotRetina;

+(UIBarButtonItem*)genNavBarItem:(NSString *)normalImageName
                pressedImageName:(NSString *)pressedImageName
                scaleIfNotRetina:(BOOL)scaleIfNotRetina
                          target:(id)target
                          action:(SEL)action;

+(UIButton*) genButtonFromResource:(NSString *)normalImageName
                  pressedImageName:(NSString *)pressedImageName
                  scaleIfNotRetina:(BOOL)scaleIfNotRetina;

+(UIImageView*)genImageViewFromResource:(NSString*)imageName
                       scaleIfNotRetina:(BOOL)scaleIfNotRetina;

+(UIImageView*)genImageViewFromResource:(NSString*)imageName
                         pressImageName:(NSString*)pressImageName
                       scaleIfNotRetina:(BOOL)scaleIfNotRetina;

+(void)setImageViewIcon:(UIImageView*)view
              imageName:(NSString*)imageName
       scaleIfNotRetina:(BOOL)scaleIfNotRetina;


+(NSString*) makePwdMd5NoTime:(NSString*) input;
+(NSString*) addTimeMd5:(NSString*) input;


+ (void)showLoading;
+ (void)showLoading:(NSString*)message;
+ (void)dismissLoading;
+ (void)dismissLoadingSuccess:(NSString*)message;
+ (void)dismissLoadingError:(NSString*)message;

+(void)showToast:(NSString*)message;
+(void)showToast:(UIView*)view message:(NSString*)message;
+(void)showToast:(UIView*)view message:(NSString*)message duration:(CGFloat)duration;

+(void)showConfirmDialog:(NSString*) message;
+(void)showAlertDialog:(id)delegate title:(NSString*) title message:(NSString*) message confirmText:(NSString*) confirmText cancelText:(NSString*) cancelText;



+ (void)linearLayoutAddChild:(CSLinearLayoutView *)linearLayout child:(UIView*)child fillMode:(CSLinearLayoutItemFillMode)fillMode horizontalAlignment:(CSLinearLayoutItemHorizontalAlignment)horizontalAlignment verticalAlignment:(CSLinearLayoutItemVerticalAlignment)verticalAlignment padding:(CSLinearLayoutItemPadding)padding;
+ (void)linearLayoutAddChild:(CSLinearLayoutView *)linearLayout child:(UIView*)child fillMode:(CSLinearLayoutItemFillMode)fillMode;
+ (void)linearLayoutAddChildViews:(CSLinearLayoutView *)linearLayout fillMode:(CSLinearLayoutItemFillMode)fillMode childs:(UIView *)childs,...;



+(BOOL)isEmpty:(NSString*)aInput;
+(int) long2Int:(long)along;

+(NSString*) dict2JsonString:(id)aDict;
+(NSDictionary*) string2Dict:(NSString*)string;

+(NSData*) dict2JsonData:(id)aDict;
+(NSDictionary*) data2Dict:(NSData*)data;

+(NSData*) string2Data:(NSString*)input;
+(NSString*) data2String:(NSData*)data;

+(NSURL*) string2Url:(NSString*)input;

+(NSInteger) intValue:(id)json aKey:(NSString*)aKey;
+(long) longValue:(id)json aKey:(NSString*)aKey;
+(long long) longLongValue:(id)json aKey:(NSString*)aKey;
+(float) floatValue:(id)json aKey:(NSString*)aKey;
+(double) doubleValue:(id)json aKey:(NSString*)aKey;

+(BOOL) isNull:(id)obj;

+(void) writeToFile:(NSData*)data fileName:(NSString*)fileName;
+(NSData*) readFromFile:(NSString*)fileName;
+(void) deleteFile:(NSString*)fileName;

+(void)postBlock:(void (^)(void))callbackBlock delay:(NSTimeInterval)delay;

+(NSString*)getRoundFloat:(float ) floatNumber;

+(CGRect) extendRect:(CGRect)rect left:(float)left top:(float)top right:(float)right bottom:(float)bottom;
+(CGRect) extendRect:(CGRect)rect dx:(float)dx dy:(float)dy;
+(CGRect) offsetRect:(CGRect)rect dx:(float)dx dy:(float)dy;

+(CGFloat)measureTextHeight:(CGFloat)desiredWidth text:(NSString*)text font:(UIFont*)font;

+(void) setUILabelAlignCenter:(UILabel*)label;
+(void) setUILabelAlignLeft:(UILabel*)label;
+(void) setUILabelAlignRight:(UILabel*)label;

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
+ (UIImage *)scaleImage:(UIImage *)image scaleWidth:(CGFloat)scaleWidth scaleHeight:(CGFloat)scaleHeight;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (BOOL)isValidEmail:(NSString *)string;

+(NSString *)getDataSizeString:(long long) nSize;

+(BOOL) isJailbroken;

+(NSString*) machineName;
+(void)viewDeviceBalance:(CCDevice*)device;

@end
