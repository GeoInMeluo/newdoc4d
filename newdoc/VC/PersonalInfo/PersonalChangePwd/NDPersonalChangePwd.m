//
//  NDViewController.m
//  newdoc
//
//  Created by zzc on 15/10/20.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDPersonalChangePwd.h"

@interface NDPersonalChangePwd ()
@property (strong, nonatomic) IBOutlet FormCell *cellOldPwd;
@property (strong, nonatomic) IBOutlet FormCell *cellNewPwd;
@property (strong, nonatomic) IBOutlet FormCell *cellVerify;
@property (weak, nonatomic) IBOutlet UITextField *tfOldPwd;
@property (weak, nonatomic) IBOutlet UITextField *tfNewOldPwd;
@property (weak, nonatomic) IBOutlet UITextField *tfVerifyCode;
@property (weak, nonatomic) IBOutlet Button *btnVerifyCode;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger startTime;
@end

@implementation NDPersonalChangePwd

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"修改密码";
    
    [self setupUI];
}

- (void)setupUI{
    self.btnVerifyCode.layer.cornerRadius = 5;
    self.btnVerifyCode.layer.masksToBounds = YES;
    
    [self.showKeyboardViews addObjectsFromArray:@[self.tfNewOldPwd, self.tfOldPwd, self.tfVerifyCode]];
    
    [self appendSection:@[self.cellOldPwd,self.cellNewPwd,self.cellVerify] withHeader:nil];

    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)rightBtnClicked:(UIButton *)button{
    
    WEAK_SELF;
    
    [self startUpdatePwdWithUserId:[NDCoreSession coreSession].nduid andOldPwd:self.tfOldPwd.text andNewPwd:self.tfNewOldPwd.text andVerifyCode:self.tfVerifyCode.text success:^{
        [MBProgressHUD showSuccess:@"修改成功"];
        
        [weakself.navigationController popToRootViewControllerAnimated:YES];
    } failure:^(NSString *error_message) {
        
    }];
}

- (IBAction)btnVerifyCodeClick:(id)sender {
    
    _startTime = 60;
    
    [self timeStart];
    
    [self startSendVerifyCodeForUpdatePasswordWithPhoneNumber:[NDCoreSession coreSession].user.mobile success:^(NSObject *resultDic) {
        
    }  failure:^(NSString *error_message) {
        
    }];
}

- (void)timeStart{
    self.btnVerifyCode.enabled = NO;
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeBtnVerifyTitle) userInfo:nil repeats:YES];
    self.timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    [self.timer fire];
    
}

- (void)timeStop{
    [self.timer invalidate];
    
    self.timer = nil;
}

- (void)changeBtnVerifyTitle{
    
    _startTime--;
    
    //    self.btnVerifyCode.enabled = NO;
    
    [self.btnVerifyCode setTitle:[NSString stringWithFormat:@"%zd  s",_startTime] forState:UIControlStateNormal];
    
    if(_startTime == 0){
        self.btnVerifyCode.enabled = YES;
        [self timeStop];
        _startTime = 60;
        [self.btnVerifyCode setTitle:@"重新发送" forState:UIControlStateNormal];
    }
    
    
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
