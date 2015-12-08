//
//  NDSigningVC.m
//  newdoc4d
//
//  Created by zzc on 15/12/3.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDSigningVC.h"
#import "NDBaseNavVC.h"
#import "NDBaseTabVC.h"
#import "NDPersonalRegistBindVC.h"
#import "NDPersonalApproveVC.h"

@interface NDSigningVC ()

@end

@implementation NDSigningVC
- (IBAction)btnResearch:(id)sender {
    [self startGetUserInfoAndSuccess:^(NDUser *user) {
        if(user.doctor_status == 2){
            if(user.mobile.length == 0){
                NDPersonalRegistBindVC *vc = [NDPersonalRegistBindVC new];
                vc.hiddenLeft = YES;
                NDBaseNavVC *nav = [[NDBaseNavVC alloc] initWithRootViewController:vc];
                
                [[UIApplication sharedApplication].keyWindow setRootViewController:nav];
                
            }else{
                NDBaseTabVC *tabVC = [NDBaseTabVC new];
                tabVC.selectedIndex = 1;
                [[UIApplication sharedApplication].keyWindow setRootViewController:tabVC];
            }
        }else if (user.doctor_status == 1){
            [MBProgressHUD showError:@"还在审核中。。。"];
            
            NDSigningVC *vc = [NDSigningVC new];
            vc.hiddenLeft = YES;
            NDBaseNavVC *nav = [[NDBaseNavVC alloc] initWithRootViewController:vc];
            
            [[UIApplication sharedApplication].keyWindow setRootViewController:nav];
        }else{
            NDPersonalApproveVC *vc = [NDPersonalApproveVC new];
            vc.hiddenLeft = YES;
            NDBaseNavVC *nav = [[NDBaseNavVC alloc] initWithRootViewController:vc];
            
            [[UIApplication sharedApplication].keyWindow setRootViewController:nav];
        }
    } failure:^(NSString *error_message) {
            
        }];

}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"实名认证";
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
