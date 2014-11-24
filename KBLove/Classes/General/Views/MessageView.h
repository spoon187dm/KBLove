//
//  MessageView.h
//  DrawRect
//
//  Created by 1124 on 14/11/10.
//  Copyright (c) 2014年 Dx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageView : UIView
- (void)setString:(NSString *)str WithMaxWidth:(CGFloat)maxwidth AndAttributris:(NSDictionary *)sdic;
- (void)setImageArr:(NSArray *)imageArr;
- (CGSize)GetAllSizeWithString;
@end
