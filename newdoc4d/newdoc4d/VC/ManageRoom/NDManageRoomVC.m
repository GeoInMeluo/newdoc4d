//
//  NDManageRoomVC.m
//  newdoc4d
//
//  Created by zzc on 15/11/29.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDManageRoomVC.h"
#import "NDManageRoomCell.h"
#import "NDManageRoomPlainCell.h"
#import "NDManageRoomOrderPlainVC.h"

@interface NDManageRoomVC ()
@property (weak, nonatomic) IBOutlet Button *btnOrderHistory;
@property (weak, nonatomic) IBOutlet Button *btnOrderPlain;
@property (weak, nonatomic) IBOutlet UILabel *lblYearAndMonth;
@property (weak, nonatomic) IBOutlet UIView *vDate;

@property (nonatomic, assign) NSDate *selectedDate;

@property (nonatomic, strong) NSMutableArray *canOrderBtns;

@property (nonatomic, strong) NSMutableArray *canOrderDates;

@property (nonatomic, assign) BOOL isHistory;

@property (nonatomic, strong) NSArray *orders;

@property (nonatomic, strong) NSMutableArray *orderedDates;

@property (nonatomic, strong) NSMutableArray *finalOrders;

@property (nonatomic, assign) BOOL isPlan;

//picker相关
@property (strong, nonatomic) IBOutlet UIView *vPickClass;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerSubroom;

@property (nonatomic, strong) NSMutableArray *subrooms;

@property (nonatomic, copy) NSString *currentSubroomIndex;

@property (weak, nonatomic) IBOutlet UIButton *btnSubroom;
@property (weak, nonatomic) IBOutlet UIButton *lblSubroom;

@end

@implementation NDManageRoomVC

- (NSMutableArray *)subrooms{
    if(_subrooms == nil){
        _subrooms = [NSMutableArray array];
    }
    return _subrooms;
}

- (NSMutableArray *)finalOrders{
    if(_finalOrders == nil){
        _finalOrders = [NSMutableArray array];
    }
    return _finalOrders;
}

- (NSMutableArray *)canOrderDates{
    if(_canOrderDates == nil){
        _canOrderDates = [NSMutableArray array];
    }
    return _canOrderDates;
}

- (NSMutableArray *)orderedDates{
    if(_orderedDates == nil){
        _orderedDates = [NSMutableArray array];
    }
    return _orderedDates;
}

- (instancetype)init{
    if(self = [super init]){
        
    }
    
    return self;
}

- (NSMutableArray *)canOrderBtns{
    if(_canOrderBtns == nil){
        _canOrderBtns = [NSMutableArray array];
    }
    return _canOrderBtns;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WEAK_SELF;
    
    [self setupUI];

}

- (void)setupUI{
    WEAK_SELF;
    
    self.isHistory = YES;
    
    self.btnOrderHistory.selected = YES;
    
    self.btnOrderHistory.callback = ^(Button *btn){
        weakself.btnOrderPlain.selected = NO;
        weakself.btnOrderHistory.selected = YES;
        weakself.isHistory = YES;
        
        weakself.isPlan = NO;
        
        [weakself initWithDatePicker];
        
        [weakself.tableView reloadData];
    };
    
    self.btnOrderPlain.callback = ^(Button *btn){
        weakself.btnOrderPlain.selected = YES;
        weakself.btnOrderHistory.selected = NO;
        weakself.isHistory = NO;
        
        weakself.isPlan = YES;
        
        [weakself initWithDatePicker];
        
        [weakself.tableView reloadData];
    };
    
    self.title = @"门诊管理";
    self.tableView.tableHeaderView.height = 290;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    WEAK_SELF;
    
    [self startManageOrderAndSuccess:^(NSArray *orders) {
        
        weakself.orders = orders;
        
        for(NDManageRoomOrder *order in orders){
            if(![self.orderedDates containsObject:order.actual_date]){
                [self.orderedDates addObject:order.actual_date];
            }
        }
        
        [weakself.tableView reloadData];
        
        [weakself initWithDatePicker];
        
    } failure:^(NSString *error_message) {
        
    }];
    
    [self initWithDatePicker];
    
    self.vPickClass.left = self.view.left;
    self.vPickClass.top = self.view.top;
    self.vPickClass.width = self.view.width;
    self.vPickClass.bottom = self.view.bottom;
    self.vPickClass.hidden = YES;
    [self.view addSubview:self.vPickClass];
}

