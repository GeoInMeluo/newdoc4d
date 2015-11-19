//
//  NCBaseVC.m
//  newdoc
//
//  Created by zzc on 15/10/3.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDBaseVC.h"
#import "NDBaseNavVC.h"

@interface NDBaseVC ()

@end

@implementation NDBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)setup{
    // 设置CGRectZero从导航栏下开始计算
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    if([self rightView]){
        self.navigationController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self rightView]];
    }
    
    self.view.height -= 44;
    
    UIButton *leftNavBtn = [[UIButton alloc] init];
    [leftNavBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftNavBtn setImage:[UIImage imageNamed:@"back"]
                forState:UIControlStateHighlighted];
    [leftNavBtn setTitle:@"返回" forState:UIControlStateNormal];
    [leftNavBtn setTitle:@"返回" forState:UIControlStateHighlighted];
    [leftNavBtn sizeToFit];
    [leftNavBtn addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftNavBtn];
}

- (void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIButton *)rightView{
    return nil;
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
