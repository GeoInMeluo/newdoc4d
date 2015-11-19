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

@property (nonatomic, strong) NSArray *qaMesaages;

@property (nonatomic, strong) NSMutableArray *currentTalks;

@property (nonatomic, strong) NSMutableArray *dateQAMessages;
@end

@implementation NDPersonalReferVC

- (NSMutableArray *)currentTalks{
    if(_currentTalks == nil){
        _currentTalks = [NSMutableArray array];
    }
    return _currentTalks;
}

- (NSMutableArray *)dateQAMessages{
    if(_dateQAMessages == nil){
        _dateQAMessages = [NSMutableArray array];
    }
    return _dateQAMessages;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的咨询";
    
    [self setup];
    
//    self.sectionsID = [NSMutableArray arrayWithArray:@[@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0"]];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)setup{
    WEAK_SELF;
    
    [self startGetQAListAndSuccess:^(NSArray *qaMessages) {
        weakself.qaMesaages = qaMessages;
        
//        @autoreleasepool {

            if(!qaMessages){
                return ;
            }
            
            for(int i = 0; i < qaMessages.count ; i++){
                NDQAMessage *iQA = qaMessages[i];
                
                FLog(@"iqaID == %@", iQA.ID);
                FLog(@"content == %@", iQA.content);
                FLog(@"startDate == %@", iQA.start_date);
                
                if(iQA.start_date){
                    return;
                }
                
                [self.dateQAMessages addObject:iQA.start_date];
                for(int j = 0; j < i ; j++){
                    NDQAMessage *jQA = qaMessages[j];
                    
                    if([iQA.start_date isEqualToString:jQA.start_date]){
                        [self.dateQAMessages delete:jQA.start_date];
                    }
                }
            }
            
            for(int i = 0; i < self.dateQAMessages.count; i++){
                [weakself.sectionsID addObject:@"0"];
            }
            
//        }
        
        [weakself.tableView reloadData];
    } failure:^(NSString *error_message) {
        
    }];
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
////    return self.sectionsID.count;
//    if([tableView isKindOfClass:[NDPersonalReferFooter class]]){
//        return self.dateQAMessages.count;;
//    }else{
//        return 1;
//    }
//    
////    return self.qaMesaages.count;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([tableView isKindOfClass:[NDPersonalReferFooter class]]){
        return self.dateQAMessages.count;
    }else{
        return self.currentTalks.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([tableView isKindOfClass:[NDPersonalReferFooter class]]){
        static NSString *cellId = @"NDPersonalReferFooterCell";
        
        NDPersonalReferFooterCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell == nil){
            cell = [NDPersonalReferFooterCell new];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        NDQAMessage *qaMessage = self.currentTalks[indexPath.row];
        
        
        
        return cell;
    }else{
        static NSString *cellId = @"NDPersonalReferCell";
        
        NDPersonalReferCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell == nil){
            cell = [NDPersonalReferCell new];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.lblDate.text = self.dateQAMessages[indexPath.row];
        
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
//        self.sectionsID = [NSMutableArray arrayWithArray:@[@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0"]];
        for(int i = 0; i < self.dateQAMessages.count ; i++){
            [self.sectionsID addObject:@"0"];
        }
        
        self.sectionsID[indexPath.section] = @"1";
        self.lastSelectedIndex = indexPath.section;
   
        for(int i = 0; i < self.qaMesaages.count; i++){
            NDQAMessage *qaMessage =self.qaMesaages[i];
            
            if([qaMessage.start_date isEqualToString:self.dateQAMessages[indexPath.row]]){
                [self.currentTalks addObject:qaMessage];
            }
        }
        
        [tableView reloadData];
    }
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if([tableView isKindOfClass:[NDPersonalReferFooter class]]){
        
    }else{
        if([self.sectionsID[section] isEqualToString:@"1"]){
            NDPersonalReferFooter *view = [NDPersonalReferFooter new];
            
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

@end
