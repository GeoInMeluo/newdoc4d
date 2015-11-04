//
//  NDPersonalRegistVC.m
//  newdoc
//
//  Created by zzc on 15/10/22.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDPersonalRegistVC.h"
#import "NDPersonalRegistConfirmVC.h"

@interface NDPersonalRegistVC ()
@property (strong, nonatomic) IBOutlet FormCell *cellPhoneNumber;
@property (weak, nonatomic) IBOutlet UIButton *btnRegist;
@property (strong, nonatomic) IBOutlet FormCell *cellPwd;
@property (strong, nonatomic) IBOutlet FormCell *cellConfirmPwd;
@property (strong, nonatomic) IBOutlet FormCell *cellVerifyCode;

@property (weak, nonatomic) IBOutlet UITextField *tfPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *tfPwd;
@property (weak, nonatomic) IBOutlet UITextField *tfPwdConfirm;
@property (weak, nonatomic) IBOutlet UITextField *tfVerifyCode;
@property (weak, nonatomic) IBOutlet UIButton *btnVerifyCode;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger startTime;

@property (weak, nonatomic) IBOutlet Button *btnAgree;

@end

@implementation NDPersonalRegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI{
    self.startTime = 60;
    
    self.title = @"注册";
    
    self.btnVerifyCode.layer.masksToBounds = YES;
    self.btnVerifyCode.layer.cornerRadius = 5;
    
    self.btnRegist.layer.cornerRadius = 5;
    self.btnRegist.layer.masksToBounds = YES;
    
    self.btnAgree.callback = ^(Button *btn){
        btn.selected = !btn.selected;
    };
    
    [self.cells addObjectsFromArray:@[self.cellPhoneNumber,self.cellPwd,self.cellConfirmPwd,self.cellVerifyCode]];
    
    
}

- (IBAction)btnVerifyCodeClick:(id)sender {
    if(![self isPhoneText:self.tfPhoneNumber.text]){
        
        ShowAlert(@"请输入正确手机号");
        
        return;
    }
    
    [self timeStart];
    
    [self startSendVerifyCodeWithPhoneNumber:self.tfPhoneNumber.text success:^(NSObject *resultDic) {

    }  failure:^(NSDictionary *result, NSError *error) {
        
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
    
    [self.btnVerifyCode setTitle:[NSString stringWithFormat:@"%zd 秒",_startTime] forState:UIControlStateNormal];
    
    if(_startTime == 0){
        self.btnVerifyCode.enabled = YES;
        [self timeStop];
        _startTime = 60;
        [self.btnVerifyCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    
    
}

- (IBAction)btnRegistClick:(id)sender {
//    self startRegistWithUsername:self.tf andPassWord:<#(NSString *)#> andVerifyCode:<#(NSString *)#> success:<#^(void)success#> failure:<#^(NSDictionary *result, NSError *error)failure#>
    
}

-(BOOL)isPhoneText:(NSString *)str
{
    NSString * regex        = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
    NSPredicate * pred      = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch            = [pred evaluateWithObject:str];
    if (isMatch) {
        return YES;
    }else{
        return NO;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.timer = nil;
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
