//
//  NDPersonalApproveVC.m
//  newdoc
//
//  Created by zzc on 15/10/20.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDPersonalApproveVC.h"

@interface NDPersonalApproveVC ()
@property (strong, nonatomic) IBOutlet FormCell *cellName;
@property (strong, nonatomic) IBOutlet FormCell *cellId;
@property (strong, nonatomic) IBOutlet FormCell *cellCitizenNumber;

@property (weak, nonatomic) IBOutlet UITextField *tfName;
@property (weak, nonatomic) IBOutlet UITextField *tfIdCard;
@property (weak, nonatomic) IBOutlet UITextField *tfCitizenNumber;


@end

@implementation NDPersonalApproveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"实名认证";
    
    [self setupUI];
}

- (void)setupUI{
    
    WEAK_SELF;
    
//    [self startGetRealNameAuthenticationWithNameAndSuccess:^(NDRealNameAuth *realNameAuth) {
//        weakself.tfName.text = realNameAuth.real_name;
//        weakself.tfIdCard.text = realNameAuth.insuranceid;
//        weakself.tfCitizenNumber.text = realNameAuth.citizenid;
//        

//    } failure:^(NSString *error_message) {
//        
//    }];
//    
    
    [self appendSection:@[self.cellName,self.cellId,self.cellCitizenNumber] withHeader:nil];
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];

}

- (void)rightBtnClicked:(UIButton *)btn{
    WEAK_SELF;
    
    [self startRealNameAuthenticationWithName:self.tfName.text andIdCard:self.tfIdCard.text andCitizenNumber:self.tfCitizenNumber.text success:^(NSObject *resultDic) {
        weakself.vcCallback(self.tfName.text,self.tfIdCard.text);
        [weakself.navigationController popViewControllerAnimated:YES];
    } failure:^(NSString *error_message) {
        
    }];
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
