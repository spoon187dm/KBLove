//
//  RecteView.m
//  KBLove
//
//  Created by qianfeng on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "RecteView.h"

@implementation RecteView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)awakeFromNib{
    self.layer.masksToBounds=YES;
    self.layer.borderColor=[[UIColor whiteColor ]CGColor];
    self.layer.borderWidth=1;
    self.layer.cornerRadius=3;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
