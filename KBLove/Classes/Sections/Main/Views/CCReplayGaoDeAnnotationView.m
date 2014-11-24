//
//  CCReplayGaoDeAnnotationView.m
//  baiDuTest
//
//  Created by qianfeng on 14-10-20.
//  Copyright (c) 2014年 zhangwenlong. All rights reserved.
//

#import "CCReplayGaoDeAnnotationView.h"

#import "ZWL_Utils.h"
///#import "CCTrackerUtils.h"

#define ANNOTATION_VIEW_WIDTH   182
#define ANNOTATION_FONT         [UIFont systemFontOfSize:14]
#define ANNOTATION_BG_PADDING   4

#define BG_PADDING_LEFT         20
#define BG_PADDING_TOP          16
#define BG_PADDING_RIGHT        20
#define BG_PADDING_BUTTOM       20

#define ARROW_WIDTH             15
#define ARROW_HEIGHT            10

#define LABEL_OFFSET            30
#define LABEL_PADDING_LEFT      15
#define LABEL_PADDING_TOP       10
#define LABEL_PADDING_RIGHT     15
#define LABEL_PADDING_BUTTOM    10

#define ICON_SIZE               30


@implementation CCReplayGaoDeAnnotationView
{
@private
    //    UIButton* _label;
    UILabel* _label;
    UIImageView* _bg;
    UIImageView* _arrow;
    UIImageView* _iconView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.canShowCallout = NO;
    }
    return self;
}


-(id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.canShowCallout = NO;
        
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ICON_SIZE, ICON_SIZE)];
        _iconView.contentMode = UIViewContentModeCenter;
        [self addSubview:_iconView];
        
        _bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ANNOTATION_VIEW_WIDTH, 60)];
        [ZWL_Utils setUIImageViewStretchImage:_bg imageName:@"replay_name_bg.png" scaleIfNotRetina:NO
                                         left:BG_PADDING_LEFT top:BG_PADDING_TOP right:BG_PADDING_RIGHT bottom:BG_PADDING_LEFT];
        [self addSubview:_bg];
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ANNOTATION_VIEW_WIDTH, 60)];
        _label.backgroundColor = [UIColor clearColor];
        _label.lineBreakMode = NSLineBreakByWordWrapping;
        _label.font = ANNOTATION_FONT;
        _label.textColor = [UIColor whiteColor];
        [self addSubview:_label];
        
        _arrow = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ARROW_WIDTH, ARROW_HEIGHT)];
        _arrow.image =[UIImage imageNamed:@"name_background_arraw.png"] ;
        [self addSubview:_arrow];
    }
    
    return self;
}

-(void)hideTitle {
    _bg.hidden = YES;
    _label.hidden = YES;
    _arrow.hidden = YES;
    CGFloat centerX = [ZWL_Utils centerX:self];
    CGFloat centerY = [ZWL_Utils centerY:self];
    
    if (_icon) {
        _iconView.frame = CGRectMake(0, 0, ICON_SIZE/2.0f, ICON_SIZE/2.0f);
    }
    _iconView.center = CGPointMake(centerX, centerY);
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat centerX = [ZWL_Utils centerX:self];
    CGFloat centerY = [ZWL_Utils centerY:self];
    
    if (_icon) {
        _iconView.frame = CGRectMake(0, 0, ICON_SIZE/2.0f, ICON_SIZE/2.0f);
    }
    _iconView.center = CGPointMake(centerX, centerY);
    
    [_label sizeToFit];
    _label.center = CGPointMake(centerX, - LABEL_OFFSET);
    
    _bg.frame = [ZWL_Utils extendRect:_label.bounds left:LABEL_PADDING_LEFT top:LABEL_PADDING_TOP right:LABEL_PADDING_RIGHT bottom:LABEL_PADDING_BUTTOM];
    _bg.center = CGPointMake(centerX, centerY - LABEL_OFFSET + ANNOTATION_BG_PADDING);
    
    // 箭头
    _arrow.center = CGPointMake(centerX, [ZWL_Utils bottom:_bg] - [ZWL_Utils centerY:_arrow]);
}

-(void)setContent:(NSString *)content
{
    _content = content;
    if (_label) {
        _label.text = content;
        [_label sizeToFit];
        _label.center = CGPointMake([ZWL_Utils centerX:self], - LABEL_OFFSET);
    }
}

-(void)setIcon:(UIImage *)icon
{
    _iconView.image = icon;
    [self setNeedsLayout];
}

-(void)setAngle:(CGFloat)angle
{
    _angle = angle;
    _iconView.layer.anchorPoint = CGPointMake (0.5f, 0.5f);
    _iconView.transform = CGAffineTransformMakeRotation(angle);
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
