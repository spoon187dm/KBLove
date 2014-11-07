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
    //NSInteger
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
        imgv.image=[UIImage imageNamed:@"userimage"];
        imgv.userInteractionEnabled=YES;
        UILabel *la=[[UILabel alloc]initWithFrame:CGRectMake(0, 40, 40, 10)];
        [imgv addSubview:la];
        la.font=[UIFont boldSystemFontOfSize:10];
        la.text=finf.name;
        la.textColor=[UIColor whiteColor];
        la.textAlignment=NSTextAlignmentCenter;
        [self addSubview:imgv];
    }
        _FinishedBtn.frame=CGRectMake(260, (array.count/6*50)+10, 30, 30);
   // [_FinishedBtn setTitle:@"创建" forState:UIControlStateNormal];
    [_FinishedBtn addTarget:self action:@selector(FinishedClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_FinishedBtn];
    CGRect fr=self.frame;
    self.frame=CGRectMake(fr.origin.x,fr.origin.y+fr.size.height-(array.count/6+1)*50-5,fr.size.width, (array.count/6+1)*50+5);
    if (array.count==0) {
         self.frame=CGRectMake(fr.origin.x,fr.origin.y+fr.size.height,fr.size.width, 0);
    }
    
}
- (void)configUIWithFriendArray:(NSArray *)farray FinishedBtnArray:(NSArray *)finishedArr AndBlock:(SelectViewBlock)block AndFinishedBlock:(CreateFinishedBlock )fblock IsDelete:(BOOL)isdelete AndCircleUser_id:(NSString *)create_id
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
    for (int i=0; i<farray.count+finishedArr.count; i++) {
        
        
        UIImageView *imgv=[[UIImageView alloc]initWithFrame:CGRectMake((i%4)*70+20, (i/4*70+15), 50, 50)];
        imgv.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]init];
        imgv.tag=i;
        [tap addTarget:self action:@selector(TapClick:)];
        [imgv addGestureRecognizer:tap];
        imgv.layer.cornerRadius=5;
        imgv.layer.masksToBounds=YES;
        [self addSubview:imgv];
        if (i>farray.count-1) {
          imgv.image=[UIImage imageNamed:finishedArr[i-farray.count]];
        }else{
        KBFriendInfo *finf=farray[i];
        imgv.image=[UIImage imageNamed:@"userimage"];
        
        UILabel *la=[[UILabel alloc]initWithFrame:CGRectMake(imgv.frame.origin.x, imgv.frame.origin.y+55, 55, 10)];
        [self addSubview:la];
        la.font=[UIFont boldSystemFontOfSize:10];
        la.text=finf.name;
        la.textColor=[UIColor whiteColor];
        la.textAlignment=NSTextAlignmentCenter;
        if (isdelete) {
            NSString *fuser_id=finf.id;
            
            if ([fuser_id isEqualToString:create_id]) {
                
            }else{
            UIButton *btn=[UIButton buttonWithFrame:CGRectMake(imgv.frame.origin.x-5, imgv.frame.origin.y-5, 20, 20) title:@"" target:self Action:@selector(FinishedClick:)];
            btn.tag=i;
            btn.layer.cornerRadius=10;
            btn.layer.masksToBounds=YES;
            btn.backgroundColor=[UIColor redColor];
            [self addSubview:btn];
            }
            }
        }
        
    }
    
    CGRect fr=self.frame;
    NSLog(@"%lu",(unsigned long)farray.count);
    NSInteger linecount=(farray.count +finishedArr.count)/4+(((farray.count +finishedArr.count)%4)>0?1:0);
    NSLog(@"%ld",(long)linecount);
    self.frame=CGRectMake(fr.origin.x,fr.origin.y,fr.size.width, linecount*70+15);
    if (farray.count==0) {
        self.frame=CGRectMake(fr.origin.x,fr.origin.y,fr.size.width, 0);
    }

}
- (void)FinishedClick:(UIButton *)btn
{
    
    _fblock(btn.tag);
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
