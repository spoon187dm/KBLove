//
//  DatePickerView.m
//  哈哈
//
//  Created by Ming on 14-11-19.
//  Copyright (c) 2014年 MJ. All rights reserved.
//

#import "DatePickerView.h"
#import "JudgeDate.h"

#define YMDSCROLLVIEW_COUNT 3
#define HMSCROLLVIEW_COUNT 2
#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height
#define HEIGHT_INT (int)HEIGHT/5
#define YEARMAX 2014
#define YEARMIN 1992

@implementation DatePickerView

{
    NSMutableDictionary * dateDictionary;
    NSMutableArray *dateArray;
    PickerType _type;
    NSDate *date;
    NSString *dateStr;
    NSString *yearStr;
    NSString *monthStr;
    NSString *dayStr;
    NSString *hourStr;
    NSString *minuteStr;
    NSDateFormatter *dateFormater;
    NSMutableArray *yearArray;
    NSMutableArray *monthArray;
    NSMutableArray *dayArray;
    NSMutableArray *hourArray;
    NSMutableArray *minuteArray;
    NSLock *lock;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        CGSize size = [UIScreen mainScreen].bounds.size;
        self = [[[self class] alloc] initWithFrame:CGRectMake(size.width/8, size.height/10*3.5, size.width *3/4, size.height*0.3)];
        [self createArray];
        lock = [[NSLock alloc] init];
    }
    return self;
}

-(void)createArray
{
    date = [NSDate date];
    dateFormater = [[NSDateFormatter alloc] init];
    dateFormater.dateFormat = @"yyyy-MM-dd HH:mm";
    dateStr = [dateFormater stringFromDate:date];
    yearStr = [dateStr substringToIndex:4];
    monthStr = [dateStr substringWithRange:NSMakeRange(5, 2)];
    dayStr = [dateStr substringWithRange:NSMakeRange(8, 2)];
    hourStr = [dateStr substringWithRange:NSMakeRange(11, 2)];
    minuteStr = [dateStr substringFromIndex:14];
    dateDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
    [dateDictionary setObject:yearStr forKey:@"year"];
    [dateDictionary setObject:monthStr forKey:@"month"];
    [dateDictionary setObject:dayStr forKey:@"day"];
    [dateDictionary setObject:hourStr forKey:@"hour"];
    [dateDictionary setObject:minuteStr forKey:@"minute"];
    //年
    yearArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = YEARMIN; i <= YEARMAX; i++) {
        if (i == YEARMIN) {
            [yearArray addObject:[NSString stringWithFormat:@"%d",YEARMAX - 2]];
            [yearArray addObject:[NSString stringWithFormat:@"%d",YEARMAX - 1]];
            [yearArray addObject:[NSString stringWithFormat:@"%d",YEARMAX]];
        }
        [yearArray addObject:[NSString stringWithFormat:@"%d",i]];
        if (i == YEARMAX) {
            [yearArray addObject:[NSString stringWithFormat:@"%d",YEARMIN]];
            [yearArray addObject:[NSString stringWithFormat:@"%d",YEARMIN + 1]];
            [yearArray addObject:[NSString stringWithFormat:@"%d",YEARMIN + 2]];
        }
    }
    //月
    monthArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 12; i++) {
        if (i == 0) {
            [monthArray addObject:[NSString stringWithFormat:@"%02d",10]];
            [monthArray addObject:[NSString stringWithFormat:@"%02d",11]];
            [monthArray addObject:[NSString stringWithFormat:@"%02d",12]];
        }
        [monthArray addObject:[NSString stringWithFormat:@"%02d",i + 1]];
        if (i == 11) {
            [monthArray addObject:[NSString stringWithFormat:@"%02d",1]];
            [monthArray addObject:[NSString stringWithFormat:@"%02d",2]];
            [monthArray addObject:[NSString stringWithFormat:@"%02d",3]];
        }
    }
    //日
    JudgeDate *judgeDate = [[JudgeDate alloc] init];
    [judgeDate setYear:dateDictionary[@"year"] andMonth:dateDictionary[@"month"] dayCountBlick:^(int dayCount) {
        dayArray = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i < dayCount; i++) {
            if (i == 0) {
                [dayArray addObject:[NSString stringWithFormat:@"%02d",dayCount - 2]];
                [dayArray addObject:[NSString stringWithFormat:@"%02d",dayCount - 1]];
                [dayArray addObject:[NSString stringWithFormat:@"%02d",dayCount]];
            }
            [dayArray addObject:[NSString stringWithFormat:@"%02d",i + 1]];
            if (i == dayCount - 1) {
                [dayArray addObject:[NSString stringWithFormat:@"%02d",1]];
                [dayArray addObject:[NSString stringWithFormat:@"%02d",2]];
                [dayArray addObject:[NSString stringWithFormat:@"%02d",3]];
            }
        }
        [dateDictionary setObject:[NSString stringWithFormat:@"%d",dayCount] forKey:@"day"];
    }];
    
    //时
    hourArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 24; i++) {
        if (i == 0) {
            [hourArray addObject:[NSString stringWithFormat:@"%02d",21]];
            [hourArray addObject:[NSString stringWithFormat:@"%02d",22]];
            [hourArray addObject:[NSString stringWithFormat:@"%02d",23]];
        }
        [hourArray addObject:[NSString stringWithFormat:@"%02d",i]];
        if (i == 23) {
            [hourArray addObject:[NSString stringWithFormat:@"%02d",0]];
            [hourArray addObject:[NSString stringWithFormat:@"%02d",1]];
            [hourArray addObject:[NSString stringWithFormat:@"%02d",2]];
        }
    }
    //分
    minuteArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 60 ; i++) {
        if (i == 0) {
            [minuteArray addObject:[NSString stringWithFormat:@"%02d",57]];
            [minuteArray addObject:[NSString stringWithFormat:@"%02d",58]];
            [minuteArray addObject:[NSString stringWithFormat:@"%02d",59]];
        }
        [minuteArray addObject:[NSString stringWithFormat:@"%02d",i]];
        if (i == 59) {
            [minuteArray addObject:[NSString stringWithFormat:@"%02d",0]];
            [minuteArray addObject:[NSString stringWithFormat:@"%02d",1]];
            [minuteArray addObject:[NSString stringWithFormat:@"%02d",2]];
        }
    }
}

