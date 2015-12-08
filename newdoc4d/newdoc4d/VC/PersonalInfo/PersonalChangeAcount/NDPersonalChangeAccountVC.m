//
//  NDPersonalChangeAccountVC.m
//  newdoc
//
//  Created by zzc on 15/10/19.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDPersonalChangeAccountVC.h"

@interface NDPersonalChangeAccountVC ()
@property (strong, nonatomic) IBOutlet FormCell *tfAccount;
@property (weak, nonatomic) IBOutlet UITextField *tf;

@end

@implementation NDPersonalChangeAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"账号";
    
    [self setupUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupUI{
    [self initWithCells];
    
    [self.showKeyboardViews addObjectsFromArray:@[self.tf,self.tfAccount]];
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)rightBtnClicked:(UIButton *)btn{
    
    [NDCoreSession coreSession].user.name = self.tf.text;
    
    self.nameCallBack(self.tf.text);
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initWithCells{
    [self appendSection:@[self.tfAccount] withHeader:nil];

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
