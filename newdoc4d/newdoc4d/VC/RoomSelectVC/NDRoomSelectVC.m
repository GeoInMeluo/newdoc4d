//
//  NDRoomSelectVC.m
//  newdoc
//
//  Created by zzc on 15/10/16.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDRoomSelectVC.h"
#import "NDRoomSelectCell.h"
#import "NDRoomDetailVC.h"

@interface NDRoomSelectVC ()

@end

@implementation NDRoomSelectVC
- (NSArray *)rooms{
    if(_rooms == nil){
        _rooms = [NSArray array];
    }
    return _rooms;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.rooms.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WEAK_SELF;
    
    
    static NSString *cellId = @"NDRoomSelectCell";
    
    __block NDRoomSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        cell = [[NDRoomSelectCell alloc] init];
    }
    
    NDRoom *room = self.rooms[indexPath.row];
    cell.room = room;
    cell.btnGo2RoomDetail.callback = ^(Button *btn){
        NDRoomDetailVC *vc =[NDRoomDetailVC new];
//        vc.room = self.rooms[indexPath.row];
        NDRoom *room = self.rooms[indexPath.row];
        vc.roomId = room.ID;
        [weakself.parentVC.navigationController pushViewController:vc animated:YES];
    };
    cell.btnIsBond.callback = ^(Button *btn){
        __block Button *blockBtn = btn;
        
        [weakself startSignRoomWithRoomId:room.ID success:^{
            [blockBtn setTitle:@"审核中" forState:UIControlStateNormal];
            [blockBtn setBackgroundColor:[UIColor lightGrayColor]];
            blockBtn.enabled = NO;
        } failure:^(NSString *error_message) {
            
        }];
    };
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 132;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    ShowVC(NDRoomDetailVC);
    
    
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
