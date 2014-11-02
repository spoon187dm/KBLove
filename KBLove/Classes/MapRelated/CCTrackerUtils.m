//
//  CCTrackerUtils.m
//  Tracker
//
//  Created by apple on 13-11-28.
//  Copyright (c) 2013年 Capcare. All rights reserved.
//

#import "CCTrackerUtils.h"
#import "CCUtils.h"


@implementation CCTrackerUtils

+(void)updateDeviceAvatar:(UIImageView*)view device:(CCDevice*)device
{
//    NSString* iconUrl = [NSString stringWithFormat:@"%@%@", [CCTrackerConfig sharedClient].downloadImageUrl, device.avatarUrl];    
//    SDImageCache* imageCache = [SDImageCache sharedImageCache];
//    [imageCache removeImageForKey:iconUrl];
    [CCTrackerUtils setDeviceAvatar:view device:device];
    
    /*
    NSString* defualtAvatar = [device getDefaultAvatar];
    if (![CCUtils isEmpty:device.avatarUrl]) {
        NSString* iconUrl = [NSString stringWithFormat:@"%@%@", [CCTrackerConfig sharedClient].downloadImageUrl, device.avatarUrl];
        [view setImageWithURL:[NSURL URLWithString:iconUrl] placeholderImage:[CCTrackerUtils loadImageFromCache:defualtAvatar]];
    } else {
        view.image = [CCTrackerUtils loadImageFromCache:defualtAvatar];
    }
    */
}

+(void) setDeviceAvatar:(UIImageView*)view device:(CCDevice*)device
{
//    NSString* defualtAvatar = [device getDefaultAvatar];
//    if (![CCUtils isEmpty:device.avatarUrl]) {
//        NSString* iconUrl = [NSString stringWithFormat:@"%@%@", [CCTrackerConfig sharedClient].downloadImageUrl, device.avatarUrl];
////        SDImageCache* imageCache = [SDImageCache sharedImageCache];
////        UIImage* image = [imageCache imageFromDiskCacheForKey:iconUrl];
//        if (NO) {
//            if ([[[CCTrackerConfig sharedClient] client] networkReachabilityStatus] != 0) {
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:iconUrl]];
//                    UIImage *img = [UIImage imageWithData:data];
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        if (img) {
////                            [imageCache storeImage:img forKey:iconUrl];
//                            view.image = img;
//                        } else {
//                            view.image = [CCTrackerUtils loadImageFromCache:defualtAvatar];
//                        }
//                    });
//                });
//            } else {
//                view.image = [CCTrackerUtils loadImageFromCache:defualtAvatar];
//            }
//        } else {
////            view.image = image;
//        }
//    } else {
//        view.image = [CCTrackerUtils loadImageFromCache:defualtAvatar];
//    }
}

+(UIButton*) createBtn:(NSString*) title target:(id)target action:(SEL)action
{
//    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn.imageView setContentMode: UIViewContentModeScaleAspectFit];
//    btn.frame = CGRectMake(0, 0, COMMOND_BTN_WIDTH, COMMOND_BTN_HEIGHT);
//    [btn setTitle:title forState:UIControlStateNormal];
//    [btn setTitleColor:UI_TEXT_SECONDARY_COLOR forState:UIControlStateNormal];
//
//    btn.titleLabel.font = COMMON_BTN_FONT;
//    [CCUtils setUILabelAlignCenter:btn.titleLabel];
//    [CCTrackerUtils setCommonButtonBg:btn];
//    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return nil;
}

+(CCDevice *)getDeviceBySn:(NSString *)sn
{
//    CCAccount* ac = [[CCAccountManager sharedClient] getAccount];
//    if (ac == nil) {
//        return nil;
//    }
    
    return nil;
}


+(UIImage*) deviceAnnotationMarker:(CCDevice*)device
{
    NSInteger type = device.type;
    NSInteger status = device.status.status;
    BOOL hasUnreadWarning = [device hasUnreadWarning];
    //    debugLog(@"genMarker device %@ hasWanring %hhd", [_device getName], hasUnreadWarning);
    switch (type) {
        case DEVICE_CAR:
        {
            if (status == OFFLINE) {
                return [CCTrackerUtils loadImageFromCache:@"car_offline.png"];
            }
            
            if (hasUnreadWarning) {
                return [CCTrackerUtils loadImageFromCache:@"car_warning.png"];
            } else {
                return [CCTrackerUtils loadImageFromCache:@"car.png"];
            }
        }
            break;
            
        case DEVICE_PET:
        {
            if (status == OFFLINE) {
                return [CCTrackerUtils loadImageFromCache:@"pet_offline.png"];
                break;
            }
            
            if (hasUnreadWarning) {
                return [CCTrackerUtils loadImageFromCache:@"pet_warning.png"];
            } else {
                return [CCTrackerUtils loadImageFromCache:@"pet.png"];
            }
        }
            break;
            
        case DEVICE_PERSON:
        {
            if (status == OFFLINE) {
                return [CCTrackerUtils loadImageFromCache:@"person_offline.png"];
            }
            
            if (hasUnreadWarning) {
                return [CCTrackerUtils loadImageFromCache:@"person_warning.png"];
            } else {
                return [CCTrackerUtils loadImageFromCache:@"person.png"];
            }
        }
            break;
            
        default:
            break;
    }
    return nil;
}

+(UINavigationController *)navigationController
{
    return nil;
}

+(void)showUrlInternal:(UIViewController *)parent title:(NSString *)title url:(NSString *)url
{
//    CCWebViewController* controller = [[CCWebViewController alloc] initWithNibName:@"empty" bundle:nil];
//    controller.url = url;
//    controller.title = title;
//    [parent.navigationController pushViewController:controller animated:YES];
}

+(void)setCommonButtonBg:(UIButton *)button
{
    UIImage* normal = [CCUtils genStretchImage:@"common_btn_nselect.png" scaleIfNotRetina:NO left:5 top:5 right:5 bottom:5];
    UIImage* hightlighted = [CCUtils genStretchImage:@"common_btn_select.png" scaleIfNotRetina:NO left:5 top:5 right:5 bottom:5];
    [button setBackgroundImage:normal forState:UIControlStateNormal];
    [button setBackgroundImage:hightlighted forState:UIControlStateHighlighted];
    [button setBackgroundImage:hightlighted forState:UIControlStateDisabled];
}

+(void)setCommonTextFieldBg:(UITextField *)textField
{
    [CCUtils setUITextFieldStretchBackgroundImage:textField imageName:@"editview_bg.png" scaleIfNotRetina:YES left:5 top:5 right:5 bottom:5];
}

+(void)setRatioButton:(UIButton*)button selectedImage:(UIImage*)selectedImage unselectedImage:(UIImage*)unselectedImage
{
    [button setImage:unselectedImage forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateSelected];
    button.imageEdgeInsets = UIEdgeInsetsMake(8, 0, 8, 0);
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

+(UIImage*) loadImageFromCache:(NSString*)imageName
{
//    SDImageCache* imageCache = [SDImageCache sharedImageCache];
//    UIImage* image = [imageCache imageFromMemoryCacheForKey:imageName];
//    if (image == nil) {
//        image = [UIImage imageNamed:imageName];
////        [imageCache storeImage:image forKey:imageName toDisk:NO];
//    }
    return nil;
}


@end
