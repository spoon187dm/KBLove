//
//  CreateCircleBottomView.m
//  KBLove
//
//  Created by 1124 on 14-10-15.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "CreateCircleBottomView.h"

@implementation CreateCircleBottomView
{
    NSArray *_viewArray;
    SelectViewBlock _block;
    CreateFinishedBlock _fblock;
}
- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        _FinishedBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
   
    }
    return self;
}
- (void)ConfigUIWith:(NSArray *)array AndBlock:(SelectViewBlock)block AndFinishedBlock:(CreateFinishedBlock )fblock
{
    
    if (_fblock!=fblock) {
        _fblock=fblock;
    }
    if (_block!=block) {
        _block=block;
    }
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    for (int i=0; i<array.count; i++) {
        
        KBFriendInfo *finf=array[i];
        UIImageView *imgv=[[UIImageView alloc]initWithFrame:CGRectMake((i%6)*50+10, (i/6*50+5), 40, 40)];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]init];
        imgv.tag=i;
        [tap addTarget:self action:@selector(TapClick:)];
        [imgv addGestureRecognizer:tap];
        imgv.image=[UIImage imageNamed:@"loginQQ"];
        imgv.userInteractionEnabled=YES;
        UILabel *la=[[UILabel alloc]initWithFrame:CGRectMake(0, 40, 40, 10)];
        [imgv addSubview:la];
        la.font=[UIFont boldSystemFontOfSize:10];
        la.text=finf.name;
        la.textColor=[UIColor whiteColor];
        la.textAlignment=NSTextAlignmentCenter;
        [self addSubview:imgv];
    }
        _FinishedBtn.frame=CGRectMake(260, (array.count/6*50)+10, 50, 30);
   // [_FinishedBtn setTitle:@"创建" forState:UIControlStateNormal];
    [_FinishedBtn addTarget:self action:@selector(FinishedClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_FinishedBtn];
    CGRect fr=self.frame;
    self.frame=CGRectMake(fr.origin.x,fr.origin.y+fr.size.height-(array.count/6+1)*50-5,fr.size.width, (array.count/6+1)*50+5);
    if (array.count==0) {
         self.frame=CGRectMake(fr.origin.x,fr.origin.y+fr.size.height,fr.size.width, 0);
    }
    
}
- (void)FinishedClick:(UIButton *)btn
{
    
    _fblock();
}
- (void)TapClick:(UITapGestureRecognizer *)tap
{
    _block(tap.view.tag);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
