//
//  CCUtils.m
//  Tracker
//
//  Created by apple on 13-11-1.
//  Copyright (c) 2013年 Capcare. All rights reserved.
//

#import "ZWL_Utils.h"
//#import "MD5Utils.h"
//#import "Toast+UIView.h"
#import "CCTrackerUtils.h"

#import <sys/utsname.h>


@implementation ZWL_Utils

+(void)presentViewControllerCompat:(UIViewController *)controller viewControllerToPresent:(UIViewController *)viewControllerToPresent
                          animated:(BOOL)flag completion:(void (^)(void))completion
{
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0
    [controller presentModalViewController:viewControllerToPresent animated:flag];
#else
    [controller presentViewController:viewControllerToPresent animated:flag completion:completion];
#endif
}

+(void)dismissViewControllerCompat:(UIViewController*)controller animated:(BOOL)flag completion:(void (^)())completion
{
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0
    [controller dismissModalViewControllerAnimated:flag];
#else
    [controller dismissViewControllerAnimated:flag completion:completion];
#endif
}

+ (UIViewController *)topViewController:(UIViewController *)rootViewController
{
    if (rootViewController.presentedViewController == nil) {
        return rootViewController;
    }
    
    if ([rootViewController.presentedViewController isMemberOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController.presentedViewController;
        UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
        return [self topViewController:lastViewController];
    }
    
    UIViewController *presentedViewController = (UIViewController *)rootViewController.presentedViewController;
    return [self topViewController:presentedViewController];
}

+ (UIViewController *)topViewController
{
    return [ZWL_Utils topViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

+(void)hideKeyboard:(UIViewController *)controller
{
    [controller.view endEditing:YES];
}

+(float) left:(UIView*)view
{
    return view.frame.origin.x;
}

+(float) top:(UIView*)view
{
    return view.frame.origin.y;
}

+(float) right:(UIView*)view
{
    return view.frame.origin.x + view.bounds.size.width;
}

+(float) bottom:(UIView*)view
{
    return view.frame.origin.y + view.bounds.size.height;
}

+(CGFloat) width:(UIView*)view
{
    return view.bounds.size.width;
}

+(CGFloat) height:(UIView*)view
{
    return view.bounds.size.height;
}

+(float)centerX:(UIView *)view
{
    return view.bounds.size.width * 0.5f;
}

+(float)centerY:(UIView *)view
{
    return view.bounds.size.height * 0.5f;
}


//+ (UIImage *)loadImage:(NSString *)imageName scaleIfNotRetina:(BOOL)scaleIfNotRetina
//{
//    UIImage* image = [UIImage imageNamed:imageName];
//    if (!IS_RETINA && scaleIfNotRetina) {
//        image = [CCUtils scaleImage:image scaleWidth:0.5f scaleHeight:0.5f];
//    }
//    return image;
//}

+(UIImage*) genStretchImage:(NSString*)imageName
           scaleIfNotRetina:(BOOL)scaleIfNotRetina
                       left:(NSInteger)left
                        top:(NSInteger)top
                      right:(NSInteger)right
                     bottom:(NSInteger)bottom
{
    UIImage *originalImage =[UIImage imageNamed:imageName];
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    return [originalImage resizableImageWithCapInsets:insets];
}


+(void)setBackgroundImage:(UIView *)view
                imageName:(NSString *)imageName
         scaleIfNotRetina:(BOOL)scaleIfNotRetina
{
    view.backgroundColor = [[UIColor alloc] initWithPatternImage:[CCTrackerUtils loadImageFromCache:imageName]];
}

+(void)setUIImageViewStretchImage:(UIImageView*) view
                        imageName:(NSString*)imageName
                 scaleIfNotRetina:(BOOL)scaleIfNotRetina
                             left:(NSInteger)left
                              top:(NSInteger)top
                            right:(NSInteger)right
                           bottom:(NSInteger)bottom
{
    UIImage *originalImage = [CCTrackerUtils loadImageFromCache:imageName];
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    [view setImage:[originalImage resizableImageWithCapInsets:insets]];
}

+(void)setUIButtonStretchBackgroundImage:(UIButton*) button
                               imageName:(NSString*)imageName
                        scaleIfNotRetina:(BOOL)scaleIfNotRetina
                                    left:(NSInteger)left
                                     top:(NSInteger)top
                                   right:(NSInteger)right
                                  bottom:(NSInteger)bottom
{
    UIImage *originalImage = [CCTrackerUtils loadImageFromCache:imageName];
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    UIImage *stretchableImage = [originalImage resizableImageWithCapInsets:insets];
    [button setBackgroundImage:stretchableImage forState:UIControlStateNormal];
}

+(void)setUITextFieldStretchBackgroundImage:(UITextField *)view
                                  imageName:(NSString*)imageName
                           scaleIfNotRetina:(BOOL)scaleIfNotRetina
                                       left:(NSInteger)left
                                        top:(NSInteger)top
                                      right:(NSInteger)right
                                     bottom:(NSInteger)bottom
{
    UIImage *originalImage = [CCTrackerUtils loadImageFromCache:imageName];
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    UIImage *stretchableImage = [originalImage resizableImageWithCapInsets:insets];
    [view setBackground:stretchableImage];
}

+(void)setUITextFieldPaddingLeft:(UITextField *)view width:(int)width height:(int)height
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view.leftView = paddingView;
    view.leftViewMode = UITextFieldViewModeAlways;
}

+(void)setUITextFieldPaddingRight:(UITextField *)view width:(int)width height:(int)height
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view.rightView = paddingView;
    view.rightViewMode = UITextFieldViewModeAlways;
}


+(void)setUITextFieldDrawbleRight:(UITextField *)view
                        imageName:(NSString*)imageName
                 scaleIfNotRetina:(BOOL)scaleIfNotRetina
{
    UIImage *icon = [CCTrackerUtils loadImageFromCache:imageName];
    view.rightView = [[UIImageView alloc]initWithImage:icon];
    view.rightViewMode = UITextFieldViewModeAlways;
}

+(void)setBtnSelector:(UIButton*)btn
      normalImageName:(NSString*)normalImageName
     pressedImageName:(NSString*)pressedImageName
     scaleIfNotRetina:(BOOL)scaleIfNotRetina
{
    [btn setBackgroundImage:[CCTrackerUtils loadImageFromCache:normalImageName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[CCTrackerUtils loadImageFromCache:pressedImageName] forState:UIControlStateHighlighted];
}

+(void)setBtnIconSelector:(UIButton*)btn
      normalImageName:(NSString*)normalImageName
     pressedImageName:(NSString*)pressedImageName
     scaleIfNotRetina:(BOOL)scaleIfNotRetina
{
    [btn setImage:[CCTrackerUtils loadImageFromCache:normalImageName] forState:UIControlStateNormal];
    [btn setImage:[CCTrackerUtils loadImageFromCache:pressedImageName] forState:UIControlStateHighlighted];
}

+(UIButton*) genButtonFromResource:(NSString *)normalImageName
                  pressedImageName:(NSString *)pressedImageName
                  scaleIfNotRetina:(BOOL)scaleIfNotRetina
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn.imageView setContentMode: UIViewContentModeScaleAspectFit];
    [ZWL_Utils setBtnIconSelector:btn normalImageName:normalImageName
               pressedImageName:pressedImageName
           scaleIfNotRetina:scaleIfNotRetina];
    UIImage* image = [btn backgroundImageForState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    return btn;
}

+(UIBarButtonItem*)genNavBarItem:(NSString *)normalImageName
                pressedImageName:(NSString *)pressedImageName
                scaleIfNotRetina:(BOOL)scaleIfNotRetina
                          target:(id)target action:(SEL)action
{
    UIButton* btn = [ZWL_Utils genButtonFromResource:normalImageName pressedImageName:pressedImageName scaleIfNotRetina:scaleIfNotRetina];
//    btn.frame = CGRectMake(0, 0, NAVITEM_SIZE, NAVITEM_SIZE);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+(UIImageView *)genImageViewFromResource:(NSString *)imageName scaleIfNotRetina:(BOOL)scaleIfNotRetina
{
    UIImage* img = [CCTrackerUtils loadImageFromCache:imageName];
    UIImageView* imageView = [[UIImageView alloc] init];
    [imageView setImage:img];
    imageView.frame = CGRectMake(0, 0, img.size.width, img.size.height);
    return imageView;
}

+(UIImageView*)genImageViewFromResource:(NSString*)imageName
                         pressImageName:(NSString*)pressImageName
                       scaleIfNotRetina:(BOOL)scaleIfNotRetina
{
    UIImage* img = [CCTrackerUtils loadImageFromCache:imageName];
    UIImage* pressed = [CCTrackerUtils loadImageFromCache:pressImageName];
    UIImageView* imageView = [[UIImageView alloc] initWithImage:img highlightedImage:pressed];
    imageView.frame = CGRectMake(0, 0, img.size.width, img.size.height);
    return imageView;
}


+(void)setImageViewIcon:(UIImageView*)view
              imageName:(NSString*)imageName
       scaleIfNotRetina:(BOOL)scaleIfNotRetina
{
    UIImage* img = [CCTrackerUtils loadImageFromCache:imageName];
    UIImageView* imageView = [[UIImageView alloc] init];
    [imageView setImage:img];
    imageView.frame = CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y,
                                 img.size.width, img.size.height);
}

+(void)setUIViewStretchBackground:(UIView*) view
                        imageName:(NSString*)imageName
                 scaleIfNotRetina:(BOOL)scaleIfNotRetina
                             left:(NSInteger)left
                              top:(NSInteger)top
                            right:(NSInteger)right
                           bottom:(NSInteger)bottom
{
    UIImage *originalImage = [CCTrackerUtils loadImageFromCache:imageName];
    [originalImage drawInRect:view.bounds];
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    UIImage *stretchableImage = [originalImage resizableImageWithCapInsets:insets];
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.f);
    [stretchableImage drawInRect:CGRectMake(0.f, 0.f, view.bounds.size.width, view.bounds.size.height)];
    UIImage * resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    view.backgroundColor=[UIColor colorWithPatternImage:resultImage];
}
//
//+ (void)linearLayoutAddChild:(CSLinearLayoutView *)linearLayout child:(UIView*)child fillMode:(CSLinearLayoutItemFillMode)fillMode horizontalAlignment:(CSLinearLayoutItemHorizontalAlignment)horizontalAlignment verticalAlignment:(CSLinearLayoutItemVerticalAlignment)verticalAlignment padding:(CSLinearLayoutItemPadding)padding
//{
//    CSLinearLayoutItem* item = [CSLinearLayoutItem layoutItemForView:child];
//    item.horizontalAlignment = horizontalAlignment;
//    item.verticalAlignment = verticalAlignment;
//    item.fillMode = fillMode;
//    item.padding = padding;
//    [linearLayout addItem:item];
//}
//
//+ (void)linearLayoutAddChild:(CSLinearLayoutView *)linearLayout child:(UIView*)child fillMode:(CSLinearLayoutItemFillMode)fillMode
//{
//    CSLinearLayoutItem* item = [CSLinearLayoutItem layoutItemForView:child];
//    item.fillMode = fillMode;
//    [linearLayout addItem:item];
//}
//
//+ (void)linearLayoutAddChildViews:(CSLinearLayoutView *)linearLayout fillMode:(CSLinearLayoutItemFillMode)fillMode childs:(UIView *)childs,...
//{
//    //指向变参的指针
//    va_list list;
//    //使用第一个参数来初使化list指针
//    if (childs) {
//        [ZWL_Utils linearLayoutAddChild:linearLayout child:childs fillMode:fillMode];
//    }
//    
//    va_start(list, childs);
//    while (YES)
//    {
//        //返回可变参数，va_arg第二个参数为可变参数类型，如果有多个可变参数，依次调用可获取各个参数
//        UIView *child = va_arg(list, UIView*);
//        if (!child) {
//            break;
//        }
//        
//        [ZWL_Utils linearLayoutAddChild:linearLayout child:child fillMode:fillMode];
//    }
//    //结束可变参数的获取
//    va_end(list);
//}