- (void)initWithDatePicker{
    [self.vDate clearSubviews];
    
    self.subrooms = [NSMutableArray array];
    self.finalOrders = [NSMutableArray array];
    
    [self.tableView reloadData];
    [self.pickerSubroom reloadComponent:0];
    
    NSDate *currentDate;
    
    if(self.isPlan){
        currentDate = [NSDate dateWithTimeInterval:3600*24*14 sinceDate:[NSDate date]];
    }else{
        currentDate = [NSDate date];
    }
    
    
    
    //得到今天是周几
    NSUInteger weekNumber = [currentDate weeklyOrdinality];
    //    NSUInteger weekNumber = 3;
    //得到今天是几号
    NSUInteger dateNumber = [currentDate day];
    
    //得到当前月份
    NSUInteger monthNumber = [currentDate month];
    
    //得到当前的年份
    NSUInteger yearNumber = [currentDate year];
    
    self.lblYearAndMonth.text = [NSString stringWithFormat:@"%zd年%zd月", yearNumber, monthNumber];
    
    int preMonthCountDay = [self howManyDaysInThisMonth:[currentDate year] month: monthNumber - 1];
    
//    self.selectedDate = dateNumber;
    //    NSUInteger dateNumber = 21;
    //当前月份的总天数
    NSUInteger countMonthDay = [currentDate numberOfDaysInCurrentMonth];
    
    NSUInteger temp = 6 + weekNumber;
    
    NSArray *tempArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    
    int row = 4;
    int rowCount = 7;
    CGFloat itemW = 34;
    CGFloat itemH = 34;
    int marginW = (self.vDate.width - (itemW * rowCount)) / (rowCount + 1);
    int marginH = (self.vDate.height - (itemW * row)) / (row + 1);
    
    int tempNumber = 0;
    
    NSInteger tagNumber = 100;
    
    @autoreleasepool {
        
        for (int i = 0; i < row * rowCount; i++) {
            
            int itemRow = i / rowCount;
            int itemCol = i % rowCount;
            
            UIButton *btn = [[UIButton alloc] init];
            btn.enabled = NO;
            [self.vDate addSubview:btn];
            btn.frame = CGRectMake(                                                                                                      itemCol * (marginW + itemW) + marginW, itemRow * (marginH + itemH) + marginH , itemW, itemH);
            //        btn.tag = i;
            
            if(i < 7){
                [btn setTitle:tempArray[i] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            }else{
                
                btn.layer.cornerRadius = 5;
                btn.layer.masksToBounds = YES;
                btn.layer.borderWidth = 1;
                
                NSInteger btnTitleNumber = dateNumber - temp + i;
                
                if(btnTitleNumber <= 0){
                    btnTitleNumber = preMonthCountDay - abs(btnTitleNumber);
                }
                
                if(btnTitleNumber > countMonthDay){
                    btnTitleNumber = btnTitleNumber - countMonthDay;
                }
                
                //今天以后的有效日期
                if(i >= temp && (btnTitleNumber <= dateNumber + 13) &&  (btnTitleNumber - dateNumber) < 14){
                    //                btn.enabled = YES;
                    btn.backgroundColor = [UIColor whiteColor];
                    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateSelected];
                    //                [btn setBackgroundImage:[UIImage imageWithColor:[UIColor greenColor]] forState:UIControlStateSelected];
                    
                    if(btnTitleNumber == dateNumber){
                        btn.layer.borderColor = [UIColor orangeColor].CGColor;
                        
                        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
                    }else{
                        btn.layer.borderColor = [UIColor darkGrayColor].CGColor;
                        
                        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    }
                    
                    [btn setTitle:[NSString stringWithFormat:@"%zd", btnTitleNumber] forState:UIControlStateNormal];
                    
                    if(!self.isPlan){
                        for(NSString *dateStr in self.orderedDates){
                            NSString *tempStr = [dateStr substringFromIndex:dateStr.length - 2];
                            
                            NSString *tempMonth = [dateStr substringWithRange:NSMakeRange(5, 2)];
                            
                            if([btn.titleLabel.text intValue] == [tempStr intValue] && [tempMonth intValue] == monthNumber){
                                [btn setBackgroundColor:Blue];
                                
                                [btn addTarget:self action:@selector(btnDateGridClicked:) forControlEvents:UIControlEventTouchUpInside];
                                btn.enabled = YES;
                                btn.layer.borderWidth = 0;
                                //                    btn.backgroundColor = [UIColor redColor];
                                [btn setBackgroundImage:[UIImage imageNamed:@"btn_date_selected"] forState:UIControlStateNormal];
                                [btn setBackgroundImage:[UIImage imageNamed:@"btn_date_normal"] forState:UIControlStateSelected];
                                btn.tag = tagNumber;
                                tagNumber ++;
                                
                                [self.canOrderBtns addObject:btn];
                                
                                [self.canOrderDates addObject:dateStr];
                            }
                        }
                    }
                    
                    
                    
                }else{
                    
                    btn.backgroundColor = [UIColor lightGrayColor];
                    
                    btn.layer.borderColor = [UIColor darkGrayColor].CGColor;
                    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    
                    if(btnTitleNumber > countMonthDay){
                        [btn setTitle:[NSString stringWithFormat:@"%zd", ++tempNumber] forState:UIControlStateNormal];
                    }else{
                        [btn setTitle:[NSString stringWithFormat:@"%zd", btnTitleNumber] forState:UIControlStateNormal];
                    }
                    
                }
                
                
                
                
//                for(NDSlot *slot in self.currentPreserveWindow.slots){
//                    
//                    NSDate *orderDate = timestamp2Datetime([slot.ts integerValue ] * 1000);
//                    
//                    //                [self.canOrderDates addObject:slot];
//                    
//                    NSInteger diffNumber = [NSDate dayDiffCountFrom:[NSDate date] to:orderDate];
//                    
//                    if(btnTitleNumber == (diffNumber + dateNumber) && btnTitleNumber <= dateNumber + 13 ){
//                        [self.canOrderBtns addObject:btn];
//                        
//                        [btn addTarget:self action:@selector(btnDateGridClicked:) forControlEvents:UIControlEventTouchUpInside];
//                        btn.enabled = YES;
//                        btn.layer.borderWidth = 0;
//                        //                    btn.backgroundColor = [UIColor redColor];
//                        [btn setBackgroundImage:[UIImage imageNamed:@"btn_date_normal"] forState:UIControlStateNormal];
//                        [btn setBackgroundImage:[UIImage imageNamed:@"btn_date_selected"] forState:UIControlStateSelected];
//                        btn.tag = tagNumber;
//                        tagNumber ++;
//                    }
//                }
            }
            
        }
        
    }
}

