//
//  NDPersonalReferVC.m
//  newdoc
//
//  Created by zzc on 15/10/21.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDPersonalReferVC.h"
#import "NDPersonalReferCell.h"
#import "NDPersonalReferFooter.h"
#import "NDPersonalReferFooterCell.h"
#import "NDPersonalReferDetail.h"

@interface NDPersonalReferVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *sectionsID;
@property (nonatomic, assign) NSInteger lastSelectedIndex;
@end

@implementation NDPersonalReferVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.sectionsID = [NSMutableArray arrayWithArray:@[@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0"]];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionsID.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([tableView isKindOfClass:[NDPersonalReferFooter class]]){
        static NSString *cellId = @"NDPersonalReferFooterCell";
        
        NDPersonalReferFooterCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell == nil){
            cell = [NDPersonalReferFooterCell new];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    }else{
        static NSString *cellId = @"NDPersonalReferCell";
        
        NDPersonalReferCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell == nil){
            cell = [NDPersonalReferCell new];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        if([self.sectionsID[indexPath.section] isEqualToString: @"1"]){
            //        CABasicAnimation *anim = [[CABasicAnimation alloc] init];
            //        anim.keyPath = @"transform.rotation";
            //        anim.toValue = [NSNumber numberWithDouble:(M_PI * 0.5)];
            //        [cell.imgArrow.layer addAnimation:anim forKey:@"imgArrow"];
            
        }
        
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([tableView isKindOfClass:[NDPersonalReferFooter class]]){
        return 50;
    }else{
       return 50;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([tableView isKindOfClass:[NDPersonalReferFooter class]]){
        ShowVC(NDPersonalReferDetail);
    }else{
        self.sectionsID = [NSMutableArray arrayWithArray:@[@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0"]];
        self.sectionsID[indexPath.section] = @"1";
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
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if([tableView isKindOfClass:[NDPersonalReferFooter class]]){
        
    }else{
        if([self.sectionsID[section] isEqualToString:@"1"]){
            NDPersonalReferFooter *view = [NDPersonalReferFooter new];
            //        view.width = [UIScreen mainScreen].bounds.size.width;
            //        [view setPreservesSuperviewLayoutMargins:YES];
            view.delegate = self;
            view.dataSource = self;
            return view;
        }

    }
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if([tableView isKindOfClass:[NDPersonalReferFooter class]]){
        
    }else{
        if([self.sectionsID[section] isEqualToString:@"1"]){
//            return [self tableView:tableView viewForFooterInSection:section].height;
            return 50 * 10;
        }
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