+(void)showConfirmDialog:(NSString*) message
{
    [ZWL_Utils showAlertDialog:nil title:@"提示" message:message confirmText:@"确定" cancelText:nil];
}


+(void)showAlertDialog:(id)delegate title:(NSString*) title message:(NSString*) message confirmText:(NSString*) confirmText cancelText:(NSString*) cancelText
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate
                                          cancelButtonTitle:confirmText otherButtonTitles:cancelText, nil];
    alert.alertViewStyle = UIAlertViewStyleDefault;
    //UIAlertViewStyleDefault 默认风格，无输入框
    //UIAlertViewStyleSecureTextInput 带一个密码输入框
    //UIAlertViewStylePlainTextInput 带一个文本输入框
    //UIAlertViewLoginAndPasswordInput 带一个文本输入框，一个密码输入框
    [alert show];
}

+ (BOOL)isEmpty:(NSString*)aInput
{
    if([ZWL_Utils isNull:aInput] || [aInput length] == 0) { //string is empty or nil
        return YES;
    }
    
    if(![[aInput stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]) {
        //string is all whitespace
        return YES;
    }
    
    return NO;
}

+(int) long2Int:(long)along
{
    return (int)along;
}

+(NSData *)dict2JsonData:(id)aDict
{
    if ([NSJSONSerialization isValidJSONObject:aDict]) {
        NSError *error;
        NSData *registerData = [NSJSONSerialization dataWithJSONObject:aDict options:NSJSONWritingPrettyPrinted error:&error];
        return registerData;
    }
    return nil;
}

+(NSString*) dict2JsonString:(id)aDict
{
    NSData *registerData = [ZWL_Utils dict2JsonData:aDict];
    if (registerData) {
//        NSError *error;
        NSString* ret = [[NSString alloc] initWithData:registerData encoding:NSUTF8StringEncoding];
//        debugLog(@"dict2JsonString json = %@, err = %@", ret, error);
        return ret;
    }
    return nil;
}

+(NSDictionary *)string2Dict:(NSString *)string
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
}

