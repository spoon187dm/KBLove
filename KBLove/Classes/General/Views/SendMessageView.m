//
//  SendMessageView.m
//  KBLove
//
//  Created by 1124 on 14/10/17.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "SendMessageView.h"
#import "Circle_ShareViewController.h"
static void *facesScrollerContext=&facesScrollerContext;
#import "FaceView.h"
@implementation SendMessageView
{
    SendMessageBlock _sendBlock;
    CGRect _frame;
    FaceView *_facesView;
    NSDictionary *_faceDic;
   // NSMutableString *_sendStr;
    NSMutableArray *namearr;
    NSMutableArray *DisPlayArr;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if (self) {
                [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keybordShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(KeyBoardHide:) name:UIKeyboardWillHideNotification object:nil];
        _facesView=[[[NSBundle mainBundle]loadNibNamed:@"FaceView" owner:self options:nil]lastObject];
       // [self addSubview:_facesView];
        [_facesView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:facesScrollerContext];
        //初始化名称列表
        namearr=[[NSMutableArray alloc]init];
        for (int i=0; i<105; i++) {
            NSString *str=[NSString stringWithFormat:@"%d",1000+i];
            [namearr addObject:[str substringFromIndex:1]];
        }
        //初始化对应字典
        NSString *path=[[NSBundle mainBundle]pathForResource:@"Face" ofType:@"plist"];
        _faceDic=[NSDictionary dictionaryWithContentsOfFile:path];
        DisPlayArr =[[NSMutableArray alloc]init];
        for (int i=0; i<namearr.count; i++) {
            [DisPlayArr addObject:[_faceDic objectForKey:namearr[i]]];
            
        }
        //初始化发送字符串
       // _sendStr=[[NSMutableString alloc]init];
        //_SendMsgTextFiled.textColor=[UIColor blackColor];
        
    }
    return self;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    _SendTextBtn.hidden=NO;
    _SendPositionBtn.hidden=YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _SendTextBtn.hidden=YES;
    _SendPositionBtn.hidden=NO;
    _SendMsgTextFiled.textColor=[UIColor blackColor];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    self.frame=CGRectMake(_frame.origin.x, _frame.origin.y-_facesView.frame.size.height, _frame.size.width, _frame.size.height);
}
- (void)keybordShow:(NSNotification *)notification
{
    CGFloat animationTime = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:animationTime animations:^{
        CGRect keyBoardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        if (self.frame.size.height>45) {
            self.frame = CGRectMake(0, keyBoardFrame.origin.y-self.frame.size.height,_frame.size.width,self.frame.size.height);
        }else{
            self.frame = CGRectMake(0, keyBoardFrame.origin.y-45,_frame.size.width,49);
        }
    }];
}
- (void)KeyBoardHide:(NSNotification *)not
{
    self.frame=_frame;
}
- (void)setBlock:(SendMessageBlock)block AndDelegate:(UIViewController *)delegate
{
    
    _delegate=delegate;
    if(_sendBlock!=block)
    {
        _sendBlock=block;
    }

    _SendMsgTextFiled.delegate=self;
    //[_SendMsgTextFiled setTextColor:[UIColor blackColor]];
    _SendMsgTextFiled.textColor=[UIColor blackColor];
   // _SendMsgTextFiled.textInputMode=
    _SendTextBtn.hidden=YES;
    _frame=self.frame;
    _facesView.frame=CGRectMake(0, _frame.size.height, _frame.size.width, 170);
    
    

    [_facesView configUIWithNameArray:namearr AndBlock:^(NSInteger selecttag) {
       //点击表情回掉函数
        NSLog(@"%d",selecttag);
        _SendMsgTextFiled.text=[NSString stringWithFormat:@"%@[%@]",_SendMsgTextFiled.text,DisPlayArr[selecttag]];
        _SendTextBtn.hidden=NO;
        _SendPositionBtn.hidden=YES;
        
    } isAutoLayout:_delegate.automaticallyAdjustsScrollViewInsets];
    _facesView.frame=CGRectMake(_frame.origin.x, _frame.size.height+_frame.origin.y, _frame.size.width, 0);
    
    [_delegate.view addSubview:_facesView];
    
}
- (void)FaceClick:(UIButton *)btn
{
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
   // NSLog(@"%d,%d",range.location,range.length);
    if (range.length>0) {
        //减
        NSString *lastchar=[textField.text substringWithRange:NSMakeRange(textField.text.length-1, 1)];
        if ([lastchar isEqualToString:@"]"]) {
            NSRange range=[textField.text rangeOfString:@"[" options:NSBackwardsSearch];
            NSString *str=[textField.text substringWithRange:NSMakeRange(range.location+1, textField.text.length-range.location-2)];
          //  NSLog(@"%@",str);
            if ([DisPlayArr containsObject:str]) {
                textField.text =[textField.text substringToIndex:range.location];
                return NO;
            }
            
        }
    }
    return YES;
}
- (void)TextChange:(UITextField *)textfile
{
    CGSize size=[UILabel SizeWithText:textfile.text Width:textfile.frame.size.width andFont:textfile.font];
    if (size.height>20) {
        CGRect rect=textfile.frame;
        rect.size.height=size.height;
        textfile.frame=rect;
        self.frame=CGRectMake(_frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height+rect.size.height-30);
    }
}
- (IBAction)SendImageBtnClick:(id)sender {
        
//        [[ImagePickerTool sharedInstance] pickImageWithType:WLImagePickerTypeLocal context:_delegate finishBlock:^(BOOL isSuccess, UIImage *image) {
//        if (isSuccess) {
//        KBMessageInfo *msginf=[[KBMessageInfo alloc]init];
//            msginf.image=image;
//            msginf.MessageType=KBMessageTypeTalkImage;
//            _sendBlock(msginf);
//            
//        }else {
//            [UIAlertView showWithTitle:@"温馨提示" Message:@"调取本地相册失败" cancle:@"确定" otherbutton:nil block:^(NSInteger index) {
//                
//            }];
//        }

  //  }];
    [_SendMsgTextFiled resignFirstResponder];
    if(_facesView.frame.size.height>0)
    {
      _facesView.frame=CGRectMake(_frame.origin.x, _frame.size.height+_frame.origin.y, _frame.size.width, 0);
    }else
    {
        _facesView.frame=CGRectMake(_frame.origin.x,_frame.origin.y-170+_frame.size.height, _frame.size.width,170);
    }
    
    
    
}

