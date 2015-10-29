//
//  NDPersonalRegistConfirmVC.m
//  newdoc
//
//  Created by zzc on 15/10/22.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDPersonalRegistConfirmVC.h"
#import "NDBaseTabVC.h"

@interface NDPersonalRegistConfirmVC ()
@property (strong, nonatomic) IBOutlet FormCell *cellVerifyCode;
@property (weak, nonatomic) IBOutlet UIButton *btnConfirm;
@property (weak, nonatomic) IBOutlet UITextField *tfVerifyCode;

@end

@implementation NDPersonalRegistConfirmVC
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI{
    self.title = @"注册";
    
    self.btnConfirm.layer.cornerRadius = 5;
    self.btnConfirm.layer.masksToBounds = YES;
    
    [self.cells addObjectsFromArray:@[self.cellVerifyCode]];
}

- (IBAction)btnConfirmClick:(id)sender {
    if([SafeString(self.verifyCode) isEqual:self.tfVerifyCode.text]){
        [UIApplication sharedApplication].keyWindow.rootViewController = [NDBaseTabVC new];
    }
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
