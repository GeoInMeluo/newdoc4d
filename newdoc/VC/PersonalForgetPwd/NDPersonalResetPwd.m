

//
//  NDPersonalResetPwd.m
//  newdoc
//
//  Created by zzc on 15/11/6.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDPersonalResetPwd.h"

@interface NDPersonalResetPwd ()
@property (strong, nonatomic) IBOutlet FormCell *cellPwd;
@property (strong, nonatomic) IBOutlet FormCell *cellPwdConfirm;
@property (weak, nonatomic) IBOutlet UIButton *btnConfirm;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UITextField *tfPwdConfirm;


@end

@implementation NDPersonalResetPwd

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI{
    self.title = @"重置密码";
    
    [self appendSection:@[self.cellPwd, self.cellPwdConfirm] withHeader:nil];
    
    self.btnConfirm.layer.cornerRadius = 5;
    self.btnConfirm.layer.masksToBounds = YES;
}

- (IBAction)btnConfirmClicked:(id)sender {
    [self startResetPasswordWithPhoneNumber:self.phoneNumber andVerifyCode:self.verifyCode andNewPassword:self.tfPassword.text success:^(NSObject *resultDic) {
        
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