+(NSDictionary *)data2Dict:(NSData *)data
{
//    if (data == nil) {
//        return nil;
//    }
//    
//    NSError* error;
//    NSDictionary* result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//    if (error != nil) {
//        debugLog(@"data2Dic  %@ error, %@", data, error);
//    }
    return nil;
}

+(NSData *)string2Data:(NSString *)input
{
   return [input dataUsingEncoding:NSUTF8StringEncoding];
}

+(NSString *)data2String:(NSData *)data
{
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+(NSURL *)string2Url:(NSString *)input
{
    return [NSURL URLWithString:[input stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

+(NSInteger) intValue:(id)json aKey:(NSString*)aKey
{
    NSNumber* number = [json objectForKey:aKey];
    if (![ZWL_Utils isNull:number]) {
        return [number intValue];
    }
    return 0;
}

+(long) longValue:(id)json aKey:(NSString*)aKey
{
    NSNumber* number = [json objectForKey:aKey];
    if (![ZWL_Utils isNull:number]) {
        return [number longValue];
    }
    return 0;
}

+(long long) longLongValue:(id)json aKey:(NSString*)aKey
{
    NSNumber* number = [json objectForKey:aKey];
    if (![ZWL_Utils isNull:number]) {
        return [number longLongValue];
    }
    return 0;
}

+(float) floatValue:(id)json aKey:(NSString*)aKey
{
    NSNumber* number = [json objectForKey:aKey];
    if (![ZWL_Utils isNull:number]) {
        return [number floatValue];
    }
    return 0;
}

+(double) doubleValue:(id)json aKey:(NSString*)aKey
{
    NSNumber* number = [json objectForKey:aKey];
    if (![number isEqual:[NSNull null]]) {
        return [number doubleValue];
    }
    return 0;
}

+(BOOL)isNull:(id)obj
{
    return obj == nil || [obj isEqual:[NSNull null]];
}

+(void)writeToFile:(NSData *)data fileName:(NSString *)fileName
{
//    debugLog(@"wirteToFile data = %@, fileName = %@", data, fileName);
    //applications Documents dirctory path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if (![ZWL_Utils isNull:paths] && paths.count > 0) {
        NSString *documentsDirectory = [paths objectAtIndex:0];
        //file to write to
        NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, fileName];
        
        //write file to device
        [data writeToFile:filePath atomically:YES];
    }
}

+(NSData *)readFromFile:(NSString *)fileName
{
    //application Documents dirctory path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if (![ZWL_Utils isNull:paths] && paths.count > 0) {
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSError *jsonError = nil;
        NSString *jsonFilePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, fileName];
        NSData* data = [NSData dataWithContentsOfFile:jsonFilePath options:kNilOptions error:&jsonError];
//        debugLog(@"readFromFile data = %@, fileName = %@", data, fileName);
        return data;
    }
    return nil;
}

