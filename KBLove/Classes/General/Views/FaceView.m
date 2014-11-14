//
//  FaceView.m
//  KBLove
//
//  Created by 1124 on 14/11/11.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "FaceView.h"

@implementation FaceView
{
    selectFaceBlock _selectBlock;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)configUIWithNameArray:(NSArray *)array AndBlock:(selectFaceBlock)block isAutoLayout:(BOOL)isaoutLayout
{
    //self.backgroundColor=[UIColor greenColor];
    //NSLog(@"%@",array);
    if (_selectBlock!=block) {
        _selectBlock=nil;
        _selectBlock=block;
    }
    self.autoresizesSubviews=NO;
    if (isaoutLayout) {
        _FaceScrollerView.frame=CGRectMake(0, -64, self.frame.size.width, self.frame.size.height+64);
        self.userInteractionEnabled=YES;
    }else
    {
        _FaceScrollerView.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        self.userInteractionEnabled=YES;
    }

    NSInteger pageCount=array.count/20+(array.count%20==0?0:1);
    //NSLog(@"%ld",pageCount);
    
    _FacePageController.numberOfPages=pageCount;
    _FaceScrollerView.delegate=self;
    
    for (int i=0; i<pageCount; i++) {
        UIView *faceView=[[UIView alloc]initWithFrame:CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, 170)];
        [_FaceScrollerView addSubview:faceView];
        faceView.userInteractionEnabled=YES;
        //[_FaceScrollerView addSubview:faceView];
        for (int j=0; j<20; j++) {
            if ((j+i*20)>=array.count) {
                break;
            }
            UIButton *btn=[UIButton buttonWithFrame:CGRectMake(30+j%7*40,20+ j/7*40, 30, 30) title:nil];
            btn.tag=j+i*20;
            //NSLog(@"%ld",btn.tag);
            [btn setBackgroundImage:[UIImage imageNamed:array[btn.tag]] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [faceView addSubview:btn];
            
        }
        
    }
    _FaceScrollerView.contentSize=CGSizeMake(320*6, 0);
    _FaceScrollerView.bounces=NO;
    //_FaceScrollerView.contentOffset=CGPointMake(320, 0);
    _FaceScrollerView.pagingEnabled=YES;
    //填充数据
    
    
}
- (void)btnClick:(UIButton *)btn
{
    if (_selectBlock) {
        _selectBlock (btn.tag);
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger currentpage=scrollView.contentOffset.x/self.frame.size.width;
    _FacePageController.currentPage=currentpage;
}
@end