- (IBAction)SendPositionClick:(id)sender {
    //创建位置信息
    Circle_ShareViewController *cvc=[[Circle_ShareViewController alloc]init];
    [cvc setBlock:^(KBPositionInfo *pos) {
       //返回信息 进行 处理
        NSLog(@"发送 地理 位置 ");
        
        NSMutableDictionary *senddic=[[NSMutableDictionary alloc]init];
        [senddic setObject:pos.positionname forKey:@"positionname"];
        [senddic setObject:pos.latitudeNumber forKey:@"latitudeNumber"];
        [senddic setObject:pos.longitudeNumber forKey:@"longitudeNumber"];
        [senddic setObject:pos.positionDes forKey:@"positionDes"];
        NSString *str=[[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:senddic options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str);
        //创建消息
        KBMessageInfo *msg=[[KBMessageInfo alloc]init];
        msg.MessageType=KBMessageTypeTalkPosition;
        msg.text=str;
        _sendBlock(msg);
    }];
    UIViewController *vc=(UIViewController *)_delegate;
    [vc.navigationController pushViewController:cvc animated:YES];
}

- (IBAction)SendTextClick:(id)sender {
    if (_SendMsgTextFiled.text.length>=1) {
    KBMessageInfo *msginfo=[[KBMessageInfo alloc]init];
        msginfo.MessageType=KBMessageTypeTalkText;
        msginfo.text=_SendMsgTextFiled.text;
        _sendBlock(msginfo);
    }else
    {
        [UIAlertView showWithTitle:@"温馨提示" Message:@"信息不能为空" cancle:@"确定" otherbutton:nil block:^(NSInteger index) {
            
        }];
    }
    _SendMsgTextFiled.text=nil;
   // [_SendMsgTextFiled resignFirstResponder];
}
@end
