//
//  MessageCell.h
//  KBLove
//
//  Created by 1124 on 14/10/18.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBMessageInfo.h"
@interface MessageCell : UITableViewCell
- (void)configleftImage:(UIImage *)leftimage rightImage:(UIImage *)rightimage Message:(KBMessageInfo *)obj;
@property (nonatomic,copy)NSString *path;
//保存消息
@property (nonatomic,copy)NSString *messageStr;
- (CGFloat)getHightWithMOdel:(KBMessageInfo *)obj;
@end