+(void)deleteFile:(NSString *)fileName
{
//    debugLog(@"deleteFile fileName = %@", fileName);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if (![ZWL_Utils isNull:paths] && paths.count > 0) {
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *jsonFilePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, fileName];
        [fileManager removeItemAtPath:jsonFilePath error:nil];
    }
}

+(void)postBlock:(void (^)(void))callbackBlock delay:(NSTimeInterval)delay
{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        callbackBlock();
    });
}

+(NSString*)getRoundFloat:(float ) floatNumber {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:2];   // .1f
    [formatter setRoundingMode:NSNumberFormatterRoundHalfDown];  // up / down / half down
    NSString *numberString = [formatter stringFromNumber:[NSNumber numberWithFloat:floatNumber]];
    return numberString;
}

+(CGRect)extendRect:(CGRect)rect left:(float)left top:(float)top right:(float)right bottom:(float)bottom
{
    CGRect ret = CGRectMake(rect.origin.x - left, rect.origin.y - top,
                            rect.size.width + left + right, rect.size.height + top + bottom);
    return ret;
}

+(CGRect)extendRect:(CGRect)rect dx:(float)dx dy:(float)dy
{
    CGRect ret = CGRectMake(rect.origin.x - dx * 0.5f, rect.origin.y - dy * 0.5f,
                            rect.size.width + dx, rect.size.height + dy);
    return ret;
}

