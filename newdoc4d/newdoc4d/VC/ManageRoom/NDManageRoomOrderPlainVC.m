//
//  NDManageRoomOrderPlainVC.m
//  newdoc4d
//
//  Created by zzc on 15/11/29.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDManageRoomOrderPlainVC.h"
#import "NDManageRoomOrderPlainCell.h"

@interface NDManageRoomOrderPlainVC ()

@end

@implementation NDManageRoomOrderPlainVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

- (void)setupUI{
    
    self.title = @"安排出诊计划";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WEAK_SELF;
    
    static NSString *cellId = @"NDManageRoomPlainCell";
    
    NDManageRoomOrderPlainCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        cell = [NDManageRoomOrderPlainCell new];
    }
    
    cell.btnFirst.callback = ^(Button *btn){
        btn.selected = !btn.selected;
    };
    
    cell.btnSecond.callback = ^(Button *btn){
        btn.selected = !btn.selected;
    };
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
