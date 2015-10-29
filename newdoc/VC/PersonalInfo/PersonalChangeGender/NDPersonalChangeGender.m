//
//  NDPersonalChangeGender.m
//  newdoc
//
//  Created by zzc on 15/10/20.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDPersonalChangeGender.h"

@interface NDPersonalChangeGender ()
@property (strong, nonatomic) IBOutlet FormCell *cellMale;

@property (strong, nonatomic) IBOutlet FormCell *cellFemale;
@end

@implementation NDPersonalChangeGender

- (void)setupUI{
    [self initWithCells];
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)rightBtnClicked:(UIButton *)btn{
    
}

- (void)initWithCells{
    [self.cells addObjectsFromArray:@[self.cellMale,self.cellFemale]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    // Do any additional setup after loading the view from its nib.
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