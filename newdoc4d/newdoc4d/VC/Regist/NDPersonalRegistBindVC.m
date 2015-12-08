//
//  NDPersonalRegistBindVC.m
//  newdoc
//
//  Created by zzc on 15/11/5.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDPersonalRegistBindVC.h"
#import "NDPersonalCenterHomeVC.h"
#import "NDVerifyCodeVC.h"
#import "NDBaseTabVC.h"

@interface NDPersonalRegistBindVC ()

@property (strong, nonatomic) IBOutlet UIView *sectionHeader;

@property (strong, nonatomic) IBOutlet FormCell *cellPhone;
@property (weak, nonatomic) IBOutlet Button *btnBinding;
@property (weak, nonatomic) IBOutlet Button *btnIgnore;
@property (weak, nonatomic) IBOutlet UITextField *tfPhoneNumber;

@end

@implementation NDPersonalRegistBindVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupUI];
    
}

- (void)setupUI{
    WEAK_SELF;
    
    self.title = @"第三方账号绑定手机号";
    
    [self appendSection:@[self.cellPhone] withHeader:self.sectionHeader];
    
    self.btnBinding.layer.cornerRadius = 5;
    self.btnBinding.layer.masksToBounds = YES;
    self.btnBinding.callback = ^(Button *btn){
        if (![weakself isPhoneText:weakself.tfPhoneNumber.text]) {
            return;
        }
        
        CreateVC(NDVerifyCodeVC);
        vc.phoneNumber = weakself.tfPhoneNumber.text;
        PushVCWeak(vc);
    };
    
    self.btnIgnore.layer.cornerRadius = 5;
    self.btnIgnore.layer.masksToBounds = YES;
    self.btnIgnore.callback = ^(Button *btn){
        NDBaseTabVC *tabVC = [NDBaseTabVC new];
        tabVC.selectedIndex = 1;
        [[UIApplication sharedApplication].keyWindow setRootViewController:tabVC];
    };

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
