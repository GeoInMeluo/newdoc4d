//
//  NDPersonalRegistBindVC.m
//  newdoc
//
//  Created by zzc on 15/11/5.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDPersonalRegistBindVC.h"
#import "NDPersonalCenterHomeVC.h"

@interface NDPersonalRegistBindVC ()

@property (strong, nonatomic) IBOutlet UIView *sectionHeader;

@property (strong, nonatomic) IBOutlet FormCell *cellPhone;
@property (weak, nonatomic) IBOutlet Button *btnBinding;
@property (weak, nonatomic) IBOutlet Button *btnIgnore;

@end

@implementation NDPersonalRegistBindVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupUI];
    
}

- (void)setupUI{
    WEAK_SELF;
    
    [self appendSection:@[self.cellPhone] withHeader:self.sectionHeader];
    
    self.btnBinding.layer.cornerRadius = 5;
    self.btnBinding.layer.masksToBounds = YES;
    self.btnBinding.callback = ^(Button *btn){
    
    };
    
    self.btnIgnore.layer.cornerRadius = 5;
    self.btnIgnore.layer.masksToBounds = YES;
    self.btnIgnore.callback = ^(Button *btn){
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[NDPersonalCenterHomeVC class]]) {
                
                [weakself.navigationController popToViewController:controller animated:YES];
            }
        }
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
