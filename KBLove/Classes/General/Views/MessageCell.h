//
//  MessageCell.h
//  KBLove
//
//  Created by 1124 on 14/10/18.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBMessageInfo.h"
typedef void (^MessageClickBlock)(NSIndexPath * path);
@interface MessageCell : UITableViewCell
- (void)configleftImage:(UIImage *)leftimage rightImage:(UIImage *)rightimage Message:(KBMessageInfo *)obj WithPath:(NSIndexPath *)path AndBlock:(MessageClickBlock)block;
@property (nonatomic,copy)NSIndexPath *path;
//保存消息
@property (nonatomic,copy)NSString *messageStr;
- (CGFloat)getHightWithMOdel:(KBMessageInfo *)obj;
@end