+(CGRect)offsetRect:(CGRect)rect dx:(float)dx dy:(float)dy
{
    CGRect ret = CGRectMake(rect.origin.x + dx, rect.origin.y + dy,
                            rect.size.width, rect.size.height);
    return ret;
}

+(CGFloat)measureTextHeight:(CGFloat)desiredWidth text:(NSString*)text font:(UIFont*)font
{
    CGSize boundingSize = CGSizeMake(desiredWidth, CGFLOAT_MAX);
    CGSize requiredSize = [text sizeWithFont:font constrainedToSize:boundingSize lineBreakMode:NSLineBreakByWordWrapping];
    return requiredSize.height;
}

+(void)setUILabelAlignCenter:(UILabel *)label
{
//#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0
//    label.textAlignment		= UITextAlignmentCenter;
//#else
    label.textAlignment		= NSTextAlignmentCenter;
//#endif
}

+(void)setUILabelAlignLeft:(UILabel *)label
{
//#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0
//    label.textAlignment		= UITextAlignmentLeft;
//#else
    label.textAlignment		= NSTextAlignmentLeft;
//#endif
}

+(void)setUILabelAlignRight:(UILabel *)label
{
//#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0
//	label.textAlignment		= UITextAlignmentRight;
//#else
	label.textAlignment		= NSTextAlignmentRight;
//#endif
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)scaleImage:(UIImage *)image scaleWidth:(CGFloat)scaleWidth scaleHeight:(CGFloat)scaleHeight
{
    CGSize newSize = CGSizeMake(image.size.width * scaleWidth, image.size.height * scaleHeight);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 2.0f, 2.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (BOOL)isValidEmail:(NSString *)string
{
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", laxString];
    return [emailTest evaluateWithObject:string];
}


+(NSString *)getDataSizeString:(long long)nSize
{
    long long size = nSize / 1024; // KB
    if (size < 1024) {
        return [NSString stringWithFormat:@"%lldK", size];
    } else {
        return [NSString stringWithFormat:@"%.1fM", size / 1024.0];
    }
}

+(BOOL) isJailbroken
{
#if TARGET_IPHONE_SIMULATOR
    return NO;
#else
    BOOL isJailbroken = NO;
    BOOL cydiaInstalled = [[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Cydia.app"];
    FILE *f = fopen("/bin/bash", "r");
    if (!(errno == ENOENT) && cydiaInstalled) {
        //Device is jailbroken
        isJailbroken = YES;
    }
    fclose(f);
    return isJailbroken;
#endif
}

+(NSString*) machineName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString* platform = [NSString stringWithCString:systemInfo.machine
                                            encoding:NSUTF8StringEncoding];
    return platform;
    
    //    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    //    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    //    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    //    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    //    if ([platform isEqualToString:@"iPhone3,3"])    return @"Verizon iPhone 4";
    //    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    //    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    //    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    //    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    //    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    //    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    //    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    //    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    //    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    //    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    //    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    //    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    //    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    //    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    //    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    //    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    //    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi)";
    //    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    //    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    //    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    //    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    //    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    //    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    //    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    //    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    //    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    //    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    //    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    //    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad mini 2G (WiFi)";
    //    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad mini 2G (Cellular)";
    //    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    //    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    //    return @"unknown";
}

+(void)viewDeviceBalance:(CCDevice*)device {
//    CCProt39* protocol = (CCProt39*)[[CCProtocolFactory sharedClient] getProtocol:Protocol_GET_CARD_FEE];
//    protocol.sn = device.sn;
//    
//    id obj = [protocol buildContent];
//    id content = [CCBaseProtocol buildContentArrayWithObj:obj];
//    
//    NSString* contentDes = [CCUtils dict2JsonString:content];
//    debugLog(@"execDeviceCommand %@", contentDes);
//    
//    CCBaseRequest* req = [[CCBaseRequest alloc]initWithUrlAndData:[protocol getApiUrl] data:content];
//    req.promote = @"正在获取数据";
//    req.needShowLoading = YES;
//    req.protocol = protocol;
//    
//    CCTrackerApiClient* client = [CCTrackerConfig sharedClient].client;
//    
//    [client postRequest:req aError:nil success:^(id responseObject) {
//        CCProtocolFactory* factory = [CCProtocolFactory sharedClient];
//        [factory parseData:req aData:responseObject parseFinish:^(CCBaseProtocol *p) {
//            if (p != protocol) {
//                return;
//            }
//            
//            // 成功
//            if ([p getResult] == 1) {
//                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:protocol.mFeeCheck delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                [alert show];
//            }
//        }];
//    } failure:^(NSError *error) {
//        if (error) {
//            [CCUtils showConfirmDialog:[error localizedDescription]];
//        }
//    }];
}

@end
