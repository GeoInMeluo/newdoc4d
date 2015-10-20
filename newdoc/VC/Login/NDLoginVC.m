//
//  NDLoginVC.m
//  newdoc
//
//  Created by zzc on 15/10/21.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDLoginVC.h"

@interface NDLoginVC ()
@property (strong, nonatomic) IBOutlet FormCell *cellAccount;
@property (strong, nonatomic) IBOutlet FormCell *cellPwd;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

@end

@implementation NDLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupUI];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    Button *btnRegist = [[Button alloc] initWithFrame:CGRectMake(0, 0, 73, 30)];
    [btnRegist setTitle:@"注册" forState:UIControlStateNormal];
    [btnRegist setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnRegist.layer.cornerRadius = 5;
    btnRegist.layer.masksToBounds = YES;
    btnRegist.layer.borderColor = [UIColor blueColor].CGColor;
    btnRegist.layer.borderWidth = 1;
    btnRegist.bottom = self.tableView.height - 100;
    btnRegist.centerX = self.tableView.width * 0.5;
    [self.tableView addSubview:btnRegist];
}

- (void)setupUI{
    [self.cells addObjectsFromArray:@[self.cellAccount,self.cellPwd]];
    
    self.btnLogin.layer.cornerRadius = 5;
    self.btnLogin.layer.masksToBounds = YES;
}

- (IBAction)btnLoginClick:(UIButton *)sender {
}

- (IBAction)btnWechat:(id)sender {
}

- (IBAction)btnWeibo:(id)sender {
}

- (IBAction)btnQQ:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
