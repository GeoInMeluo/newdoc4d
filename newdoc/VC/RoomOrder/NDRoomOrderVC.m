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

@interface NDRoomOrderVC ()<UICollectionViewDataSource, UIBarPositioningDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *roomCollectionView;
@property (weak, nonatomic) IBOutlet UIView *dateView;

@property (weak, nonatomic) IBOutlet UIButton *btnTimeArea1;
@property (weak, nonatomic) IBOutlet UIButton *btnTimeArea2;
@property (weak, nonatomic) IBOutlet UIButton *btnTimeArea3;

@property (weak, nonatomic) IBOutlet UILabel *lblCountMoment;

@end

@implementation NDRoomOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI{
    self.title = @"预约挂号";
    
    [self.roomCollectionView registerNib:[UINib nibWithNibName:@"NDRoomOrderLabeCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"NDRoomOrderLabeCell"];
    
    self.roomCollectionView.pagingEnabled = YES;
    
    [self changeBtnStyle:self.btnTimeArea1];
    [self changeBtnStyle:self.btnTimeArea2];
    [self changeBtnStyle:self.btnTimeArea3];
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
    //得到今天是周几
    NSUInteger weekNumber = [[NSDate date] weeklyOrdinality];
//    NSUInteger weekNumber = 3;
    //得到今天是几号
    NSUInteger dateNumber = [[NSDate date] day];
//    NSUInteger dateNumber = 21;
    //当前月份的总天数
    NSUInteger countMonthDay = [[NSDate date] numberOfDaysInCurrentMonth];
    
    NSUInteger temp = 6 + weekNumber;
    
    NSArray *tempArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    
    int row = 3;
    int rowCount = 7;
    CGFloat itemW = 34;
    CGFloat itemH = 34;
    int marginW = (self.dateView.width - (itemW * rowCount)) / (rowCount + 1);
    int marginH = (self.dateView.height - (itemW * row)) / (row + 1);
    
    for (int i = 0; i < 21; i++) {
        int itemRow = i / rowCount;
        int itemCol = i % rowCount;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.enabled = NO;
        [self.dateView addSubview:btn];
        btn.frame = CGRectMake(                                                                                                      itemCol * (marginW + itemW) + marginW, itemRow * (marginH + itemH) + marginH , itemW, itemH);
        if(i < 7){
            [btn setTitle:tempArray[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        }else if(i >= temp && (dateNumber - temp + i) <= countMonthDay){
            btn.enabled = YES;
            btn.backgroundColor = [UIColor whiteColor];
            btn.layer.cornerRadius = 5;
            btn.layer.masksToBounds = YES;
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = [UIColor darkGrayColor].CGColor;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [btn setTitle:[NSString stringWithFormat:@"%zd", dateNumber - temp + i] forState:UIControlStateNormal];
            btn.tag = dateNumber - temp + i;
        }
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NDRoomOrderLabeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NDRoomOrderLabeCell" forIndexPath:indexPath];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.roomCollectionView.size;
}

- (IBAction)btnPreviousClick:(id)sender {
    
    [self.roomCollectionView setContentOffset:CGPointMake( self.roomCollectionView.contentOffset.x - self.roomCollectionView.width  , 0) animated:YES];
    
}

- (IBAction)btnNextClick:(id)sender {
    [self.roomCollectionView setContentOffset:CGPointMake( self.roomCollectionView.contentOffset.x + self.roomCollectionView.width , 0) animated:YES];
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
