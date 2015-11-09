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
#import "UUPhoto-Import.h"

@interface NDPersonalInfo ()<UUPhotoActionSheetDelegate>
@property (strong, nonatomic) IBOutlet FormCell *cellHeadImg;
@property (strong, nonatomic) IBOutlet FormCell *cellAcount;

@property (strong, nonatomic) IBOutlet FormCell *cellGender;
@property (strong, nonatomic) IBOutlet FormCell *cellApprove;
@property (strong, nonatomic) IBOutlet FormCell *cellChangePwd;

@property (nonatomic, weak) UUPhotoActionSheet *photoActionSheet;
@property (weak, nonatomic) IBOutlet UIButton *btnHeadImage;

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblSex;

@property (nonatomic, strong) NDUser *tempUser;

@end

@implementation NDPersonalInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupUI{
    
    NDUser *user = [NDCoreSession coreSession].user;
    self.tempUser = user;
    
    
    WEAK_SELF;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage *tempImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NDCoreSession coreSession].user.picture_url]]];
        
        tempImage = [tempImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.btnHeadImage  setImage:tempImage forState:UIControlStateNormal];
        });
        
    });
    
    
//    UIImage *tempImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:user.picture_url]]];
//    tempImage = [tempImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [self.btnHeadImage setImage:tempImage forState:UIControlStateNormal];
    
    self.lblName.text = user.name;
    self.lblSex.text = [user.sex isEqualToString:@"0"] ? @"男":@"女" ;
    
    [self initWithCells];
}

- (void)initWithCells{
    WEAK_SELF;
    
    [self appendSection:@[self.cellHeadImg,self.cellAcount,self.cellGender,self.cellApprove,self.cellChangePwd] withHeader:nil];
    
    self.cellAcount.callback = ^(FormCell *cell, NSIndexPath *indexPath){
        CreateVC(NDPersonalChangeAccountVC);
        vc.nameCallBack = ^(NSString *name){
            weakself.lblName.text = name;
            weakself.tempUser.name = name;
        };
        PushVCWeak(vc);
    };
    
    self.cellGender.callback = ^(FormCell *cell, NSIndexPath *indexPath){
        CreateVC(NDPersonalChangeGender);
        vc.genderCallBack = ^(NSString *gender){
            weakself.lblSex.text = gender;
            weakself.tempUser.sex = [gender isEqualToString:@"男"] ? @"0" : @"1";
        };
        PushVCWeak(vc);
    };

    self.cellApprove.callback = ^(FormCell *cell, NSIndexPath *indexPath){
        CreateVC(NDPersonalApproveVC);
        vc.vcCallback = ^(NSString* name, NSString *idCardNumber){

        };
        PushVCWeak(vc);
    };
    
    self.cellChangePwd.callback = ^(FormCell *cell, NSIndexPath *indexPath){
        CreateVC(NDPersonalChangePwd);
        PushVCWeak(vc);
    };
    
    UUPhotoActionSheet *photoActionSheet = [[UUPhotoActionSheet alloc] initWithMaxSelected:1 weakSuper:self];
    self.photoActionSheet = photoActionSheet;
    
    self.photoActionSheet.delegate = self;
    [self.navigationController.view addSubview:self.photoActionSheet];
}

- (IBAction)btnHeaderClicked:(id)sender {
    [self.photoActionSheet showAnimation];
}

- (void)actionSheetDidFinished:(NSArray *)obj{
    todo();
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
