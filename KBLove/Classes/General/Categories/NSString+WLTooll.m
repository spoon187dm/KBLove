//
//  NSString+WLTooll.m
//  WLLib
//
//  Created by block on 14-10-10.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "NSString+WLTooll.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Localized)

+ (NSString *)stringForLocalizedKey:(NSString *)key{
    return NSLocalizedStringFromTable(key, @"InfoPlist", nil);
}

@end

#pragma mark -
#pragma mark Font
@implementation NSString (Font)

- (CGSize)sizeToFont:(UIFont *)font WithWidth:(CGFloat)width{
    CGSize size;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    //optinos 前两个参数是匹配换行方式去计算，最后一个参数是匹配字体去计算
    //attributes 传入使用的字体
    //boundingRectWithSize 计算的范围
    size = [self boundingRectWithSize:CGSizeMake(width,999) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size;
}

/*邮箱验证 MODIFIED BY HELENSONG*/
-(BOOL)isValidateEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}


-(BOOL) isValidateMobile
{
    if (!self) {
        return NO;
    }
    if ([self length] == 0) {
        return NO;
    }
    
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:self];
}

/*车牌号验证 MODIFIED BY HELENSONG*/
- (BOOL) isValidateCarNo{
    NSString *carRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:self];
}

@end

#pragma mark -
#pragma mark HashMD5
@implementation NSString (NSString_Hashing)

- (NSString *)MD5Hash
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}

@end