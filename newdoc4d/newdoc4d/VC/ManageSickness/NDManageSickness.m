//
//  NDManageSickness.m
//  newdoc4d
//
//  Created by zzc on 15/11/27.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDManageSickness.h"
#import "NDSickerEhrVC.h"
#import "NDQAMessageCenter.h"
#import "NDRoomTempCellTableViewCell.h"
#import "NDRoomTempDetailVC.h"

@interface NDManageSickness ()

@end

@implementation NDManageSickness

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)btnEhrClicked:(id)sender {
    ShowVC(NDSickerEhrVC);
}

- (IBAction)btnMessageClicked:(id)sender {
    ShowVC(NDQAMessageCenter);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"NDRoomTempCellTableViewCell";
    
    NDRoomTempCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        cell = [NDRoomTempCellTableViewCell new];
    }
    
    return cell;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 94;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    todo();
    NDRoomTempDetailVC *vc = [NDRoomTempDetailVC new];
    vc.urlStr = @"http://www.xinyijk.com/meducation.html";
    PushVC(vc);
}

- (IBAction)btnBigClicked:(id)sender {
    NDRoomTempDetailVC *vc = [NDRoomTempDetailVC new];
    vc.urlStr = @"http://www.xinyijk.com/mpublicactivity.html";
    PushVC(vc);
}

@end
