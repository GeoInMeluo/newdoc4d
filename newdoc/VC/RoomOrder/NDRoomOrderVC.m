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

@interface NDRoomOrderVC ()<UICollectionViewDataSource, UIBarPositioningDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *roomCollectionView;
@property (weak, nonatomic) IBOutlet UIView *dateView;

@property (weak, nonatomic) IBOutlet UIButton *btnTimeArea1;
@property (weak, nonatomic) IBOutlet UIButton *btnTimeArea2;
@property (weak, nonatomic) IBOutlet UIButton *btnTimeArea3;
@property (weak, nonatomic) IBOutlet UILabel *lblCountMoment;
@property (nonatomic, assign) NSInteger currentDate;
@property (nonatomic, strong) NDPreserveWindow *currentPreserveWindow;
@property (nonatomic, assign) NSInteger currentWindowIndex;

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI{
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"back"]
            forState:UIControlStateHighlighted];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitle:@"返回" forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.currentPreserveWindow = self.doc.preserve_window[0];
    
    self.title = @"预约挂号";
    
    self.lblDocName.text = self.doc.name;
    self.lblDocTitle.text = self.doc.title;
    self.lblGoodat.text = [NSString stringWithFormat:@"擅长：%@", self.doc.goodat];
    NDSubroom *subroom = self.doc.catalog[0];
    self.lblSubroom.text = [NSString stringWithFormat:@"科室：%@",subroom.name];
//    self.lblCountMoment.text = [NSString stringWithFormat:@"%@",self.doc];
    
    [self.roomCollectionView registerNib:[UINib nibWithNibName:@"NDRoomOrderLabeCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"NDRoomOrderLabeCell"];
    
    self.roomCollectionView.pagingEnabled = YES;
    
    [self changeBtnStyle:self.btnTimeArea1];
    [self changeBtnStyle:self.btnTimeArea2];
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
    
    [self initWithDatePicker];
}

- (void)initWithDatePicker{
//    NSMutableArray *canOrderSlots = [NSMutableArray array];
//    
//    for(NDSlot *slot in self.currentPreserveWindow.slots){
//        if(slot.status){
//            can
//        }
//    }
    
    
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
    
    for (int i = 0; i < row * rowCount; i++) {
        
        int itemRow = i / rowCount;
        int itemCol = i % rowCount;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.enabled = NO;
        [self.dateView addSubview:btn];
        btn.frame = CGRectMake(                                                                                                      itemCol * (marginW + itemW) + marginW, itemRow * (marginH + itemH) + marginH , itemW, itemH);
        btn.tag = i;
        
        if(i < 7){
            [btn setTitle:tempArray[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        }else{
            
            btn.layer.cornerRadius = 5;
            btn.layer.masksToBounds = YES;
            btn.layer.borderWidth = 1;
            
            NSInteger btnTitleNumber = dateNumber - temp + i;
                
            //今天以后的有效日期
            if(i >= temp && btnTitleNumber <= countMonthDay){
                btn.enabled = YES;
                [btn addTarget:self action:@selector(btnDateGridClicked:) forControlEvents:UIControlEventTouchUpInside];
                //                btn.backgroundColor = [UIColor whiteColor];
                [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateSelected];
                [btn setBackgroundImage:[UIImage imageWithColor:[UIColor greenColor]] forState:UIControlStateSelected];
                
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
                
                NSDate *orderDate = timestamp2Datetime([slot.ts integerValue]);
                NSInteger diffNumber = [NSDate dayDiffCountFrom:[NSDate date] to:orderDate];
                
                if(btnTitleNumber == (diffNumber + dateNumber)){
                    btn.backgroundColor = [UIColor redColor];
                }
            }
        }

    }
}

#pragma 日期按钮点击事件
- (void)btnDateGridClicked:(UIButton *)btn{
    btn.selected = !btn.selected;
    
//    if(btn.state == UIControlStateSelected){
//        btn.layer.borderColor = [UIColor whiteColor].CGColor;
//    }else{
//        if(btn.tag == self.currentDate){
//            btn.layer.borderColor = [UIColor orangeColor].CGColor;
//        }else{
//            btn.layer.borderColor = [UIColor darkGrayColor].CGColor;
//        }
//    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.doc.preserve_window.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NDRoomOrderLabeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NDRoomOrderLabeCell" forIndexPath:indexPath];
    
    NDPreserveWindow *preserveWindow = self.doc.preserve_window[indexPath.row];
    
    cell.preserveWindow = preserveWindow;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.roomCollectionView.size;
}

- (IBAction)btnPreviousClick:(id)sender {
    
    if(self.currentWindowIndex == 0){
        return;
    }
    
    self.currentWindowIndex--;
    
    [self.roomCollectionView setContentOffset:CGPointMake(- self.roomCollectionView.width * self.currentWindowIndex , 0) animated:YES];
    
}

- (IBAction)btnNextClick:(id)sender {
    
    if(self.currentWindowIndex >= self.doc.preserve_window.count){
        return;
    }
    
    self.currentWindowIndex++;
    
    [self.roomCollectionView setContentOffset:CGPointMake(self.roomCollectionView.width * self.currentWindowIndex , 0) animated:YES];
}

- (IBAction)btnTimeArea1Click:(id)sender {
}

- (IBAction)btnTimeArea2Click:(id)sender {
}

- (IBAction)btnTimeArea3Click:(id)sender {
}

- (IBAction)btnDocDetailClick:(id)sender {
    ShowVC(NDRoomDocDetail);
}

- (IBAction)btnUserCommentClick:(id)sender {
    ShowVC(NDRoomUserComment);
}

- (IBAction)btnIntroClicked:(id)sender {
}

- (IBAction)btnCommentClicked:(id)sender {
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
