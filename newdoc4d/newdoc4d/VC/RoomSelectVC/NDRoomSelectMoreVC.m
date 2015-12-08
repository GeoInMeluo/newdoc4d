//
//  NDRoomSelectMoreVC.m
//  newdoc
//
//  Created by zzc on 15/10/16.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDRoomSelectMoreVC.h"
#import "NDRoomDetailVC.h"
#import "NDSubroom.h"

@interface NDRoomSelectMoreVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *subrooms;
@property (nonatomic, strong) NDRoom *selectRoom;
@end

@implementation NDRoomSelectMoreVC

- (NSArray *)subrooms{
    if(_subrooms == nil){
        _subrooms = [NSArray array];
    }
    return _subrooms;
}

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
    if(tableView == self.leftTable){
        return self.rooms.count;
    }
    return self.subrooms.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView == self.leftTable){
        static NSString *cellId = @"cellId";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        NDRoom *room = self.rooms[indexPath.row];
        cell.textLabel.text = room.name;
        
        return cell;
    }
    
    static NSString *cellId = @"cellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }

    NDSubroom *subroom = self.subrooms[indexPath.row];
    cell.textLabel.text = subroom.name;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.leftTable){
        NDRoom *room = self.rooms[indexPath.row];
        
        WEAK_SELF;
        
        [self startGetRoomWithRoomId:room.ID success:^(NDRoom *room) {
            weakself.subrooms = room.catalogs;
            weakself.selectRoom = room;
            [weakself.rightTable reloadData];
        } failure:^(NSString *error_message) {
            
        }];
        
        return;
    }
    
    NDRoomDetailVC *roomDeatailVC = [NDRoomDetailVC new];
//    roomDeatailVC.room = self.selectRoom;
    roomDeatailVC.roomId = self.selectRoom.ID;
    [self.parentVC.navigationController pushViewController:roomDeatailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
