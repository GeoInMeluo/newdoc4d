 //
//  NDLoginVC.m
//  newdoc
//
//  Created by zzc on 15/10/21.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDLoginVC.h"
#import "NDPersonalRegistVC.h"
#import "NDPersonalCenterHomeVC.h"
#import "NDPersonalForgetPwdVC.h"
#import "NDBaseTabVC.h"
#import "NDBaseNavVC.h"
#import "NDPersonalRegistBindVC.h"

@interface NDLoginVC ()
@property (strong, nonatomic) IBOutlet FormCell *cellAccount;
@property (strong, nonatomic) IBOutlet FormCell *cellPwd;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UITextField *tfUsername;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (nonatomic, weak) Button *btnRegist;
@property (weak, nonatomic) IBOutlet Button *btnForgetPwd;

@end

@implementation NDLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    Button *btnRegist = [[Button alloc] initWithFrame:CGRectMake(0, 0, 73, 30)];
    [btnRegist setTitle:@"注册" forState:UIControlStateNormal];
    [btnRegist setTitleColor:Blue forState:UIControlStateNormal];
    btnRegist.layer.cornerRadius = 5;
    btnRegist.layer.masksToBounds = YES;
    btnRegist.layer.borderColor = Blue.CGColor;
    btnRegist.layer.borderWidth = 1;
    btnRegist.bottom = kScreenSize.height - 200;
    btnRegist.centerX = kScreenSize.width * 0.5;
    [btnRegist addTarget:self action:@selector(btnRegistClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnRegist];
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}

- (void)setupUI{
    WEAK_SELF;
    
    self.title = @"登录";
    
    [self appendSection:@[self.cellAccount,self.cellPwd] withHeader:nil];
    
    self.btnLogin.layer.cornerRadius = 5;
    self.btnLogin.layer.masksToBounds = YES;
    
    self.btnForgetPwd.callback = ^(Button *btn){
        [weakself.navigationController pushViewController:[NDPersonalForgetPwdVC new] animated:YES];
    };
}

- (IBAction)btnLoginClick:(UIButton *)sender {
    
    WEAK_SELF;
    
    if(self.tfUsername.text.length == 0){
        ShowAlert(@"请输入用户名");
        
        return;
    }
    
    if(self.tfPassword.text.length == 0){
        ShowAlert(@"请输入密码");
        
        return;
    }
    
    if(![self isPhoneText:self.tfUsername.text]){
        
        ShowAlert(@"请输入正确手机号");
        
        return;
    }
    
    [self startLoginWithUsername:self.tfUsername.text andPassWord:self.tfPassword.text success:^{

            [weakself.navigationController popViewControllerAnimated:YES];
            
//            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:[NSHTTPCookie cookieWithProperties:@{@"openid":@"000000000007",@"newdocid":@"newdocid00weixin000000007"}]];
//            for (UIViewController *controller in self.navigationController.viewControllers) {
//                if ([controller isKindOfClass:[NDPersonalCenterHomeVC class]]) {
//                    
//                    NDPersonalCenterHomeVC *vc = (NDPersonalCenterHomeVC *)controller;
//                    vc.user = user;
//                    [weakself.navigationController popToViewController:vc animated:YES];
//                    
//                }
//            }
        
        
    } failure:^(NSString *error_message) {
        
    }];
}



- (IBAction)btnWechat:(id)sender {
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc ] init ];
    
    if([NDCoreSession coreSession].openId.length){
        req.scope = @"snsapi_base" ;
    }else{
        req.scope = @"snsapi_userinfo" ;
    }
    
    req.state = @"123" ;
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
//    [WXApi sendAuthReq:req viewController:self delegate:self];
}

/*********实现和微信终端交互的具体请求与回应***********/
-(void) onReq:(BaseReq*)req{
    
}

//授权后回调 WXApiDelegate
-(void)onResp:(BaseReq *)resp
{
    WEAK_SELF;
    
    /*
     ErrCode ERR_OK = 0(用户同意)
     ERR_AUTH_DENIED = -4（用户拒绝授权）
     ERR_USER_CANCEL = -2（用户取消）
     code    用户换取access_token的code，仅在ErrCode为0时有效
     state   第三方程序发送时用来标识其请求的唯一性的标志，由第三方程序调用sendReq时传入，由微信终端回传，state字符串长度不能超过1K
     lang    微信客户端当前语言
     country 微信用户当前国家信息
     */
    SendAuthResp *aresp = (SendAuthResp *)resp;
    if (aresp.errCode== 0) {
        NSString *code = aresp.code;
        
        FLog(@"%@", code);
        FLog(@"%@", self);
        
        [self startRegistWithWXCode:code success:^(NSObject *resultDic) {
            
            __block NSDictionary * result = (NSDictionary *)resultDic;
            
            FLog(@"%@", resultDic);
            
            [[NSUserDefaults standardUserDefaults] setObject:result[@"openid"] forKey:@"openid"];
            [[NSUserDefaults standardUserDefaults] setObject:result[@"authkey"] forKey:@"authkey"];
            [[NSUserDefaults standardUserDefaults] setObject:result[@"1"] forKey:@"iswxlogin"];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [NDCoreSession coreSession].openId = result[@"openid"];
            [NDCoreSession coreSession].isWxLogin = @"1";
            
            FLog(@"%@", self);
            
            [self startGetUserInfoAndSuccess:^(NDUser *user) {
                if(user != nil){
                    
                    [NDCoreSession coreSession].user = user;
                    
                    
                    NSString *tempPath =  NSTemporaryDirectory();
                    
                    NSString *filePath =  [tempPath stringByAppendingPathComponent:@"user.data"];
                    
                    [NSKeyedArchiver archiveRootObject:user toFile:filePath];
                    
                    FLog(@"%@", weakself);
                    FLog(@"%@", weakself.navigationController);
                    
//                    [self.navigationController popToRootViewControllerAnimated:YES];
//                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                    
                    
                    if(user.mobile.length == 0){
                        NDBaseNavVC *nav = [[NDBaseNavVC alloc] initWithRootViewController:[NDPersonalRegistBindVC new]];
                        
                        [[UIApplication sharedApplication].keyWindow setRootViewController:nav];
                        
                    }else{
                        NDBaseTabVC *tabVC = [NDBaseTabVC new];
                        tabVC.selectedIndex = 2;
                        [[UIApplication sharedApplication].keyWindow setRootViewController:tabVC];
                    }
                    
                    
                }
            } failure:^(NSString *error_message) {
                
            }];
            
        } failure:^(NSString *error_message) {
            
        }];
    }
}
/********************/

- (IBAction)btnWeibo:(id)sender {
}

- (IBAction)btnQQ:(id)sender {
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

- (void)btnRegistClick{
    ShowVC(NDPersonalRegistVC);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
