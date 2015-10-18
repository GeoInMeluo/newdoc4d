//
//  NDRoomSelectMoreVC.m
//  newdoc
//
//  Created by zzc on 15/10/16.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDRoomSelectMoreVC.h"
#import "NDRoomDetailVC.h"

@interface NDRoomSelectMoreVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation NDRoomSelectMoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == self.leftTable){
        return 5;
    }
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView == self.leftTable){
        static NSString *cellId = @"cellId";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        cell.textLabel.text = @"诊所";
        
        return cell;
    }
    
    static NSString *cellId = @"cellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.textLabel.text = @"科室";
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView != self.leftTable){
        [self.parentVC.navigationController pushViewController:[NDRoomDetailVC new] animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
