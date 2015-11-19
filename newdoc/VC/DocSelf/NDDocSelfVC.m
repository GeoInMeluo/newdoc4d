//
//  NDDocSelfVC.m
//  newdoc
//
//  Created by zzc on 15/11/16.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDDocSelfVC.h"

@interface NDDocSelfVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet Button *btnArm;
@property (weak, nonatomic) IBOutlet Button *btnArmRight;
@property (weak, nonatomic) IBOutlet Button *btnNeck;
@property (weak, nonatomic) IBOutlet Button *btnChest;
@property (weak, nonatomic) IBOutlet Button *btnStomach;
@property (weak, nonatomic) IBOutlet Button *btnLeg;
@property (weak, nonatomic) IBOutlet Button *btnLegRight;
@property (weak, nonatomic) IBOutlet Button *btnBack;

@property (weak, nonatomic) IBOutlet UIImageView *ivBackground;
@property (strong, nonatomic) IBOutlet UIView *vBack;
@property (strong, nonatomic) IBOutlet UIView *vFront;

@property (weak, nonatomic) IBOutlet UIView *vTop;
@property (strong, nonatomic) IBOutlet UIView *vDetail;
@property (weak, nonatomic) IBOutlet UITableView *leftTable;
@property (weak, nonatomic) IBOutlet UITableView *rightTable;



@end

@implementation NDDocSelfVC

- (IBAction)switchBack:(UISwitch *)sender {
    
    if(sender.on){
        self.vBack.hidden = YES;
        self.ivBackground.image = [UIImage imageWithName:@"正面"];
        self.vFront.hidden = NO;
    }else{
        self.vBack.hidden = NO;
        self.ivBackground.image = [UIImage imageWithName:@"背面"];
        self.vFront.hidden = YES;
    }
}

- (IBAction)change2List:(UISegmentedControl *)sender {
    if(sender.selectedSegmentIndex == 0){
        self.vDetail.hidden = YES;
    }else{
        self.vDetail.hidden = NO;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI{
    self.title = @"新医自诊";
    
    WEAK_SELF;
    
    self.btnArm.callback = ^(Button *btn){
        
    };
    self.btnArmRight.callback = ^(Button *btn){

    };
    self.btnBack.callback = ^(Button *btn){
        
    };
    self.btnChest.callback = ^(Button *btn){
        
    };
    self.btnLeg.callback = ^(Button *btn){
        
    };
    self.btnLegRight.callback = ^(Button *btn){
   
    };
    self.btnNeck.callback = ^(Button *btn){
        
    };
    self.btnStomach.callback = ^(Button *btn){
        
    };
    
    [self.view addSubview:self.vBack];
    self.vBack.hidden = YES;
    [self.view addSubview:self.vDetail];
    self.vDetail.hidden = YES;
}

- (IBAction)btnArmTouchDown:(id)sender {
    self.ivBackground.image = [UIImage imageWithName:@"上肢"];
}
- (IBAction)btnNeckTouchDown:(id)sender {
    self.ivBackground.image = [UIImage imageWithName:@"头颈部"];
}
- (IBAction)btnChestTouchDown:(id)sender {
    self.ivBackground.image = [UIImage imageWithName:@"胸腔"];
}
- (IBAction)btnStomatch:(id)sender {
    self.ivBackground.image = [UIImage imageWithName:@"腹部"];
}
- (IBAction)btnLegTouchDown:(id)sender {
    self.ivBackground.image = [UIImage imageWithName:@"下肢"];
}
- (IBAction)btnBackTouchDown:(id)sender {
    self.ivBackground.image = [UIImage imageWithName:@"后背"];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.vBack.frame = self.vFront.frame;
    self.vBack.hidden = YES;
    self.vDetail.frame = self.vFront.frame;
    self.vDetail.height = self.view.height - self.vTop.height;
    self.vDetail.top = self.vTop.bottom - 1;
    self.vDetail.hidden = YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"cellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    if(tableView == self.leftTable){
    
    }else{
        cell.backgroundColor = LightGray;
    }
    
    return cell;
    
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
