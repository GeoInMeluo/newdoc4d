//
//  NDRoomOrderVC.m
//  newdoc
//
//  Created by zzc on 15/10/17.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDRoomOrderVC.h"
#import "NDRoomOrderLabeCell.h"
#import "NDRoomDocDetail.h"
#import "NDRoomUserComment.h"
#import "NDSlot.h"
#import "NDPreserveWindow.h"

@interface NDRoomOrderVC ()<UICollectionViewDataSource, UIBarPositioningDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *roomCollectionView;
@property (weak, nonatomic) IBOutlet UIView *dateView;

@property (weak, nonatomic) IBOutlet UIButton *btnTimeArea1;

@property (weak, nonatomic) IBOutlet UIButton *btnTimeArea3;
@property (weak, nonatomic) IBOutlet UILabel *lblCountMoment;
@property (nonatomic, assign) NSInteger currentDate;
@property (nonatomic, strong) NDPreserveWindow *currentPreserveWindow;
@property (nonatomic, assign) NSInteger currentWindowIndex;
@property (nonatomic, strong) NSMutableArray *selectedOrderDates;
@property (weak, nonatomic) IBOutlet UIButton *btnOrder;

#pragma 头部控件
@property (weak, nonatomic) IBOutlet UILabel *lblDocName;
@property (weak, nonatomic) IBOutlet UILabel *lblDocTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnAttention;
@property (weak, nonatomic) IBOutlet UILabel *lblSubroom;
@property (weak, nonatomic) IBOutlet UILabel *lblGoodat;
@property (weak, nonatomic) IBOutlet UIButton *btnDocIntro;
@property (weak, nonatomic) IBOutlet UILabel *btnUserComment;

@end

@implementation NDRoomOrderVC

- (NSMutableArray *)selectedOrderDates{
    if(_selectedOrderDates == nil){
        _selectedOrderDates = [NSMutableArray array];
    }
    return _selectedOrderDates;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.docMorePreserveWindow.ID = self.doc.ID;
    
}


- (void)setupUI{
    self.title = @"预约挂号";
    
    self.btnOrder.layer.masksToBounds = YES;
    self.btnOrder.layer.cornerRadius = 5;
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"back"]
            forState:UIControlStateHighlighted];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitle:@"返回" forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.currentPreserveWindow = self.docMorePreserveWindow.preserve_window[0];
    
    self.title = @"预约挂号";
    
    self.lblDocName.text = self.docMorePreserveWindow.name;
    self.lblDocTitle.text = self.docMorePreserveWindow.title;
    self.lblGoodat.text = [NSString stringWithFormat:@"擅长：%@", self.docMorePreserveWindow.goodat];
    NDSubroom *subroom = self.docMorePreserveWindow.catalog[0];
    self.lblSubroom.text = [NSString stringWithFormat:@"科室：%@",subroom.name];
