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
#import "NDBaseNavVC.h"
#import "NDPersonalGoodatVC.h"
#import "NDPersonalIntroVC.h"

@interface NDPersonalInfo ()<UUPhotoActionSheetDelegate>
@property (strong, nonatomic) IBOutlet FormCell *cellHeadImg;
@property (strong, nonatomic) IBOutlet FormCell *cellAcount;

@property (strong, nonatomic) IBOutlet FormCell *cellGender;
@property (strong, nonatomic) IBOutlet FormCell *cellApprove;
@property (strong, nonatomic) IBOutlet FormCell *cellChangePwd;
@property (strong, nonatomic) IBOutlet FormCell *cellGoodat;
@property (strong, nonatomic) IBOutlet FormCell *cellIntro;



@property (nonatomic, weak) UUPhotoActionSheet *photoActionSheet;
@property (weak, nonatomic) IBOutlet UIButton *btnHeadImage;

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblSex;
@property (weak, nonatomic) IBOutlet UILabel *lblIntro;

@property (nonatomic, strong) NDUser *tempUser;
@end

@implementation NDPersonalInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人中心";
    
    [self setupUI];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)setupUI{
    WEAK_SELF;
    
    [self initWithCells];
    
    [self startGetUserInfoMoreAndSuccess:^(NDDocInfo *docInfo) {
        
        [self.btnHeadImage sd_setImageWithURL:[NSURL URLWithString:docInfo.picture_url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_placeHolder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
            [weakself.btnHeadImage setImage:image forState:UIControlStateNormal];
        }];
        
        
        //    UIImage *tempImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:user.picture_url]]];
        //    tempImage = [tempImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //    [self.btnHeadImage setImage:tempImage forState:UIControlStateNormal];
        
        self.lblName.text = docInfo.name;
        self.lblSex.text = [[NDCoreSession coreSession].user.sex isEqualToString:@"0"] ? @"男":@"女" ;
        self.lblIntro.text = docInfo.detail;
        [NDCoreSession coreSession].user.goodat = docInfo.goodat;
        [NDCoreSession coreSession].user.detail = docInfo.detail;
        [NDCoreSession coreSession].user.picture_url = docInfo.picture_url;
        [NDCoreSession coreSession].user.name = docInfo.name;
    } failure:^(NSString *error_message) {
        
    }];
    
    
//    NDUser *user = [NDCoreSession coreSession].user;
//    self.tempUser = user;

    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];

}

- (void)rightBtnClicked:(UIButton *)btn{
    WEAK_SELF;
    
    [NDCoreSession coreSession].user.name = self.lblName.text;
    [NDCoreSession coreSession].user.sex = [self.lblSex.text isEqualToString: @"男"]? @"0":@"1";
    
    
    [self startEditUserInfo:[NDCoreSession coreSession].user success:^() {
        NSString *tempPath =  NSTemporaryDirectory();
        
        NSString *filePath =  [tempPath stringByAppendingPathComponent:@"user.data"];
        
        [NSKeyedArchiver archiveRootObject:[NDCoreSession coreSession].user toFile:filePath];
    } failure:^(NSString *error_message) {
        
    }];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initWithCells{
    
    WEAK_SELF;
    
   
    if([[NDCoreSession coreSession].isWxLogin isEqualToString:@"1"]){
        [self appendSection:@[self.cellHeadImg,self.cellAcount,self.cellGender,self.cellGoodat,self.cellApprove,self.cellIntro] withHeader:nil];
    }else{
        [self appendSection:@[self.cellHeadImg,self.cellAcount,self.cellGender,self.cellGoodat,self.cellApprove,self.cellChangePwd,self.cellIntro] withHeader:nil];
    }

    
    
    self.cellAcount.callback = ^(FormCell *cell, NSIndexPath *indexPath){
        CreateVC(NDPersonalChangeAccountVC);
        vc.nameCallBack = ^(NSString *name){
            weakself.lblName.text = [NDCoreSession coreSession].user.name;
//            weakself.tempUser.name = name;
        };
        PushVCWeak(vc);
    };
    
//    self.cellGender.callback = ^(FormCell *cell, NSIndexPath *indexPath){
//        CreateVC(NDPersonalChangeGender);
//        vc.genderCallBack = ^(NSString *gender){
//            weakself.lblSex.text = gender;
//            weakself.tempUser.sex = [gender isEqualToString:@"男"] ? @"0" : @"1";
//        };
//        PushVCWeak(vc);
//    };

    if([NDCoreSession coreSession].user.doctor_status == 1){
        self.cellApprove.callback = ^(FormCell *cell, NSIndexPath *indexPath){
            ShowAlert(@"认证中");
        };
    }else if([NDCoreSession coreSession].user.doctor_status == 2){
        self.cellApprove.callback = ^(FormCell *cell, NSIndexPath *indexPath){
            ShowAlert(@"已认证");
        };
    }else{
        self.cellApprove.callback = ^(FormCell *cell, NSIndexPath *indexPath){
            CreateVC(NDPersonalApproveVC);
            vc.vcCallback = ^(NSString* name, NSString *idCardNumber){
                
            };
            PushVCWeak(vc);
        };
    }
    
    
    
    self.cellChangePwd.callback = ^(FormCell *cell, NSIndexPath *indexPath){
        CreateVC(NDPersonalChangePwd);
        PushVCWeak(vc);
    };
    
    self.cellGoodat.callback = ^(FormCell *cell, NSIndexPath *indexPath){
        CreateVC(NDPersonalGoodatVC);
        vc.goodatCallBack = ^(NSString* goodat){
        };
        PushVCWeak(vc);
    };

    self.cellIntro.callback = ^(FormCell *cell, NSIndexPath *indexPath){
        CreateVC(NDPersonalIntroVC);
        vc.callBack = ^(NSString* intro){
            weakself.lblIntro.text = intro;
        };
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
    WEAK_SELF;
    
    [self startUploadImageWithImages:obj success:^(NSArray *imgUrls) {
        if(imgUrls.count == 0){
            return;
        }
        
        [NDCoreSession coreSession].user.picture_url = imgUrls[0];
        
        NSString *tempPath =  NSTemporaryDirectory();
        
        NSString *filePath =  [tempPath stringByAppendingPathComponent:@"user.data"];
        
        [NSKeyedArchiver archiveRootObject:[NDCoreSession coreSession].user toFile:filePath];
        
        [weakself.btnHeadImage setImage:[obj.lastObject imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        
//        [weakself.btnHeadImage sd_setImageWithURL:[NSURL URLWithString:_imgUrl] forState:UIControlStateNormal];
    } failure:^(NSString *error_message) {
        
    }];
}

@end
