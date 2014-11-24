//
//  BottomSelectView.m
//  KBLove
//
//  Created by block on 14/11/3.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "BottomSelectView.h"

@implementation BottomSelectView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib{
    [self changeViewToRound:_allSelectImageView];
    [self changeViewToRound:_deleteImageView];
    [self changeViewToRound:_readImageView];
}

- (void)changeViewToRound:(UIView *)view{
    view.layer.masksToBounds = YES;
    view.layer.borderColor = [[UIColor whiteColor] CGColor];
    view.layer.borderWidth = 1;
    view.layer.cornerRadius = view.width/2;
}

@end
