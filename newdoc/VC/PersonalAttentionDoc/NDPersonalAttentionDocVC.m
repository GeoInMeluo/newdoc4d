//
//  NDPersonalAttentionDocVC.m
//  newdoc
//
//  Created by zzc on 15/10/22.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDPersonalAttentionDocVC.h"
#import "NDPersonalAttentionDocCell.h"
#import "NDRoomOrderVC.h"

@interface NDPersonalAttentionDocVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *docs;
@end

@implementation NDPersonalAttentionDocVC

- (NSArray *)docs{
    if(_docs == nil){
        _docs = [NSArray array];
    }
    return _docs;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我关注的医生";
    
    WEAK_SELF;
    
    [self startGetAttetionDocsWithAndSuccess:^(NSArray *doc) {
        weakself.docs = doc;
        
        [weakself.tableView reloadData];
    } failure:^(NSString *error_message) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.docs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"cellId";
    
    NDPersonalAttentionDocCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        cell = [NDPersonalAttentionDocCell new];
    }
    
    cell.tempDocDic = self.docs[indexPath.row];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 74;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CreateVC(NDRoomOrderVC);
    NDDoctor *doc = [NDDoctor new];
    doc.ID = self.docs[indexPath.row][@"id"];
    vc.doc = doc;
    PushVC(vc);
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
