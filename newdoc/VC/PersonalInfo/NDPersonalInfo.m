//
//  NDPersonalInfo.m
//  newdoc
//
//  Created by zzc on 15/10/19.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDPersonalInfo.h"
#import "NDPersonalChangeAccountVC.h"
#import "NDPersonalChangeGender.h"
#import "NDPersonalApproveVC.h"
#import "NDPersonalChangePwd.h"

@interface NDPersonalInfo ()
@property (strong, nonatomic) IBOutlet FormCell *cellHeadImg;
@property (strong, nonatomic) IBOutlet FormCell *cellAcount;

@property (strong, nonatomic) IBOutlet FormCell *cellGender;
@property (strong, nonatomic) IBOutlet FormCell *cellApprove;
@property (strong, nonatomic) IBOutlet FormCell *cellChangePwd;

@end

@implementation NDPersonalInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupUI{
    [self initWithCells];
}

- (void)initWithCells{
    WEAK_SELF;
    
    [self.cells addObjectsFromArray:@[self.cellHeadImg,self.cellAcount,self.cellGender,self.cellApprove,self.cellChangePwd]];
    
    self.cellAcount.callback = ^(FormCell *cell, NSIndexPath *indexPath){
        CreateVC(NDPersonalChangeAccountVC);
        PushVCWeak(vc);
    };
    
    self.cellGender.callback = ^(FormCell *cell, NSIndexPath *indexPath){
        CreateVC(NDPersonalChangeGender);
        PushVCWeak(vc);
    };

    self.cellApprove.callback = ^(FormCell *cell, NSIndexPath *indexPath){
        CreateVC(NDPersonalApproveVC);
        PushVCWeak(vc);
    };
    
    self.cellChangePwd.callback = ^(FormCell *cell, NSIndexPath *indexPath){
        CreateVC(NDPersonalChangePwd);
        PushVCWeak(vc);
    };
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
