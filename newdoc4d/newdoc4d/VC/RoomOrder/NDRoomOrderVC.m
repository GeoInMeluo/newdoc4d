
//
//  NDRoomOrderVC.m
//  newdoc
//
//  Created by zzc on 15/10/17.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDRoomOrderVC.h"
#import "NDRoomDocDetail.h"
#import "NDRoomUserComment.h"
#import "NDSlot.h"
#import "NDPreserveWindow.h"
#import "NDRoomOrderCell1.h"
#import "NDRoomDetailVC.h"

@interface NDRoomOrderVC ()<UICollectionViewDataSource, UIBarPositioningDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblCountMoment;


#pragma 头部控件
@property (weak, nonatomic) IBOutlet UILabel *lblDocName;
@property (weak, nonatomic) IBOutlet UILabel *lblDocTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnAttention;
@property (weak, nonatomic) IBOutlet UILabel *lblSubroom;
@property (weak, nonatomic) IBOutlet UILabel *lblGoodat;
@property (weak, nonatomic) IBOutlet UIButton *btnDocIntro;
@property (weak, nonatomic) IBOutlet UILabel *btnUserComment;
@property (weak, nonatomic) IBOutlet UIButton *btnDocHeadImg;

@property (weak, nonatomic) IBOutlet UIView *vUserComment;

@property (nonatomic, strong) NSMutableArray *canOrderBtns;

@property (nonatomic, strong) NSMutableArray *docRooms;
@end

@implementation NDRoomOrderVC

- (NSMutableArray *)docRooms{
    if(_docRooms == nil){
        _docRooms = [NSMutableArray array];
    }
    return _docRooms;
}

- (NSMutableArray *)canOrderBtns{
    if(_canOrderBtns == nil){
        _canOrderBtns = [NSMutableArray array];
    }
    return _canOrderBtns;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.canOrderBtns = [NSMutableArray array];
    
    [self setupUI];
//    self.docMorePreserveWindow.ID = self.doc.ID;
    
}

- (void)setupUI{
    WEAK_SELF;
    
    self.title = @"医生主页";
    
    self.btnDocIntro.layer.masksToBounds = YES;
    self.btnDocIntro.layer.cornerRadius = 5;
    
    self.btnUserComment.layer.masksToBounds = YES;
    self.btnUserComment.layer.cornerRadius = 5;
    
    self.vUserComment.layer.masksToBounds = YES;
    self.vUserComment.layer.cornerRadius = 5;
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"back"]
            forState:UIControlStateHighlighted];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitle:@"返回" forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.title = @"医生主页";
    
    
    self.lblDocName.text = self.doc.name;
    self.lblDocTitle.text = [NSString stringWithFormat:@"（%@）",self.doc.title];
    self.lblGoodat.text = [NSString stringWithFormat:@"擅长：%@", self.doc.goodat];
    NDSubroom *subroom = self.doc.catalog[0];
    self.lblSubroom.text = [NSString stringWithFormat:@"科室：%@",subroom.name];
    [self.btnDocHeadImg sd_setImageWithURL:[NSURL URLWithString:self.doc.picture_url] forState:UIControlStateNormal placeholderImage:[UIImage imageWithName:@"icon_placeHolder"]];
    
    [self startGetSignRoomWithRoomId:self.doc.ID success:^(NSArray *rooms) {
        weakself.docRooms = rooms;
        [weakself.tableView reloadData];
    } failure:^(NSString *error_message) {
        
    }];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)changeBtnStyle:(UIButton *)btn{
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateSelected];
    [btn setBackgroundImage:[UIImage imageWithColor:Blue] forState:UIControlStateSelected];
    [btn setTitleColor:Blue forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont systemFontOfSize:10];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds= YES;
    btn.layer.borderColor = Blue.CGColor;
    btn.layer.borderWidth = 1;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    self.selectedOrderDates = [NSMutableArray array];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    self.tableView.tableHeaderView.height = 144;
    
    WEAK_SELF;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WEAK_SELF;
    
    NDSampleRoom *room = self.docRooms[indexPath.row];

    static NSString *cellId = @"NDRoomOrderCell1";
    
    NDRoomOrderCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        cell = [NDRoomOrderCell1 new];
    }
    
    cell.lblRoomName.text = room.name;
    cell.lblRoomLoc.text = room.address;
    
    cell.btnGo2Room.callback = ^(Button *btn){
        CreateVC(NDRoomDetailVC);
        vc.roomId = room.ID;
        PushVCWeak(vc);
    };
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.docRooms.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 77;
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

@end
