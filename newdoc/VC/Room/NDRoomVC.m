//
//  NDRoomVC.m
//  newdoc
//
//  Created by zzc on 15/10/11.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDRoomVC.h"
#import "NDRoomCell.h"
#import "NDRoomMapVC.h"
#import "NDQAOnlineVC.h"
#import "NDRoomTempCellTableViewCell.h"
#import "NDDocSelfVC.h"

@interface NDRoomVC ()
@property (strong, nonatomic) IBOutlet UITableViewCell *tempCell1;
@property (strong, nonatomic) IBOutlet UITableViewCell *tempCell2;

@end

@implementation NDRoomVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI{
    self.title = @"新医诊室";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    static NSString *cellId = @"NDRoomCell";
//    
//    NDRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//
//    if(cell == nil){
//        cell = [[NDRoomCell alloc] init];
//    }
//    
//    return cell;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"NDRoomTempCellTableViewCell";
    
    NDRoomTempCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        cell = [NDRoomTempCellTableViewCell new];
    }
    
    if(indexPath.row == 0){
        cell.image.image = [UIImage imageNamed:@"temp_home_1"];
    }else{
         cell.image.image = [UIImage imageNamed:@"temp_home_2"];
    }
    
    return cell;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 295;
    
    if(indexPath.row == 0){
        return 200;
    }else{
        return 100;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    todo();
//    ShowVC(NDRoomMapVC);
}

- (IBAction)btnHeader1Click:(id)sender {
    ShowVC(NDDocSelfVC);
}

- (IBAction)btnHeader2Click:(id)sender {
    if([self checkLoginWithNav:self.navigationController]){
        ShowVC(NDQAOnlineVC);
    }
}

- (IBAction)btnHeader3Click:(id)sender {
    ShowVC(NDRoomMapVC);
}



@end
