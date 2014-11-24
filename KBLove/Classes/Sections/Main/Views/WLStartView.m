//
//  WLStartView.m
//  KBLove
//
//  Created by qianfeng on 14-11-19.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "WLStartView.h"

@implementation WLStartView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setStart:(NSInteger)count
{
    for (int i=0; i<5; i++) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*30, 0, 30, 30)];
        NSString * imagePath = nil;
        if (i<count) {
            imagePath = [[NSBundle mainBundle] pathForResource:@"数据01_11.png" ofType:nil];
           
        }else{
           imagePath = [[NSBundle mainBundle] pathForResource:@"数据01_13.png" ofType:nil];
        }
        UIImage * image = [UIImage imageWithContentsOfFile:imagePath];
        imageView.image = image;
        [self addSubview:imageView];
    }
    
}
@end
