//
//  NDPersonalCardVC.m
//  newdoc4d
//
//  Created by zzc on 15/11/28.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDPersonalCardVC.h"
#import "NDPersonalCardCell.h"

#import "UMComShareCollectionView.h"

#import "NDSampleRoom.h"

@interface NDPersonalCardVC ()
@property (weak, nonatomic) IBOutlet UIView *vContent;
@property (weak, nonatomic) IBOutlet UITableView *tableViewLocation;
@property (weak, nonatomic) IBOutlet UIView *vHeader;

@property (weak, nonatomic) IBOutlet UIImageView *ivHeadImg;
@property (weak, nonatomic) IBOutlet UILabel *lblTile;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblHospictal;
@property (weak, nonatomic) IBOutlet UILabel *lblSubroom;
@property (weak, nonatomic) IBOutlet UIImageView *ivQr;
@property (weak, nonatomic) IBOutlet UIButton *btnShare;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vContenHeightConstraint;
@property (nonatomic, strong) NDDocInfo *docInfo;

@property (weak, nonatomic) IBOutlet UITableView *roomTable;

@property (nonatomic, strong) UMComShareCollectionView *shareListView;
@property (nonatomic, copy) NSString *docId;
@end

@implementation NDPersonalCardVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

- (void)setupUI{
    WEAK_SELF;
    
    self.title = @"我的名片";
    
    self.btnShare.layer.cornerRadius = 10;
    self.btnShare.layer.masksToBounds = YES;
    [self.btnShare addTarget:self action:@selector(shareTheCard) forControlEvents:UIControlEventTouchUpInside];

    
    self.ivHeadImg.layer.cornerRadius = self.ivHeadImg.height / 2;
    self.ivHeadImg.layer.masksToBounds = YES;
    
    self.vHeader.layer.cornerRadius = 20;
    self.vHeader.layer.masksToBounds = YES;
    
    self.vContenHeightConstraint.constant = self.vContenHeightConstraint.constant + 15 * 10;
    
    self.defaultHeader.height = 1000;
    
    
    [self startGetUserInfoMoreAndSuccess:^(NDDocInfo *docInfo) {
        weakself.docInfo = docInfo;
        
        [weakself.ivHeadImg sd_setImageWithURL:[NSURL URLWithString:docInfo.picture_url] placeholderImage:[UIImage imageNamed:@"icon_placeHolder"]];
        
        weakself.lblTile.text = docInfo.title;
        weakself.lblName.text = [NDCoreSession coreSession].user.name;
        
        weakself.docId = docInfo.ID;
        [weakself.tableViewLocation reloadData];
    } failure:^(NSString *error_message) {
        
    }];
}

- (IBAction)shareTheCard{
    
    [self showShareWithText:@"医生名片" andImg:@"getqrcode" andUrl:[NSString stringWithFormat:@"http://mp.xinyijk.com/wechat/example/docinfo.html?docid=%@",self.docId]];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
//    [self.defaultHeader layoutSubviews];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == self.tableViewLocation){
        
        return self.docInfo.signed_rooms.count;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"NDPersonalCardCell";
    
    NDPersonalCardCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        cell = [NDPersonalCardCell new];
    }
    
    NDSampleRoom *room = self.docInfo.signed_rooms[indexPath.row];
    
    cell.lblRoomName.text = room.name;
    cell.lblLocation.text = room.address;
    
    return cell;
    
}

@end
