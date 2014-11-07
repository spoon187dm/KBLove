//
//  DXsearchView.m
//  KBLove
//
//  Created by 1124 on 14/11/6.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "DXsearchView.h"
@implementation DXsearchView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if (self) {

        
//        self addObserver:self forKeyPath:@"frame" options:<#(NSKeyValueObservingOptions)#> context:<#(void *)#>
    }
    return  self;
}
//- (void)setFrame:(CGRect)frame
//{}
- (void)setFrame:(CGRect)frame AndDelegate:(UIViewController<DXSearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate> *)delegate
{
    self.frame=frame;
    [_SearchTextFiled becomeFirstResponder];
    self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    _SearchTextFiled.delegate=self;
    _searchResultsTableView=[[UITableView alloc]initWithFrame:self.frame style:UITableViewStylePlain];
    [self addSubview:_searchResultsTableView];
    _searchResultsTableView.hidden=YES;
   // frame=frame;
    _delegate=delegate;
    _delegate.navigationController.navigationBar.hidden=YES;
    _searchResultsTableView.delegate=delegate;
    _searchResultsTableView.dataSource=delegate;
    _searchResultsTableView.frame=CGRectMake(0, 44, self.frame.size.width, self.frame.size.height-44);
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"%@",string);
    NSLog(@"%lu,%lu",(unsigned long)range.location,(unsigned long)range.length);
    NSString *Allstr=[NSString stringWithFormat:@"%@%@",textField.text,string];
    NSString *resultstr;
    if (range.length>0) {
        resultstr=[Allstr substringToIndex:range.location-range.length+1];
    }else
    {
        resultstr=Allstr;
    }
    NSLog(@"%@",resultstr);
    if (resultstr.length==0) {
        _searchResultsTableView.hidden=YES;
    }else{
    _searchResultsTableView.hidden=NO;
    }
    if ([_delegate respondsToSelector:@selector(SearchView:textDidChange:)]) {
        [_delegate SearchView:self textDidChange:resultstr];
    }
    [_searchResultsTableView reloadData];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismissSearchView];
    
}
- (void)refreashData
{

    [_searchResultsTableView reloadData];
}
- (void)dismissSearchView
{
    if (_delegate) {
        _delegate.navigationController.navigationBar.hidden=NO;
        _delegate=nil;
    }
   [self removeFromSuperview];
}
- (IBAction)SearchBtnClick:(id)sender {
    [self dismissSearchView];
}
@end
