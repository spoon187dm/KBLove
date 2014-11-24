//
//  DXsearchView.h
//  KBLove
//
//  Created by 1124 on 14/11/6.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DXsearchView;
@protocol DXSearchDisplayDelegate <NSObject>

- (void)SearchView:(DXsearchView *)searchView textDidChange:(NSString *)Searchtext;

@end

@interface DXsearchView : UIView<UITextFieldDelegate>
@property (nonatomic,strong) UITableView *searchResultsTableView;
- (IBAction)SearchBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *SearchBtn;
@property (weak, nonatomic) IBOutlet UIImageView *SearchBarBGImageView;
@property (weak, nonatomic) IBOutlet UITextField *SearchTextFiled;
@property (weak,nonatomic) UIViewController<DXSearchDisplayDelegate>* delegate;
- (void)setFrame:(CGRect)frame AndDelegate:(UIViewController<DXSearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate> *)delegate;
@end
