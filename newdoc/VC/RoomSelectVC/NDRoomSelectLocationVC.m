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

- (NSArray *)provinces{
    if(_provinces == nil){
        _provinces = [NSArray array];
    }
    return _provinces;
}

- (NSArray *)citys{
    if(_citys == nil){
        _citys = [NSArray array];
    }
    return _citys;
}

- (NSArray *)countys{
    if(_countys == nil){
        _countys = [NSArray array];
    }
    return _countys;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self startGetProvinces];
}

- (void)startGetProvinces{
    WEAK_SELF;
    
    [self startGetProvinceListAndSuccess:^(NSArray *provinces) {
        weakself.provinces = provinces;
        [weakself.tableProvince reloadData];
    } failure:^(NSDictionary *result, NSError *error) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(tableView == self.tableProvince){
        return self.provinces.count;
    }
    if(tableView == self.tableCity){
        return self.citys.count;
    }
    if(tableView == self.tableCounty){
        return self.countys.count;
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
        cell.textLabel.text = self.provinces[indexPath.row];
    }
    if(tableView == self.tableCity){
        cell.textLabel.text = self.citys[indexPath.row];
    }
    if(tableView == self.tableCounty){
        cell.textLabel.text = self.countys[indexPath.row];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WEAK_SELF;
    
    if(tableView == self.tableProvince){
        self.provinceName = self.provinces[indexPath.row];
        self.area = self.provinces[indexPath.row];
        [self startGetCityListWithProvince:self.provinces[indexPath.row] success:^(NSArray *citys) {
            weakself.citys = citys;
            [weakself.tableCity reloadData];
        } failure:^(NSDictionary *result, NSError *error) {
            
        }];
    }
    if(tableView == self.tableCity){
        self.cityName = self.citys[indexPath.row];
        self.area = [NSString stringWithFormat:@"%@ %@", self.provinceName, self.citys[indexPath.row]];
        [self startGetCountyListWithCity:self.citys[indexPath.row] success:^(NSArray *countys) {
            weakself.countys = countys;
            [weakself.tableCounty reloadData];
        } failure:^(NSDictionary *result, NSError *error) {
            
        }];
    }
    if(tableView == self.tableCounty){
        self.countyName = self.countys[indexPath.row];
        self.area = [NSString stringWithFormat:@"%@ %@ %@", self.provinceName, self.cityName, self.countys[indexPath.row]];
        self.view.hidden = YES;
        self.countyCellCallback();
    }
    
    //通知地图页面做相应的处理
    [[NSNotificationCenter defaultCenter] postNotificationName:@"roomMapChangeSearchFieldText" object:nil];
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
