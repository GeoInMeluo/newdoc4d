//
//  NCBaseTabVC.m
//  newdoc
//
//  Created by zzc on 15/10/10.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDBaseTabVC.h"
#import "NDRoomVC.h"
#import "NDPersonalCenterHomeVC.h"
#import "UMCommunity.h"
#import "NDBaseNavVC.h"

@interface NDBaseTabVC ()


@end

@implementation NDBaseTabVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)setup{
    
    [super viewDidLoad];
    
    
    self.tabBar.translucent = NO;
    
//    self.hidesBottomBarWhenPushed = YES;
    
    NDRoomVC *roomVC = [NDRoomVC new];
    roomVC.hiddenLeft = YES;
    NDPersonalCenterHomeVC *personalVC = [NDPersonalCenterHomeVC new];
    personalVC.hiddenLeft = YES;
    UIViewController *communityVC = [UMCommunity getFeedsViewController];
    
    [self addOneChlildVc:communityVC title:@"社区交流" imageName:@"room" selectedImageName:@"room_select"];
    
    [self addOneChlildVc:roomVC title:@"新医诊室" imageName:@"community" selectedImageName:@"community_select"];
    
    [self addOneChlildVc:personalVC title:@"个人中心" imageName:@"personal" selectedImageName:@"personal_select"];
    
    self.selectedIndex = 1;

    
    
}



- (void)addOneChlildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    childVc.title = title;
    
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    textAttrs[UITextAttributeTextColor] = [UIColor lightGrayColor];
    
    [childVc.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0f],
                                                   NSForegroundColorAttributeName : [UIColor colorWithHex:@"#00aaff"]} forState:UIControlStateSelected];
    [childVc.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0f],
                                                 NSForegroundColorAttributeName : [UIColor lightGrayColor]} forState:UIControlStateNormal];
//    
//    textAttrs[UITextAttributeFont] = [UIFont systemFontOfSize:10];
//    textAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    textAttrs[NSBackgroundColorAttributeName] = [UIColor blueColor];
//    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
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