-(void)setType:(PickerType)type dateBlock:(void (^)(NSArray *))block
{
    _type = type;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    if (_type == YMD) {
        imageView.image = [UIImage imageNamed:@"pickerviewymdbg.png"];
        [self addSubview:imageView];

        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 0, WIDTH, HEIGHT/5)];
        
        NSString *weekDay = [self fromDateToWeek:[dateStr substringToIndex:10]];
        
        headerLabel.text = [NSString stringWithFormat:@"%@   %@",[dateStr substringToIndex:10],weekDay];
        headerLabel.font = [UIFont systemFontOfSize:13];
        headerLabel.textColor = [UIColor whiteColor];
        [self addSubview:headerLabel];
        [self createYMDTableView];
        [self createButton];
    } else if (_type == HM) {
        imageView.image = [UIImage imageNamed:@"pickerviewhmbg.png"];
        [self addSubview:imageView];
        
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 0, WIDTH, HEIGHT/5)];
        headerLabel.text = [[dateFormater stringFromDate:date] substringFromIndex:10];
        headerLabel.font = [UIFont systemFontOfSize:13];
        headerLabel.textColor = [UIColor whiteColor];
        [self addSubview:headerLabel];
        [self createHMTableView];
        [self createButton];
    }
    dateBlock = [block copy];
}

-(void)createButton
{
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, HEIGHT*0.8, WIDTH/2, HEIGHT/5)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelButton];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH/2, HEIGHT*0.8, WIDTH/2, HEIGHT/5)];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backButton];
}

-(void)buttonClick:(UIButton *)button
{
    dateArray = [NSMutableArray arrayWithCapacity:0];
    if ([button.titleLabel.text isEqualToString:@"消失"]) {
        [self removeFromSuperview];
    } else {
        if (_type == YMD) {
            for (int i = 0; i < YMDSCROLLVIEW_COUNT; i++) {
                UITableView *tableView = (UITableView *)[self viewWithTag:i + 1];
                UITableViewCell *cell = tableView.visibleCells[1];
                [dateArray addObject:cell.textLabel.text];
            }
        } else if (_type == HM) {
            for (int i = 0; i < HMSCROLLVIEW_COUNT; i++) {
                UITableView *tableView = (UITableView *)[self viewWithTag:i + 1];
                UITableViewCell *cell = tableView.visibleCells[1];
                [dateArray addObject:cell.textLabel.text];
            }
        }
        dateBlock(dateArray);
        [self removeFromSuperview];
    }
}

