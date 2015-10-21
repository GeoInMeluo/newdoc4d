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

@interface NDPersonalEhrVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *sections;
@property (nonatomic, assign) NSInteger lastSelectedIndex;
@end

@implementation NDPersonalEhrVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sections = [NSMutableArray arrayWithArray:@[@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0"]];

    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sections.count;
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
    
    if([self.sections[indexPath.section] isEqualToString: @"1"]){
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
    
    self.sections = [NSMutableArray arrayWithArray:@[@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0"]];
    self.sections[indexPath.section] = @"1";
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
    
    if([self.sections[section] isEqualToString:@"1"]){
        NDPersonalEhrFooter *view = [NDPersonalEhrFooter new];
//        view.width = [UIScreen mainScreen].bounds.size.width;
//        [view setPreservesSuperviewLayoutMargins:YES];
        return view;
    }
    
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if([self.sections[section] isEqualToString:@"1"]){
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
