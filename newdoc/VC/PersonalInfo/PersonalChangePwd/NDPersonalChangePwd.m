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

@end

@implementation NDPersonalChangePwd

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"修改密码";
    
    [self setupUI];
}

- (void)setupUI{
    [self appendSection:@[self.cellOldPwd,self.cellNewPwd,self.cellVerify] withHeader:nil];

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
