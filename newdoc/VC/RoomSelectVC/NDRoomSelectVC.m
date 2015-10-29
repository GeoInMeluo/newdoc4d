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
    
    static NSString *cellId = @"NDRoomSelectCell";
    
    NDRoomSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        cell = [[NDRoomSelectCell alloc] init];
    }
    
    NDRoom *room = self.rooms[indexPath.row];
    cell.room = room;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 132;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    ShowVC(NDRoomDetailVC);
    NDRoomDetailVC *vc =[NDRoomDetailVC new];
    vc.room = self.rooms[indexPath.row];
    [self.parentVC.navigationController pushViewController:vc animated:YES];
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
