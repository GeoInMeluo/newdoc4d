//
//  NDSettingTableViewController.m
//  newdoc
//
//  Created by dajie on 15/10/21.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDSettingTableViewController.h"

@interface NDSettingTableViewController ()<UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet FormCell *cellProtocal;
@property (strong, nonatomic) IBOutlet FormCell *cellAbout;
@property (weak, nonatomic) IBOutlet UIButton *btnLogout;

@end

@implementation NDSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupUI{
    self.title = @"设置";
    
    self.btnLogout.layer.cornerRadius = 5;
    self.btnLogout.layer.masksToBounds = YES;
    self.btnLogout.layer.borderColor = Blue.CGColor;
    self.btnLogout.layer.borderWidth = 1;
    
    [self initWithCells];
}

- (void)initWithCells{
    [self appendSection:@[self.cellProtocal,self.cellAbout] withHeader:nil];
}

- (IBAction)btnLogout:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"退出登录" message:@"确定退出吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self logout];
}

- (void)logout{
    
    [[NDCoreSession coreSession] logout];
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
