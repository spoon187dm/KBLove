//
//  DXSwitch.m
//  KBLove
//
//  Created by 1124 on 14/10/23.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "DXSwitch.h"

@implementation DXSwitch
+ (DXSwitch *)SwitchWithSlipColor:(UIColor *)slipColor OffSlipColor:(UIColor *)offSlipcolor OnTintColor:(UIColor *)ontintcolor  OffTintColor:(UIColor *)offtintcolor OnText:(NSString *)text OffText:(NSString *)offtext AndFrame:(CGRect )frame
{
    DXSwitch *ds=[[DXSwitch alloc]initWithFrame:frame];
    ds.slipColor=slipColor;
    ds.offSlipColor=offSlipcolor;
    ds.onTintColor=ontintcolor;
    ds.offTintColor=offtintcolor;
    ds.onText=text;
    ds.offText=offtext;
    ds.ON=YES;
    return ds;
}

- (void)awakeFromNib{
    CGRect frame = CGRectMake(0, 0, 46, 30);
    _onLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    _offLable=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.width-frame.size.height, 0, frame.size.width,frame.size.height)];
    [self addSubview:_onLable];
    [self addSubview:_offLable];
    _slipView=[[UIView alloc]initWithFrame:CGRectMake(frame.size.width-frame.size.height, 0, frame.size.height, frame.size.height)];
    _slipView.layer.cornerRadius=frame.size.height/2;
    _slipView.layer.masksToBounds=YES;
    _slipView.layer.borderWidth=1;
    _slipView.layer.borderColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3].CGColor;
    _slipView.layer.shadowOffset=CGSizeMake(0, 10);
    _slipView.layer.shadowRadius=frame.size.height/2;
    _slipView.layer.shadowColor=[UIColor blackColor].CGColor;
    _slipView.layer.shadowOpacity=0.9;
    //_slipView
    [self addSubview:_slipView];
    self.contentSize=frame.size;
    self.bounces=NO;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapClick:)];
    _ON=YES;
    [self addGestureRecognizer:tap];
    self.layer.cornerRadius=frame.size.height/2;
    self.layer.masksToBounds=YES;
    
    [self setSlipColor:[UIColor colorWithRed:58/255.0 green:200/255.0 blue:204/255.0 alpha:1]];
    [self setOffSlipColor:[UIColor whiteColor]];
    [self setOnTintColor:[UIColor whiteColor]];
    [self setOffTintColor:[UIColor whiteColor]];
}

- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        _onLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _offLable=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.width-frame.size.height, 0, frame.size.width,frame.size.height)];
        [self addSubview:_onLable];
        [self addSubview:_offLable];
        _slipView=[[UIView alloc]initWithFrame:CGRectMake(frame.size.width-frame.size.height, 0, frame.size.height, frame.size.height)];
        _slipView.layer.cornerRadius=frame.size.height/2;
        _slipView.layer.masksToBounds=YES;
        _slipView.layer.borderWidth=1;
        _slipView.layer.borderColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3].CGColor;
        _slipView.layer.shadowOffset=CGSizeMake(0, 10);
        _slipView.layer.shadowRadius=frame.size.height/2;
        _slipView.layer.shadowColor=[UIColor blackColor].CGColor;
        _slipView.layer.shadowOpacity=0.9;
        //_slipView
        [self addSubview:_slipView];
        self.contentSize=frame.size;
        self.bounces=NO;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapClick:)];
        _ON=YES;
        [self addGestureRecognizer:tap];
        self.layer.cornerRadius=frame.size.height/2;
        self.layer.masksToBounds=YES;
    }
    return self;
}
- (void)TapClick:(UITapGestureRecognizer *)tap
{
    // self.ON=!_ON;
    [self setON:!_ON animation:YES];
    
}
- (void)setON:(BOOL)ON
{
   // _ON=ON;
    [self setON:ON animation:NO];
}
- (void)setON:(BOOL)ON animation:(BOOL)anamation
{
    _ON=ON;
    if ([_swdelegate respondsToSelector:@selector(SwitchValueChange:)]) {
        [_swdelegate SwitchValueChange:self];
    }
    if (_valueChangeBlock) {
        _valueChangeBlock(ON);
    }
    NSTimeInterval interval;
    if (anamation) {
        interval=0.3;
    }else
    {
        interval=0;
    }
    [UIView animateWithDuration:interval animations:^{
        if (_ON) {
            self.backgroundColor=_offTintColor;
            self.contentOffset=CGPointMake(0, 0);
            _onLable.hidden=NO;
            _offLable.hidden=YES;
            _slipView.backgroundColor=_offSlipColor;
        }else
        {
            self.backgroundColor=_onTintColor;
            self.contentOffset=CGPointMake(self.frame.size.width-self.frame.size.height, 0);
            _offLable.hidden=NO;
            _onLable.hidden=YES;
            _slipView.backgroundColor=_slipColor;
        }
   
    } completion:^(BOOL finished) {
        if (_ON) {
            _slipView.backgroundColor=_slipColor;
        }else
        {
            _slipView.backgroundColor=_offSlipColor;
        }
    }];
    [UIView animateWithDuration:interval animations:^{
 
    }];

}
- (void)setSlipColor:(UIColor *)slipColor
{
    
    if (_ON) {
        _slipView.backgroundColor=slipColor;
    }
    _slipColor=slipColor;
    
}
- (void)setOffSlipColor:(UIColor *)offSlipColor
{
    if (!_ON) {
        _slipView.backgroundColor=offSlipColor;
    }
    _offSlipColor=offSlipColor;
}
- (void)setOffTintColor:(UIColor *)offTintColor
{
    _offLable.backgroundColor=offTintColor;
    _offTintColor=offTintColor;
}
- (void)setOnTintColor:(UIColor *)onTintColor
{
    _onLable.backgroundColor=onTintColor;
    _onTintColor=onTintColor;
}
- (void)setOnText:(NSString *)onText
{
    _onText=onText;
    _onLable.text=onText;
}
- (void)setOffText:(NSString *)offText
{
    _offText=offText;
    _offLable.text=offText;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
