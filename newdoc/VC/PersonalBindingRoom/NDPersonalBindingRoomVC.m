//
//  NDPersonalBindingRoomVC.m
//  newdoc
//
//  Created by zzc on 15/10/21.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDPersonalBindingRoomVC.h"
#import "NDPersonalBindingRoomCell.h"
#import "NDRoomDetailVC.h"

@interface NDPersonalBindingRoomVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *roomNames;
@end

@implementation NDPersonalBindingRoomVC

- (NSArray *)roomNames{
    if(_roomNames ==nil){
        _roomNames = [NSArray array];
    }
    return _roomNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
}

- (void)startGet{
    WEAK_SELF;
    
    [self startGetBindRoomsWithAndSuccess:^(NSArray *roomNames) {
        weakself.roomNames = roomNames;
        [weakself.tableView reloadData];
    } failure:^(NSString *error_message) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.roomNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"NDPersonalBindingRoomCell";
    
    NDPersonalBindingRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        cell = [NDPersonalBindingRoomCell new];
    }
    
    cell.lblRoomName.text = self.roomNames[indexPath.row];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 36;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShowVC(NDRoomDetailVC);
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