//    self.lblCountMoment.text = [NSString stringWithFormat:@"%@",self.doc];
    
    [self.roomCollectionView registerNib:[UINib nibWithNibName:@"NDRoomOrderLabeCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"NDRoomOrderLabeCell"];
    
    self.roomCollectionView.pagingEnabled = YES;
    
    [self changeBtnStyle:self.btnTimeArea1];
    [self changeBtnStyle:self.btnTimeArea3];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)changeBtnStyle:(UIButton *)btn{
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds= YES;
    btn.layer.borderColor = Blue.CGColor;
    btn.layer.borderWidth = 1;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    WEAK_SELF;
    
    [self startGetDoctorDetailWithDocId:self.doc.ID andRoomId:self.roomId success:^(NDDoctorMorePreserveWindow *doctorMorePreserveWindow) {
        weakself.docMorePreserveWindow = doctorMorePreserveWindow;
        [weakself setupUI];
        [weakself.roomCollectionView reloadData];
        
        [weakself initWithDatePicker];
    } failure:^(NSDictionary *result, NSError *error) {
        
    }];
    
    
}

- (void)initWithDatePicker{
    [self.dateView clearSubviews];
    
    //得到今天是周几
    NSUInteger weekNumber = [[NSDate date] weeklyOrdinality];
//    NSUInteger weekNumber = 3;
    //得到今天是几号
    NSUInteger dateNumber = [[NSDate date] day];
    self.currentDate = dateNumber;
//    NSUInteger dateNumber = 21;
    //当前月份的总天数
    NSUInteger countMonthDay = [[NSDate date] numberOfDaysInCurrentMonth];
    
    NSUInteger temp = 6 + weekNumber;
    
    NSArray *tempArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    
    int row = 4;
    int rowCount = 7;
    CGFloat itemW = 34;
    CGFloat itemH = 34;
    int marginW = (self.dateView.width - (itemW * rowCount)) / (rowCount + 1);
    int marginH = (self.dateView.height - (itemW * row)) / (row + 1);
    
    int tempNumber = 0;
    
    NSInteger tagNumber = 100;
    
    @autoreleasepool {
    
    for (int i = 0; i < row * rowCount; i++) {
        
        int itemRow = i / rowCount;
        int itemCol = i % rowCount;
        
        UIButton *btn = [[UIButton alloc] init];
        btn.enabled = NO;
        [self.dateView addSubview:btn];
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
                
            //今天以后的有效日期
            if(i >= temp && btnTitleNumber <= dateNumber + 13){
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

            for(NDSlot *slot in self.currentPreserveWindow.slots){
                
                NSDate *orderDate = timestamp2Datetime([slot.ts integerValue ] * 1000);
                
//                [self.canOrderDates addObject:slot];
                
                NSInteger diffNumber = [NSDate dayDiffCountFrom:[NSDate date] to:orderDate];
                
                if(btnTitleNumber == (diffNumber + dateNumber) && btnTitleNumber <= dateNumber + 13){
                    [btn addTarget:self action:@selector(btnDateGridClicked:) forControlEvents:UIControlEventTouchUpInside];
                    btn.enabled = YES;
                    btn.layer.borderWidth = 0;
//                    btn.backgroundColor = [UIColor redColor];
                    [btn setBackgroundImage:[UIImage imageNamed:@"btn_date_normal"] forState:UIControlStateNormal];
                    [btn setBackgroundImage:[UIImage imageNamed:@"btn_date_selected"] forState:UIControlStateSelected];
                    btn.tag = tagNumber;
                    tagNumber ++;
                }
            }
        }

    }
        
    }
}

#pragma 日期按钮点击事件
- (void)btnDateGridClicked:(UIButton *)btn{
    FLog(@"%@",btn);
    
    btn.selected = !btn.selected;
    
    NDSlot *selectSlot = self.currentPreserveWindow.slots[btn.tag - 100];
    
    FLog(@"%@",selectSlot.ID);
    
    if(btn.selected){
//        btn.layer.borderColor = [UIColor whiteColor].CGColor;
        [self.selectedOrderDates addObject:selectSlot];
        
        
    }else{
        
        
        [self.selectedOrderDates removeObject:selectSlot];
//        if(btn.tag == self.currentDate){
//            btn.layer.borderColor = [UIColor orangeColor].CGColor;
//        }else{
//            btn.layer.borderColor = [UIColor darkGrayColor].CGColor;
//        }
    }
    
    FLog(@"%@",self.selectedOrderDates);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.docMorePreserveWindow.preserve_window.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NDRoomOrderLabeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NDRoomOrderLabeCell" forIndexPath:indexPath];
    
    NDPreserveWindow *preserveWindow = self.docMorePreserveWindow.preserve_window[indexPath.row];
    
    cell.preserveWindow = preserveWindow;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.roomCollectionView.size;
}

- (IBAction)btnPreviousClick:(id)sender {
    
    self.currentWindowIndex--;
    
    if(self.currentWindowIndex < 0){
        self.currentWindowIndex = 0;
        return;
    }
    
    [self.roomCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentWindowIndex inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    
    self.currentPreserveWindow = self.docMorePreserveWindow.preserve_window[self.currentWindowIndex];
    
    [self initWithDatePicker];
}

- (IBAction)btnNextClick:(id)sender {
    
    self.currentWindowIndex++;
    
    if(self.currentWindowIndex == self.docMorePreserveWindow.preserve_window.count){
        self.currentWindowIndex = self.docMorePreserveWindow.preserve_window.count - 1;
        return;
    }
    
    [self.roomCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentWindowIndex inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];

    self.currentPreserveWindow = self.docMorePreserveWindow.preserve_window[self.currentWindowIndex];
    
    [self initWithDatePicker];
}

- (IBAction)btnTimeArea1Click:(id)sender {
}

- (IBAction)btnTimeArea3Click:(id)sender {
}

- (IBAction)btnDocDetailClick:(id)sender {
    CreateVC(NDRoomDocDetail);
    vc.doctor = self.doc;
    PushVC(vc);
}

- (IBAction)btnUserCommentClick:(id)sender {
    CreateVC(NDRoomUserComment);
    vc.doc = self.doc;
    PushVC(vc);
}

- (IBAction)btnAttentionClick:(id)sender {
    WEAK_SELF;
    
    if(self.docMorePreserveWindow.isFocus){
        [self startCancelAttentionDoctorWithDocId:self.docMorePreserveWindow.ID success:^{
            weakself.docMorePreserveWindow.isFocus = NO;
            weakself.btnAttention.selected = NO;
        } failure:^(NSDictionary *result, NSError *error) {
            
        }];
    }else{
        [self startAttentionDoctorWithDocId:self.docMorePreserveWindow.ID success:^{
            weakself.docMorePreserveWindow.isFocus = YES;
            weakself.btnAttention.selected = YES;
        } failure:^(NSDictionary *result, NSError *error) {
            
        }];
    }
}

- (IBAction)btnOrderClicked:(id)sender {
    
    if(self.selectedOrderDates.count == 0){
        return;
    }
    
    [self startOrderWithSlot:self.selectedOrderDates[0] success:^{
        
    } failure:^(NSDictionary *result, NSError *error) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
