//
//  DevicesCell.m
//  KBLove
//
//  Created by block on 14-10-15.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "DevicesCell.h"
#import "KBDevices.h"
#import "DeviceInfoView.h"
@implementation DevicesCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
//    self.backgroundColor = [UIColor clearColor];
//    self.contentView.backgroundColor = [UIColor clearColor];
    return self;
}

- (UIView *)ViewForCellContent{
//    UIView *view = [[UIView alloc] init];
//    view.backgroundColor = [UIColor whiteColor];
//    view.frame = self.bounds;
//    [self.contentView addSubview:view];
    
    DeviceInfoView *infoView = [[[NSBundle mainBundle]loadNibNamed:@"DeviceInfoView" owner:self options:nil] lastObject];
    infoView.frame = self.bounds;
    infoView.backgroundColor = SYSTEM_COLOR;
//    [self.contentView addSubview:infoView];
    return infoView;
}

- (UIView *)menuViewForMenuCount:(NSInteger)count{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(320 - 80*count, 0, 80*count, self.frame.size.height);
    view.backgroundColor = [UIColor clearColor];
    
    for (int i = 0; i < count; i++) {
        //        UIView *bgView = [[UIView alloc] init];
        //        bgView.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
        //        bgView.frame = CGRectMake(80*i, 0, 80, 80);
        //        [view addSubview:bgView];
        
        UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        menuBtn.tag = i;
        [menuBtn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        menuBtn.frame = CGRectMake(80*i, 0, 80, 100);
        //        [menuBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[[menuData objectAtIndex:i] objectForKey:@"stateNormal"]]] forState:UIControlStateNormal];
        //        [menuBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[[menuData objectAtIndex:i] objectForKey:@"stateHighLight"]]] forState:UIControlStateHighlighted];
        [menuBtn setTitle:@"test" forState:UIControlStateNormal];
        [menuBtn setBackgroundColor:[UIColor blackColor]];
        //        [bgView addSubview:menuBtn];
        [view addSubview:menuBtn];
    }
    
    return view;
}


- (void)configData:(KBDevices *)devices{
    
}

@end
