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
    
    [self.showKeyboardViews addObjectsFromArray:@[self.tfCitizenNumber,self.tfIdCard,self.tfName]];
    
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
    
    if(self.tfName.text.length == 0){
        [MBProgressHUD showError:@"姓名不能为空"];
        return;
    }
    
    if(self.tfIdCard.text.length == 0){
        [MBProgressHUD showError:@"身份证号不能为空"];
        return;
    }
    
    if(self.tfCitizenNumber.text.length == 0){
        [MBProgressHUD showError:@"社保卡号不能为空"];
        return;
    }
    
    
    if(![self isIdCard:self.tfIdCard.text]){
        [MBProgressHUD showError:@"身份证号格式不正确"];
        return;
    }
    
    if(![self isIdCard:self.tfCitizenNumber.text]){
        [MBProgressHUD showError:@"社保卡号格式不正确"];
        return;
    }
    
    [self startRealNameAuthenticationWithName:self.tfName.text andIdCard:self.tfIdCard.text andCitizenNumber:self.tfCitizenNumber.text success:^(NSObject *resultDic) {
        weakself.vcCallback(self.tfName.text,self.tfIdCard.text);
        [weakself.navigationController popViewControllerAnimated:YES];
    } failure:^(NSString *error_message) {
        
    }];
}

-(BOOL)isIdCard:(NSString *)str
{
    NSString * regex        = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate * pred      = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch            = [pred evaluateWithObject:str];
    if (isMatch) {
        return YES;
    }else{
        return NO;
    }
}

@end
