//
//  CircleRootViewController.h
//  KBLove
//
//  Created by 1124 on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DxConnection.h"
@interface CircleRootViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}
//添加Item
- (void)addBarItemWithImageName:(NSString *)img frame:(CGRect)frame  Target:(id) tar Selector:(SEL)selector isLeft:(BOOL)isleft;
//创建Nav标题Lable
- (UILabel *)makeTitleLable:(NSString *)title AndFontSize:(NSInteger)size isBold:(BOOL)isb;
//创建 Button
- (UIButton *)MakeButtonWithBgImgName:(NSString *)img SelectedImg:(NSString *)simg  Frame:(CGRect)frame target:(id)tar Sel:(SEL)selector AndTag:(NSInteger) tag;
//添加多个Item时 加入指定数组
- (void) addBarItemWithImageName:(NSString *)img frame:(CGRect)frame Target:(id)tar Selector:(SEL)selector ToArray:(NSMutableArray *)array andTag:(NSInteger) tag;

@end
