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
@property (weak, nonatomic) IBOutlet UITextField *tfPhoneNumber;

@end

@implementation NDPersonalRegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI{
    self.title = @"注册";
    
    self.btnRegist.layer.cornerRadius = 5;
    self.btnRegist.layer.masksToBounds = YES;
    
    [self.cells addObjectsFromArray:@[self.cellPhoneNumber]];
}

- (IBAction)btnRegistClick:(id)sender {
    if(![self isPhoneText:self.tfPhoneNumber.text]){
        
        ShowAlert(@"请输入正确手机号");
        
        return;
    }
    
    [self startSendVerifyCodeWithPhoneNumber:self.tfPhoneNumber.text success:^(NSObject *resultDic) {
        ShowVC(NDPersonalRegistConfirmVC);
    }  failure:^(NSDictionary *result, NSError *error) {
        
    }];
    
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