#pragma 日期按钮点击事件
- (void)btnDateGridClicked:(UIButton *)btn{
    FLog(@"%@",btn);
    
    self.finalOrders = [NSMutableArray array];
    
    for (UIButton *sub in self.canOrderBtns) {
        if(sub != btn){
            sub.selected = NO;
        }
    }
    
    btn.selected = !btn.selected;
    
    
    
    for(NDManageRoomOrder *order in self.orders){
        if([order.actual_date isEqualToString:self.canOrderDates[btn.tag - 100]]){
            [self.finalOrders addObject:order];
        }
    }
    
    for(NDManageRoomOrder *order in self.finalOrders){
        if(![self.subrooms containsObject:order.name]){
            [self.subrooms addObject:order.name];
        }
    }
    
    if(!btn.selected){
        self.finalOrders = [NSMutableArray array];
    }
    
    [self.tableView reloadData];
    
    [self.pickerSubroom reloadComponent:0];
    
//    ShowVC(NDManageRoomOrderPlainVC);
}


#pragma TableViewDealegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(self.isHistory){
        static NSString *cellId = @"NDManageRoomCell";
        
        NDManageRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        NDManageRoomOrder *order = self.finalOrders[indexPath.row];
        
        if(cell == nil){
            cell = [NDManageRoomCell new];
        }
        
        cell.lblTime.text = [NSString stringWithFormat:@"出诊时间:%@ %@",order.actual_date, order.timescope];
        cell.lblRoomName.text = [NSString stringWithFormat:@"出诊诊室:%@",order.name];
        cell.lblRoomLoc.text = [NSString stringWithFormat:@"出诊时间:%@",order.address];
        cell.lblCount.text = [NSString stringWithFormat:@"预约人数:%@人",order.reserved];
        
        return cell;
    }else{
        static NSString *cellId = @"NDManageRoomPlainCell";
        
        NDManageRoomPlainCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell == nil){
            cell = [NDManageRoomPlainCell new];
        }
        
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.isHistory){
        return self.finalOrders.count;
    }else{
        
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(self.isHistory){
        return 95;
    }else{
    
        return 72;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    todo();
}


- (IBAction)btnSubroomClicked:(id)sender {
    self.vPickClass.hidden = NO;
}

- (IBAction)btnConfirmPickSubroom:(id)sender {
    self.vPickClass.hidden = YES;
    self.currentSubroomIndex = [NSString stringWithFormat:@"%zd",[self.pickerSubroom selectedRowInComponent:0]];
    
    if(self.subrooms.count == 0){
        return;
    }
    
    [self.lblSubroom setTitle:self.subrooms[[self.pickerSubroom selectedRowInComponent:0]] forState:UIControlStateNormal];
}

#pragma pickerViewDatasource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.subrooms.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.subrooms[row];
}

- (int)howManyDaysInThisMonth:(NSUInteger)year month:(NSUInteger)imonth {
    if((imonth == 1)||(imonth == 3)||(imonth == 5)||(imonth == 7)||(imonth == 8)||(imonth == 10)||(imonth == 12))
        return 31;
    if((imonth == 4)||(imonth == 6)||(imonth == 9)||(imonth == 11))
        return 30;
    if((year%4 == 1)||(year%4 == 2)||(year%4 == 3))
    {
        return 28;
    }
    if(year%400 == 0)
        return 29;
    if(year%100 == 0)
        return 28;
    return 29;
}

@end
