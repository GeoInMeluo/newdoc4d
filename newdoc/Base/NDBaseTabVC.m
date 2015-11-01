//
//  NCBaseTabVC.m
//  newdoc
//
//  Created by zzc on 15/10/10.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDBaseTabVC.h"
#import "NDBaseNavVC.h"
#import "NDRoomVC.h"
#import "NDPersonalCenterHomeVC.h"
#import "UMCommunity.h"

@interface NDBaseTabVC ()

@end

@implementation NDBaseTabVC



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)setup{
    
//    self.hidesBottomBarWhenPushed = YES;
    
    NDRoomVC *roomVC = [NDRoomVC new];
    NDPersonalCenterHomeVC *personalVC = [NDPersonalCenterHomeVC new];
    UIViewController *communityVC = [UMCommunity getFeedsViewController];

    
    [self addOneChlildVc:communityVC title:@"社区交流" imageName:@"community" selectedImageName:@"community_select"];
    
    [self addOneChlildVc:roomVC title:@"新医诊室" imageName:@"room" selectedImageName:@"room_select"];
    
    [self addOneChlildVc:personalVC title:@"个人中心" imageName:@"personal" selectedImageName:@"personal_select"];
    
    self.selectedIndex = 1;

}

- (void)addOneChlildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    childVc.title = title;
    
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[UITextAttributeTextColor] = [UIColor blackColor];
    textAttrs[UITextAttributeFont] = [UIFont systemFontOfSize:10];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = selectedImage;
    
    NDBaseNavVC *nav = [[NDBaseNavVC alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
