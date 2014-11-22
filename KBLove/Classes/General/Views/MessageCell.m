//
//  MessageCell.m
//  KBLove
//
//  Created by 1124 on 14/10/18.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "MessageCell.h"
#import "MessageView.h"
#import "PositionView.h"
#import "KBPositionInfo.h"
@implementation MessageCell
{
    //左边
    UIImageView *leftheaderImageView;
    //左边气泡
    UIImageView *leftBubbleImageView;

    //左边位置
    //StickerImageView *leftBigImageView;
    //左边文字
    MessageView *leftTitleView;
    //左边图片
    UIImageView *leftphotoImageView;
    //左边 位置 信息
    PositionView *leftPosView;
    //右边
    UIImageView *rightheaderImageView;
    //右边气泡
    UIImageView *rightBubbleImageView;
    //右边位置
   // StickerImageView *rightBigImageView;
    //右边文字
    MessageView *rightTitleView;
    //右边图片
    UIImageView *rightphotoImageView;
    //右边位置信息
    PositionView *rightPosView;
    MessageClickBlock _msgBlock;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       [self makeUI]; 
    }
    return self;
}
- (id)init
{
    self=[super init];
    if (self) {
        
    }
    return  self;
}
- (void)makeUI
{
    
    float y=[UIScreen mainScreen].bounds.size.width;

    leftheaderImageView=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
//    //圆角
//    leftheaderImageView.layer.cornerRadius=15;
//    leftheaderImageView.layer.masksToBounds=YES;
    [self.contentView addSubview:leftheaderImageView];
    //气泡,大小根据内容制定
    leftBubbleImageView=[UIImageView imageViewWithFrame:CGRectMake(0, 0, 0, 0) image:nil];
    leftBubbleImageView.userInteractionEnabled=YES;
    //添加点击事件
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]init];
    [tap addTarget:self action:@selector(TapClick:)];
    [leftBubbleImageView addGestureRecognizer:tap];
    [self.contentView addSubview:leftBubbleImageView];
    //图片 图片来源于主题气泡图片
    UIImage *image=[UIImage imageNamed:@"Bullue"];
    //我们需要把图像翻转180度
    image=[UIImage imageWithCGImage:image.CGImage scale:2 orientation:UIImageOrientationUpMirrored];
    //设置拉伸比例
    image=[image stretchableImageWithLeftCapWidth:40 topCapHeight:28];
    leftBubbleImageView.image=image;
    //语音，文子，大图片，大表情加载在leftBulle上
    leftphotoImageView=[UIImageView imageViewWithFrame:CGRectZero image:nil];
    [leftBubbleImageView addSubview:leftphotoImageView];
  
    //文子
    leftTitleView=[[MessageView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [leftBubbleImageView addSubview:leftTitleView];
    //图片
    //左侧位置视图
    leftPosView=[[[NSBundle mainBundle]loadNibNamed:@"PositionView" owner:self options:nil]lastObject];
    [leftBubbleImageView addSubview:leftPosView];
    rightheaderImageView=[UIImageView imageViewWithFrame:CGRectMake(y-35, 5, 30, 30) image:nil];
    
//    //圆角
//    rightheaderImageView.layer.cornerRadius=15;
//    rightheaderImageView.layer.masksToBounds=YES;
    [self.contentView addSubview:rightheaderImageView];
    //气泡,大小根据内容制定
    rightBubbleImageView=[UIImageView imageViewWithFrame:CGRectZero image:nil];
    rightBubbleImageView.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapr=[[UITapGestureRecognizer alloc]init];
    [tapr addTarget:self action:@selector(TapClick:)];
    [rightBubbleImageView addGestureRecognizer:tapr];
    [self.contentView addSubview:rightBubbleImageView];
    //图片 图片来源于主题气泡图片
    UIImage *image1=[UIImage imageNamed:@"Bullue"];
    image1=[image1 stretchableImageWithLeftCapWidth:40 topCapHeight:28];
    rightBubbleImageView.image=image1;
    [self.contentView addSubview:rightBubbleImageView];
    //语音，文子，大图片，大表情加载在leftBulle上
    rightphotoImageView=[UIImageView imageViewWithFrame:CGRectZero image:nil];
    [rightBubbleImageView addSubview:rightphotoImageView];
    //文子
    rightTitleView=[[MessageView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [rightBubbleImageView addSubview:rightTitleView];
    //右侧位置视图
    rightPosView=[[[NSBundle mainBundle]loadNibNamed:@"PositionView" owner:self options:nil]lastObject];
    [rightBubbleImageView addSubview:rightPosView];
}
- (void)configleftImage:(UIImage *)leftimage rightImage:(UIImage *)rightimage Message:(KBMessageInfo *)obj WithPath:(NSIndexPath *)path AndBlock:(MessageClickBlock)block

{
    _path=path;
    if (_msgBlock!=block) {
        _msgBlock=nil;
        _msgBlock=block;
    }
    float y=[UIScreen mainScreen].bounds.size.width;
    leftheaderImageView.image=leftimage;
    rightheaderImageView.image=rightimage;

    if ([[NSString stringWithFormat:@"%@",obj.FromUser_id] isEqualToString:[NSString stringWithFormat:@"%@",[KBUserInfo sharedInfo].user_id]]) {
        //自己
        leftheaderImageView.hidden=YES;
        leftBubbleImageView.hidden=YES;
        
        rightheaderImageView.hidden=NO;
        rightBubbleImageView.hidden=NO;
        
        if (obj.MessageType==KBMessageTypeTalkText) {
           
            rightphotoImageView.hidden=YES;
            rightPosView.hidden=YES;
            rightTitleView.hidden=NO;
            //rightTitle.text=obj.text;
            [rightTitleView setString:obj.text WithMaxWidth:200 AndAttributris:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
            
            NSLog(@"%@",obj.text);
            CGSize size=rightTitleView.frame.size;
            rightTitleView.frame=CGRectMake(5, 10,size.width,size.height);
            //设置气泡大小
            rightBubbleImageView.frame=CGRectMake(y-40-size.width-25, 5, size.width+25, size.height+20);
        }else if(obj.MessageType==KBMessageTypeTalkImage)
        {
            rightphotoImageView.hidden=NO;
            rightTitleView.hidden=YES;
            rightPosView.hidden=YES;
            UIImage *photoimage=obj.image;
            //计算大小
            rightphotoImageView.frame=CGRectMake(10, 15, photoimage.size.width>200?200:photoimage.size.width, photoimage.size.height>200?200:photoimage.size.height);
            rightphotoImageView.image=photoimage;
            rightBubbleImageView.frame=CGRectMake(y-40-rightphotoImageView.frame.size.width-20, 10, rightphotoImageView.frame.size.width+30, rightphotoImageView.frame.size.height+30);
            
            
            
        }else if (obj.MessageType==KBMessageTypeTalkPosition)
        {
            rightphotoImageView.hidden=YES;
            rightTitleView.hidden=YES;
            rightPosView.hidden=NO;
            NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:[obj.text dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
            KBPositionInfo *pos=[[KBPositionInfo alloc]init];
            [pos setValuesForKeysWithDictionary:dic];
            rightPosView.PositionNameLable.text=pos.positionname;
            rightPosView.PositionDesLable.text=pos.positionDes;
            rightPosView.frame=CGRectMake(5, 5, 150, 80);
            rightBubbleImageView.frame=CGRectMake(y-40-rightPosView.frame.size.width-20, 10, rightPosView.frame.size.width+15, rightPosView.frame.size.height+15);
        }
    }else
    {
        leftheaderImageView.hidden=NO;
        leftBubbleImageView.hidden=NO;
        rightheaderImageView.hidden=YES;
        rightBubbleImageView.hidden=YES;
        //对方
       // NSLog(@"%ld",obj.MessageType);
        if (obj.MessageType==KBMessageTypeTalkText) {
            leftphotoImageView.hidden=YES;
            leftPosView.hidden=YES;
            leftTitleView.hidden=NO;
            [leftTitleView setString:obj.text WithMaxWidth:200 AndAttributris:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
            CGSize size=leftTitleView.frame.size;
            //leftTitle.font=[UIFont systemFontOfSize:15];
            leftTitleView.frame=CGRectMake(15, 10, size.width, size.height);
            //[leftTitle AdjustCurrentFont];
            //设置气泡大小
            leftBubbleImageView.frame=CGRectMake(40, 5, size.width+30, size.height+20);
        }else if(obj.MessageType==KBMessageTypeTalkImage)
        {
            leftphotoImageView.hidden=NO;
            leftTitleView.hidden=YES;
            leftPosView.hidden=YES;
            UIImage *photoimage=obj.image;
            //计算大小
            leftphotoImageView.frame=CGRectMake(15, 15, photoimage.size.width>200?200:photoimage.size.width, photoimage.size.height>200?200:photoimage.size.height);
            leftphotoImageView.image=photoimage;
            leftBubbleImageView.frame=CGRectMake(40, 5, leftphotoImageView.frame.size.width+30, leftphotoImageView.frame.size.height+30);
            
            //在这里 添加 位置 展示的View
            
        }else if (obj.MessageType==KBMessageTypeTalkPosition)
        {
            leftphotoImageView.hidden=YES;
            leftTitleView.hidden=YES;
            leftPosView.hidden=NO;
            
            NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:[obj.text dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
            KBPositionInfo *pos=[[KBPositionInfo alloc]init];
            [pos setValuesForKeysWithDictionary:dic];
            leftPosView.PositionNameLable.text=pos.positionname;
            leftPosView.PositionDesLable.text=pos.positionDes;
            leftPosView.frame=CGRectMake(40, 5, 150, 80);

            leftBubbleImageView.frame=CGRectMake(40, 5, leftPosView.frame.size.width+15, leftPosView.frame.size.height+15);
        }
    }
    //保存消息
    //_messageStr=message;
}
- (CGFloat)getHightWithMOdel:(KBMessageInfo *)obj
{
    [self configleftImage:nil rightImage:nil Message:obj WithPath:_path AndBlock:_msgBlock];
    if ([[NSString stringWithFormat:@"%@",obj.FromUser_id] isEqualToString:[NSString stringWithFormat:@"%@",[KBUserInfo sharedInfo].user_id]])
    {
        if (rightBubbleImageView.frame.size.height<30) {
            return 30+20;
        }else
        {
            return rightBubbleImageView.frame.size.height+20;
        }
    }else
    {
        if (leftBubbleImageView.frame.size.height<30) {
            return 30+20;
        }
    }
    return leftBubbleImageView.frame.size.height+20;
}
- (void)TapClick:(UITapGestureRecognizer *)tap
{
    if (_msgBlock) {
        _msgBlock(_path);
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
