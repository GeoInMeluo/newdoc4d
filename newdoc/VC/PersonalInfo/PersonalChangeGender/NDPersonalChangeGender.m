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

@property (weak, nonatomic) IBOutlet UIImageView *maleRight;
@property (weak, nonatomic) IBOutlet UIImageView *femaleRight;

@end

@implementation NDPersonalChangeGender

- (void)setupUI{
    self.title = @"性别";
    
    [self initWithCells];
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)rightBtnClicked:(UIButton *)btn{
    if(self.maleRight.hidden){
        self.genderCallBack(@"女");
    }else{
        self.genderCallBack(@"男");
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initWithCells{
    WEAK_SELF;
    
    [self appendSection:@[self.cellMale,self.cellFemale] withHeader:nil];
    
    self.cellMale.callback = ^(FormCell* sender,NSIndexPath * indexPath){
        weakself.maleRight.hidden = NO;
        weakself.femaleRight.hidden = YES;
    };
    
    self.cellFemale.callback = ^(FormCell* sender,NSIndexPath * indexPath){
        weakself.maleRight.hidden = YES;
        weakself.femaleRight.hidden = NO;
    };
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
