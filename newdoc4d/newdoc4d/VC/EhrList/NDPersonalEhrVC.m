//
//  NDPersonalEhrVC.m
//  newdoc
//
//  Created by zzc on 15/10/21.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDPersonalEhrVC.h"
#import "NDPersonalEhrCell.h"
#import "NDPersonalEhrFooter.h"
#import "NDEhr.h"

@interface NDPersonalEhrVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *sectionIds;
@property (nonatomic, assign) NSInteger lastSelectedIndex;
@property (nonatomic, strong) NSArray *ehrs;
@end

@implementation NDPersonalEhrVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"患者病历";
    
    [self startGet];
    
    
}

- (void)startGet{
    WEAK_SELF;
    
    [self startGetEhrsWithName:self.name success:^(NSArray *ehrs) {
        weakself.ehrs = ehrs;
        
//        self.sectionIds = [NSMutableArray arrayWithArray:@[@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0"]];
        
        self.sectionIds = [NSMutableArray array];
        
        for (int i = 0; i< ehrs.count; i++) {
            [self.sectionIds addObject:@"0"];
        }
        
        weakself.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        [weakself.tableView reloadData];
    } failure:^(NSString *error_message) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.ehrs.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"NDPersonalEhrCell";
    
    NDPersonalEhrCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        cell = [NDPersonalEhrCell new];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NDEhr *ehr = self.ehrs[indexPath.section];
    
     cell.lblTime.text = ehr.actual_date;
    
    if([self.sectionIds[indexPath.section] isEqualToString: @"1"]){
//        CABasicAnimation *anim = [[CABasicAnimation alloc] init];
//        anim.keyPath = @"transform.rotation";
//        anim.toValue = [NSNumber numberWithDouble:(M_PI * 0.5)];
//        [cell.imgArrow.layer addAnimation:anim forKey:@"imgArrow"];
        
    }

    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    self.sectionIds = [NSMutableArray arrayWithArray:@[@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0"]];
    self.sectionIds = [NSMutableArray array];
    
    for (int i = 0; i< self.ehrs.count; i++) {
        [self.sectionIds addObject:@"0"];
    }
    
    self.sectionIds[indexPath.section] = @"1";
    self.lastSelectedIndex = indexPath.section;
//
//    NSIndexSet *set = [NSIndexSet indexSetWithIndex:indexPath.section];
//    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
//    
//    NSIndexSet *lastSet = [NSIndexSet indexSetWithIndex:self.lastSelectedIndex];
//    [self.tableView reloadSections:lastSet withRowAnimation:UITableViewRowAnimationNone];
//
    
    [self.tableView reloadData];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if([self.sectionIds[section] isEqualToString:@"1"]){
        NDPersonalEhrFooter *view = [NDPersonalEhrFooter new];
        NDEhr *ehr = self.ehrs[section];
        
        view.lblTitle.text = ehr.title;
        view.lblDetail.text = ehr.detail;
        return view;
    }
    
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if([self.sectionIds[section] isEqualToString:@"1"]){
        return [self tableView:tableView viewForFooterInSection:section].height;
    }
    return 0;
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
