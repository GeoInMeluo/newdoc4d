//
//  NDPersonalCenterHomeVC.m
//  newdoc
//
//  Created by zzc on 15/10/19.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDPersonalCenterHomeVC.h"
#import "NDPersonalInfo.h"
#import "NDLoginVC.h"
#import "NDPersonalEhrVC.h"

@interface NDPersonalCenterHomeVC ()<UITableViewDataSource,UITabBarDelegate>
@property (strong, nonatomic) IBOutlet FormCell *cellInfomation;
@property (strong, nonatomic) IBOutlet FormCell *cellRefer;
@property (strong, nonatomic) IBOutlet FormCell *cellSetting;
@property (strong, nonatomic) IBOutlet FormCell *cellMineRoom;
@property (strong, nonatomic) IBOutlet FormCell *cellMineDoc;
@property (strong, nonatomic) IBOutlet FormCell *cellOrder;
@property (strong, nonatomic) IBOutlet FormCell *cellEhr;
@property (weak, nonatomic) IBOutlet UIButton *headImg;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

@end

@implementation NDPersonalCenterHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI{
    [self initCells];
    
    self.headImg.layer.cornerRadius = self.headImg.width * 0.5;
    self.headImg.layer.masksToBounds = YES;
    self.headImg.layer.borderColor = [UIColor whiteColor].CGColor;
    self.headImg.layer.borderWidth = 2;
}

- (void)initCells{
    WEAK_SELF;
    
    [self.cells addObjectsFromArray:@[self.cellInfomation,self.cellEhr,self.cellMineDoc,self.cellMineRoom,self.cellOrder,self.cellRefer,self.cellSetting]];
 
    self.cellInfomation.callback = ^(FormCell *cell, NSIndexPath *indexPath){
        CreateVC(NDPersonalInfo);
        
        PushVCWeak(vc);
    };
    
    self.cellEhr.callback = ^(FormCell *cell, NSIndexPath *indexPath){
        ShowVCWeak(NDPersonalEhrVC);
    };
    
    self.cellMineDoc.callback = ^(FormCell *cell, NSIndexPath *indexPath){
        todo();
    };
    
    self.cellMineRoom.callback = ^(FormCell *cell, NSIndexPath *indexPath){
        todo();
    };
    
    self.cellOrder.callback = ^(FormCell *cell, NSIndexPath *indexPath){
        todo();
    };
    
    self.cellRefer.callback = ^(FormCell *cell, NSIndexPath *indexPath){
        todo();
    };
    
    self.cellSetting.callback = ^(FormCell *cell, NSIndexPath *indexPath){
        todo();
    };
    
}

- (IBAction)btnLoginClick:(id)sender {
    ShowVC(NDLoginVC);
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
