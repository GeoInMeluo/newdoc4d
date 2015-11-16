//
//  NDVerifyCodeVC.m
//  newdoc
//
//  Created by zzc on 15/11/11.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDVerifyCodeVC.h"
#import "NDBaseTabVC.h"

@interface NDVerifyCodeVC ()
@property (weak, nonatomic) IBOutlet UIButton *btnVerifyCode;
@property (weak, nonatomic) IBOutlet UIButton *btnConfirm;

@property (strong, nonatomic) IBOutlet FormCell *cellVerifyCode;
@property (weak, nonatomic) IBOutlet UITextField *tfVerifyCode;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger startTime;

@end

@implementation NDVerifyCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI{
    self.title = @"验证手机";
    
    self.startTime = 60;
    
    self.btnConfirm.layer.cornerRadius = 5;
    self.btnConfirm.layer.masksToBounds = YES;
    self.btnVerifyCode.layer.cornerRadius = 5;
    self.btnVerifyCode.layer.masksToBounds = YES;
    
    [self appendSection:@[self.cellVerifyCode] withHeader:nil];
}

- (IBAction)btnVerifyCodeClicked:(id)sender {
    
    [self timeStart];
    
    [self startSendVerifyCodeForBindWithPhoneNumber:self.phoneNumber success:^(NSObject *resultDic) {
        
    } failure:^(NSString *error_message) {
        
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



- (IBAction)btnConfirmClicke:(id)sender {
    WEAK_SELF;
    
    [self startBindPhoneNumber:self.phoneNumber andVerifyCode:self.tfVerifyCode.text success:^{
        [NDCoreSession coreSession].user.mobile = weakself.phoneNumber;
        
        NSString *tempPath =  NSTemporaryDirectory();
        
        NSString *filePath =  [tempPath stringByAppendingPathComponent:@"user.data"];
        
        [NSKeyedArchiver archiveRootObject:[NDCoreSession coreSession].user toFile:filePath];
        
        NDBaseTabVC *tabVC = [NDBaseTabVC new];
        tabVC.selectedIndex = 2;
        [[UIApplication sharedApplication].keyWindow setRootViewController:tabVC];
    } failure:^(NSString *error_message) {
        
    }];
}


@end
