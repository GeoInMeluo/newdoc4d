//
//  NDRoomUserComment.m
//  newdoc
//
//  Created by zzc on 15/10/18.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDRoomUserComment.h"
#import "NDRoomUserCommentCell.h"
#import "CWStarRateView.h"
#import "NDRoomUserCommentCell2.h"
#import "NDReplyUserCommentVC.h"

@interface NDRoomUserComment ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnUserCommet;
@property (weak, nonatomic) IBOutlet UIButton *btnMineComment;

@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UIView *startRateDiv;

@property (nonatomic, weak) CWStarRateView *starRateView;

@property (weak, nonatomic) IBOutlet UILabel *lblHeaderDocName;
@property (weak, nonatomic) IBOutlet UILabel *lblHeaderDocTitle;
@property (weak, nonatomic) IBOutlet UIButton *lblHeaderDocIcon;
@property (weak, nonatomic) IBOutlet UIButton *btnHeaderAttetion;
@property (weak, nonatomic) IBOutlet UILabel *lblHeaderSubroom;
@property (weak, nonatomic) IBOutlet UILabel *lblHeaderDocGoodat;
@property (weak, nonatomic) IBOutlet UITextView *tvComment;


@end

@implementation NDRoomUserComment

- (NSArray *)docComments{
    if(_docComments == nil){
        _docComments = [NSArray array];
    }
    return _docComments;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI{
    self.title = @"用户评价";
    
    [self.showKeyboardViews addObjectsFromArray:@[self.tvComment]];
    
    
    
    if(self.doc){
        self.lblHeaderDocGoodat.text = [NSString stringWithFormat:@"擅长：%@", self.doc.goodat];
        NDSubroom *subroom = self.doc.catalog[0];
        self.lblHeaderSubroom.text = [NSString stringWithFormat:@"科室：%@",subroom.name];
        self.btnHeaderAttetion.selected = self.doc.isFocus;
        self.lblHeaderDocName.text = self.doc.name;
        self.lblHeaderDocTitle.text = self.doc.title;
        [self.lblHeaderDocIcon sd_setImageWithURL:[NSURL URLWithString:self.doc.picture_url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_placeHolder"]];
    }else{
        self.lblHeaderSubroom.hidden = YES;
        self.lblHeaderDocGoodat.hidden = YES;
        self.lblHeaderDocTitle.hidden = YES;
        self.lblHeaderDocName.text = [NDCoreSession coreSession].user.name;
        [self.lblHeaderDocIcon sd_setImageWithURL:[NSURL URLWithString:[NDCoreSession coreSession].user.picture_url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_placeHolder"]];
    }
    

    [self.bottomView addSubview:self.tableView];
    self.tableView.hidden = YES;
    
    [self.bottomView addSubview:self.mineCommentView];
    self.mineCommentView.hidden = YES;
    
    CWStarRateView *starRateView = [[CWStarRateView alloc] initWithFrame:self.startRateDiv.bounds numberOfStars:5];
    self.starRateView.scorePercent = 0;
    self.starRateView.scorePercent = 4;
    self.starRateView.hasAnimation = YES;
    self.starRateView = starRateView;
    [self.startRateDiv addSubview:starRateView];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    WEAK_SELF;
    
    self.tableView.frame = self.bottomView.bounds;
    self.tableView.hidden = NO;
    
    self.mineCommentView.frame = self.bottomView.bounds;
    
    NSString *docId = self.doc.ID;
    
    if(!docId){
        if([[NDCoreSession coreSession].isWxLogin isEqualToString:@"1"]){
            docId = [NDCoreSession coreSession].openId;
        }else{
            docId = [NDCoreSession coreSession].nduid;
        }
    }
    
    if(self.doc){
        [self startGetDoctorCommentsWithDocId:docId success:^(NSArray *docComments) {
            
            weakself.docComments = docComments;
            
            [weakself.tableView reloadData];
        } failure:^(NSString *error_message) {
            
        }];
    }else{
        [self startGetMineCommentsSuccess:^(NSArray *docComments) {
            
            weakself.docComments = docComments;
            
            [weakself.tableView reloadData];
        } failure:^(NSString *error_message) {
            
        }];
    }
    
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.docComments.count;
//    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    NDDoctorComment *comment = self.docComments[indexPath.row];
    
    if(comment.doctor_response.length == 0 || comment.doctor_response == nil){
        static NSString *cellId = @"NDRoomUserCommentCell";
        
        NDRoomUserCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell == nil){
            cell = [NDRoomUserCommentCell new];
        }
        
        cell.docComment = comment;
        
        return cell;
    }
    
    static NSString *cellId = @"NDRoomUserCommentCell2";
    
    NDRoomUserCommentCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        cell = [NDRoomUserCommentCell2 new];
    }
    
    cell.docComment = comment;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NDDoctorComment *comment = self.docComments[indexPath.row];
    
    if(comment.doctor_response.length == 0 || comment.doctor_response == nil){
        return 80;
    }
    
    return 140;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!self.doc){
        NDDoctorComment *comment = self.docComments[indexPath.row];
        
        CreateVC(NDReplyUserCommentVC);
        vc.commentId =comment.ID;
        PushVC(vc);
    }
}

- (IBAction)btnMineCommentClick:(id)sender {
    self.mineCommentView.hidden = NO;
    self.tableView.hidden = YES;
}

- (IBAction)btnUserCommentClick:(id)sender {
    self.mineCommentView.hidden = YES;
    self.tableView.hidden = NO;
}

- (IBAction)btnAttentionClick:(id)sender{
    WEAK_SELF;
    
    if(self.doc.isFocus){
        [self startCancelAttentionDoctorWithDocId:self.doc.ID success:^{
            weakself.doc.isFocus = NO;
            weakself.btnHeaderAttetion.selected = NO;
        } failure:^(NSString *error_message) {
            
        }];
    }else{
        [self startAttentionDoctorWithDocId:self.doc.ID success:^{
            weakself.doc.isFocus = YES;
            weakself.btnHeaderAttetion.selected = YES;
        } failure:^(NSString *error_message) {
            
        }];
    }
}


@end