-(void)createYMDTableView
{
    for (int i = 0; i < YMDSCROLLVIEW_COUNT; i++) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH/12 + (WIDTH*1.15 - WIDTH*i*0.1)/3*i, HEIGHT/5 - HEIGHT*0.01, WIDTH*0.8/3, HEIGHT*0.6)];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tag = 1 + i;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.showsVerticalScrollIndicator = NO;
        tableView.separatorStyle = UITableViewCellStyleDefault;
        switch (i) {
            case 0:
                tableView.contentOffset = CGPointMake(0, ([yearStr integerValue] - YEARMIN - 1 + 3)*HEIGHT/5);
                break;
            case 1:
                tableView.contentOffset = CGPointMake(0, ([monthStr integerValue] - 2 + 3)*HEIGHT/5);
                break;
            case 2:
                tableView.contentOffset = CGPointMake(0, ([dayStr integerValue] - 2 + 3)*HEIGHT/5);
                break;
                
            default:
                break;
        }
        [self addSubview:tableView];
    }
}

-(void)createHMTableView
{
    for (int i = 0; i < HMSCROLLVIEW_COUNT; i++) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH/4.35 + WIDTH/3.5 * i, HEIGHT/5 - HEIGHT*0.01, WIDTH/4, HEIGHT*0.6)];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tag = 1 + i;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.showsVerticalScrollIndicator = NO;
        tableView.separatorStyle = UITableViewCellStyleDefault;
        switch (i) {
            case 0:
                tableView.contentOffset = CGPointMake(0, ([hourStr integerValue] - 1 + 3)*HEIGHT/5);
                break;
            case 1:
                tableView.contentOffset = CGPointMake(0, ([minuteStr integerValue] - 1 + 3)*HEIGHT/5);
                break;
                
            default:
                break;
        }
        [self addSubview:tableView];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_type == YMD) {
        switch (tableView.tag) {
            case 1:
                return yearArray.count;
                break;
            case 2:
                return monthArray.count;
                break;
            case 3:
                return dayArray.count;
                break;
                
            default:
                break;
        }
    } else if (_type == HM) {
        switch (tableView.tag) {
            case 1:
                return hourArray.count;
                break;
            case 2:
                return minuteArray.count;
                break;
                
            default:
                break;
        }
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEIGHT_INT;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_type == YMD) {
        if (1 == tableView.tag) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YearCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YearCell"];
            }
            cell.textLabel.text = yearArray[indexPath.row];
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.textLabel.textAlignment = 1;
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else if (2 == tableView.tag) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MonthCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MonthCell"];
            }
            cell.textLabel.text = monthArray[indexPath.row];
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.textLabel.textAlignment = 1;
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else if (3 == tableView.tag) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DayCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DayCell"];
            }
            cell.textLabel.text = dayArray[indexPath.row];
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.textLabel.textAlignment = 1;
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    if (1 == tableView.tag) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HourCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HourCell"];
        }
        cell.textLabel.text = hourArray[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.textAlignment = 1;
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MinuteCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MinuteCell"];
    }
    cell.textLabel.text = minuteArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.textAlignment = 1;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//结束减速
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    UITableView *tableView = (UITableView *)scrollView;
    int content = (int)tableView.contentOffset.y%HEIGHT_INT;
    int count = tableView.contentOffset.y/(int)HEIGHT*5;
    if (content) {
        if (content < HEIGHT/5/2) {
            tableView.contentOffset = CGPointMake(0, count*HEIGHT_INT);
        } else {
            tableView.contentOffset = CGPointMake(0, (count + 1)*HEIGHT_INT);
        }
    } else {
        tableView.contentOffset = CGPointMake(0, count*HEIGHT_INT);
    }
    NSLog(@"kjnknkn%f",tableView.contentOffset.y/(int)HEIGHT*5);
    UITableViewCell *cell = tableView.visibleCells[1];
    if (_type == YMD) {
        if (tableView.tag == 1) {
            [lock lock];
            [dateDictionary setObject:cell.textLabel.text forKey:@"year"];
            [NSThread detachNewThreadSelector:@selector(thread) toTarget:self withObject:nil];
            [lock unlock];
        } else if (tableView.tag == 2) {
            [lock lock];
            [dateDictionary setObject:cell.textLabel.text forKey:@"month"];
            [NSThread detachNewThreadSelector:@selector(thread) toTarget:self withObject:nil];
            [lock unlock];
        }
    }
}

