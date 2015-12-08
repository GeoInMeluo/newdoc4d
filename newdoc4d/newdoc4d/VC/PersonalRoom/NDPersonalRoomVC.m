//
//  NDPersonalRoomVC.m
//  newdoc4d
//
//  Created by zzc on 15/11/29.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDPersonalRoomVC.h"
#import "NDPersonalRoomCell1.h"
#import "NDPersonalRoomCell2.h"
#import "NDSampleRoom.h"

@interface NDPersonalRoomVC ()
@property (nonatomic, strong) NDDocInfo *docInfo;
@end

@implementation NDPersonalRoomVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

- (void)setupUI{
    self.title = @"我签约的诊室";
    
    WEAK_SELF;
    
    [self startGetUserInfoMoreAndSuccess:^(NDDocInfo *docInfo) {
        weakself.docInfo = docInfo;
        
        [weakself.tableView reloadData];
    } failure:^(NSString *error_message) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return self.docInfo.signed_rooms.count;
    }
    
    return self.docInfo.appli_rooms.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WEAK_SELF;
    
    if(indexPath.section == 0){
        static NSString *cellId = @"NDPersonalRoomCell1";
        
        NDPersonalRoomCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell == nil){
            cell = [NDPersonalRoomCell1 new];
        }
        
        NDSampleRoom *room = self.docInfo.signed_rooms[indexPath.row];
        
        cell.lblRoomName.text = room.name;
        cell.lblRoomLoc.text = room.address;
        cell.btnCancel.callback = ^(Button *btn){
            [weakself startCancelSignRoomWithRoomId:room.ID success:^{
                [weakself.tableView reloadData];
            } failure:^(NSString *error_message) {
                
            }];
        };
        
        return cell;
    }else{
        static NSString *cellId = @"NDPersonalRoomCell2";
        
        NDPersonalRoomCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell == nil){
            cell = [NDPersonalRoomCell2 new];
        }
        
        NDSampleRoom *room = self.docInfo.appli_rooms[indexPath.row];
        
        cell.lblRoomName.text = room.name;
        
        if([room.action isEqualToString:@"BIND"]){
            cell.lblState.text = @"申请签约";
        }else{
            cell.lblState.text = @"申请解约";
            
        }
        
        
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UILabel *label = [UILabel new];
    label.backgroundColor = LightGray;
    
    if(section == 0){
        label.text = @"已签约";
    }else{
        label.text = @"审核中";
    }
    
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(self.docInfo.signed_rooms.count == 0 && section == 0 ){
        return 0;
    }
    if(self.docInfo.appli_rooms.count == 0 && section == 1 ){
        return 0;
    }
    
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 34;
}
@end
