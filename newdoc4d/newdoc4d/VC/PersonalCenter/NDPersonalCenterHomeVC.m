//
//  NDPersonalCenterHomeVC.m
//  newdoc
//
//  Created by zzc on 15/10/19.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDPersonalCenterHomeVC.h"
#import "NDPersonalInfo.h"
#import "NDLoginVC.h"
#import "NDSettingTableViewController.h"
#import "NDPersonalCardVC.h"
#import "NDPersonalRoomVC.h"
#import "NDRoomUserComment.h"

@interface NDPersonalCenterHomeVC ()<UITableViewDataSource,UITabBarDelegate>
@property (strong, nonatomic) IBOutlet FormCell *cellInfomation;
@property (strong, nonatomic) IBOutlet FormCell *cellCard;
@property (strong, nonatomic) IBOutlet FormCell *cellComment;
@property (strong, nonatomic) IBOutlet FormCell *cellRoom;
@property (strong, nonatomic) IBOutlet FormCell *cellSetting;




@property (weak, nonatomic) IBOutlet UIButton *headImg;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIView *vAccountAndPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblAccount;
@property (weak, nonatomic) IBOutlet UILabel *lblPhoneNumber;
@end

@implementation NDPersonalCenterHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI{
    [self initCells];
    
    self.headImg.layer.cornerRadius = self.headImg.width * 0.5;
    self.headImg.layer.masksToBounds = YES;
    self.headImg.layer.borderColor = [UIColor whiteColor].CGColor;
    self.headImg.layer.borderWidth = 2;
    
    
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self startGetUserInfoMoreAndSuccess:^(NDDocInfo *docInfo) {
        if([NDCoreSession coreSession].nduid.length != 0 || [NDCoreSession coreSession].openId.length != 0){
            self.vAccountAndPhone.hidden = NO;
            
            WEAK_SELF;
            
            //        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //
            //            UIImage *tempImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NDCoreSession coreSession].user.picture_url]]];
            //
            //            tempImage = [tempImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            //
            //            dispatch_async(dispatch_get_main_queue(), ^{
            //                [weakself.headImg setImage:tempImage forState:UIControlStateNormal];
            //            });
            //
            //        });
            self.lblAccount.text = docInfo.name;
            self.lblPhoneNumber.text = [NDCoreSession coreSession].user.mobile;
            self.btnLogin.hidden = YES;
            
            if(docInfo.picture_url.length == 0){
                [self.headImg setImage:[UIImage imageWithName:@"icon_placeHolder"] forState:UIControlStateNormal];
                
                return;
            }
            
            FLog(@"%@", [NDCoreSession coreSession].user.picture_url);
            
            //        [self.headImg sd_setImageWithURL:[NSURL URLWithString:[NDCoreSession coreSession].user.picture_url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_placeHolder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            //
            //            __block UIImage *tempImage = image;
            //
            //            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.03 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //                tempImage = [tempImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            //
            //                [weakself.headImg setImage:tempImage forState:UIControlStateNormal];
            //            });
            //
            //
            //        }];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                UIImage *image = [[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:docInfo.picture_url]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [weakself.headImg setImage:image forState:UIControlStateNormal];
                });
            });
            
            
            
            
            //        [self.headImg sd_setImageWithURL:[NSURL URLWithString:[NDCoreSession coreSession].user.picture_url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_placeHolder"]];
            
        }else{
            [self.headImg setImage:[UIImage imageWithName:@"icon_placeHolder"] forState:UIControlStateNormal];
            self.vAccountAndPhone.hidden = YES;
            self.btnLogin.hidden = NO;
        }
        
    } failure:^(NSString *error_message) {
        
    }];
}

- (void)initCells{
    WEAK_SELF;
    
    
    [self appendSection:@[self.cellInfomation,self.cellCard,self.cellComment,self.cellRoom,self.cellSetting] withHeader:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.001, 0.001)]];
 
    self.cellInfomation.callback = ^(FormCell *cell, NSIndexPath *indexPath){
        
        if([weakself checkLoginWithNav:weakself.navigationController]){
            CreateVC(NDPersonalInfo);
            vc.callBack = ^(NSString *imgUrl){
                FLog(@"%@", imgUrl);
                
                [weakself.headImg sd_setImageWithURL:[NSURL URLWithString:[NDCoreSession coreSession].user.picture_url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_placeHolder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    
                    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                    
                    [weakself.headImg setImage:image forState:UIControlStateNormal];
                }];
            };
            PushVCWeak(vc);
        }
    
    };
    
    self.cellCard.callback = ^(FormCell *cell, NSIndexPath *indexPath){
//        if([weakself checkLoginWithNav:weakself.navigationController]){
//            ShowVCWeak(NDSettingTableViewController);
//        }
        ShowVCWeak(NDPersonalCardVC);
    };
    
    self.cellComment.callback = ^(FormCell *cell, NSIndexPath *indexPath){
        ShowVCWeak(NDRoomUserComment);
    };
    
    self.cellRoom.callback = ^(FormCell *cell, NSIndexPath *indexPath){
        ShowVCWeak(NDPersonalRoomVC);
    };
    
    self.cellSetting.callback = ^(FormCell *cell, NSIndexPath *indexPath){
        if([weakself checkLoginWithNav:weakself.navigationController]){
            ShowVCWeak(NDSettingTableViewController);
        }
    };
    
}

- (IBAction)btnLoginClick:(id)sender {
    ShowVC(NDLoginVC);
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