//结束拖拽
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (decelerate) {
        return;
    }
    UITableView *tableView = (UITableView *)scrollView;
    float content = (int)tableView.contentOffset.y%HEIGHT_INT;
    int count = tableView.contentOffset.y/(int)HEIGHT*5;
    if (content) {
        if (content < HEIGHT/5/2) {
            tableView.contentOffset = CGPointMake(0, count*HEIGHT_INT);
        } else {
            tableView.contentOffset = CGPointMake(0, (count + 1)*HEIGHT_INT);
        }
    } else {
        tableView.contentOffset = CGPointMake(0, count*HEIGHT_INT);
    }
    
    UITableViewCell *cell = tableView.visibleCells[1];
    if (_type == YMD) {
        if (tableView.tag == 1) {
            [lock lock];
            [dateDictionary setObject:cell.textLabel.text forKey:@"year"];
            [NSThread detachNewThreadSelector:@selector(thread) toTarget:self withObject:nil];
            [lock unlock];
        } else if (tableView.tag == 2) {
            [lock lock];
            [dateDictionary setObject:cell.textLabel.text forKey:@"month"];
            [NSThread detachNewThreadSelector:@selector(thread) toTarget:self withObject:nil];
            [lock unlock];
        }
    }
}

//只要滑动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if (!scrollView.decelerating) {
//        return;
//    }
    NSInteger count;
    UITableView *tableView = (UITableView *)scrollView;
    if (_type == YMD) {
        switch (tableView.tag) {
            case 1:
                count = yearArray.count;
                break;
            case 2:
                count = monthArray.count;
                break;
            case 3:
                count = dayArray.count;
                break;
                
            default:
                break;
        }
    } else if (_type == HM) {
        switch (tableView.tag) {
            case 1:
                count = hourArray.count;
                break;
            case 2:
                count = minuteArray.count;
                break;
                
            default:
                break;
        }
    }
    if (tableView.contentOffset.y >= (count - 3)*HEIGHT_INT) {
        tableView.contentOffset = CGPointMake(0, 3*HEIGHT_INT);
    }
    if (tableView.contentOffset.y <= 0) {
        tableView.contentOffset= CGPointMake(0, (count - 6)*HEIGHT_INT);
    }
}

-(void)thread
{
    int row = [dateDictionary[@"day"] intValue];
//    [lock lock];
    JudgeDate *judgeDate = [[JudgeDate alloc] init];
    [judgeDate setYear:dateDictionary[@"year"] andMonth:dateDictionary[@"month"] dayCountBlick:^(int dayCount) {
        [dayArray removeAllObjects];
        for (int i = 0; i < dayCount; i++) {
            if (i == 0) {
                [dayArray addObject:[NSString stringWithFormat:@"%02d",dayCount - 2]];
                [dayArray addObject:[NSString stringWithFormat:@"%02d",dayCount - 1]];
                [dayArray addObject:[NSString stringWithFormat:@"%02d",dayCount]];
            }
            [dayArray addObject:[NSString stringWithFormat:@"%02d",i + 1]];
            if (i == dayCount - 1) {
                [dayArray addObject:[NSString stringWithFormat:@"%02d",1]];
                [dayArray addObject:[NSString stringWithFormat:@"%02d",2]];
                [dayArray addObject:[NSString stringWithFormat:@"%02d",3]];
            }
        }
        [dateDictionary setObject:[NSString stringWithFormat:@"%d",dayCount] forKey:@"day"];
//        dispatch_async(dispatch_get_main_queue(), ^{
        UITableView *dayTableView = (UITableView *)[self viewWithTag:2];
        
/*************************判断条件不足***********************************************/
        
        if (row > dayCount) {
            if (dayTableView.contentOffset.y >= (row - 3)*HEIGHT_INT) {
                dayTableView.contentOffset = CGPointMake(0, (dayCount - 3)*HEIGHT_INT);
            }
        }
        [dayTableView reloadData];
//        });
    }];
//    [lock unlock];
}

//通过日期求星期
- (NSString*)fromDateToWeek:(NSString*)selectDate
{
    NSInteger yearInt = [selectDate substringWithRange:NSMakeRange(0, 4)].integerValue;
    NSInteger monthInt = [selectDate substringWithRange:NSMakeRange(4, 2)].integerValue;
    NSInteger dayInt = [selectDate substringWithRange:NSMakeRange(6, 2)].integerValue;
    int c = 20;//世纪
    int y = yearInt -1;//年
    int d = dayInt;
    int m = monthInt;
    int w =(y+(y/4)+(c/4)-2*c+(26*(m+1)/10)+d-1)%7;
    NSString *weekDay = @"";
    switch (w) {
        case 0:
            weekDay = @"周日";
            break;
        case 1:
            weekDay = @"周一";
            break;
        case 2:
            weekDay = @"周二";
            break;
        case 3:
            weekDay = @"周三";
            break;
        case 4:
            weekDay = @"周四";
            break;
        case 5:
            weekDay = @"周五";
            break;
        case 6:
            weekDay = @"周六";
            break;
        default:
            break;
    }
    return weekDay;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
