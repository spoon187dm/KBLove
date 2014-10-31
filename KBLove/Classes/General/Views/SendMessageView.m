//
//  SendMessageView.m
//  KBLove
//
//  Created by 1124 on 14/10/17.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "SendMessageView.h"

@implementation SendMessageView
{
    SendMessageBlock _sendBlock;
    CGRect _frame;
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
        
    }
    return self;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.textColor=[UIColor blackColor];
    _SendTextBtn.hidden=NO;
    _SendPositionBtn.hidden=YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _SendTextBtn.hidden=YES;
    _SendPositionBtn.hidden=NO;
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
//    NSInteger y=[[not.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey]CGRectValue].size.height;
//    [UIView animateWithDuration:0.3 animations:^{
//        
//        self.frame=CGRectMake(_frame.origin.x, _frame.origin.y-y, _frame.size.width, 49)
//        ;
//    }];
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
    _SendTextBtn.hidden=YES;
    _frame=self.frame;
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
        
        [[ImagePickerTool sharedInstance] pickImageWithType:WLImagePickerTypeLocal context:_delegate finishBlock:^(BOOL isSuccess, UIImage *image) {
        if (isSuccess) {
        KBMessageInfo *msginf=[[KBMessageInfo alloc]init];
            msginf.image=image;
            msginf.MessageType=KBMessageTypeTalkImage;
            _sendBlock(msginf);
            
        }else {
            [UIAlertView showWithTitle:@"温馨提示" Message:@"调取本地相册失败" cancle:@"确定" otherbutton:nil block:^(NSInteger index) {
                
            }];
        }

    }];

    
}

- (IBAction)SendPositionClick:(id)sender {
    //创建位置信息
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
