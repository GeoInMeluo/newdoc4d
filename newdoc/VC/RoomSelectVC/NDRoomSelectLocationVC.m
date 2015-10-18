//
//  NDRoomSelectLocationVC.m
//  newdoc
//
//  Created by zzc on 15/10/18.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDRoomSelectLocationVC.h"
#import "NDRoomDetailVC.h"

@interface NDRoomSelectLocationVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableProvince;
@property (weak, nonatomic) IBOutlet UITableView *tableCity;
@property (weak, nonatomic) IBOutlet UITableView *tableCounty;

@end

@implementation NDRoomSelectLocationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(tableView == self.tableProvince){
        return 10;
    }
    if(tableView == self.tableCity){
        return 5;
    }
    if(tableView == self.tableCounty){
        return 7;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"cellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    if(tableView == self.tableProvince){
        cell.textLabel.text = @"广西";
    }
    if(tableView == self.tableCity){
        cell.textLabel.text = @"柳州市";
    }
    if(tableView == self.tableCounty){
        cell.textLabel.text = @"xx县";
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.parentVC.navigationController pushViewController:[NDRoomDetailVC new] animated:YES];
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
