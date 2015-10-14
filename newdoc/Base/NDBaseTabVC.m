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
#import "NDPersonalVC.h"
#import "UMCommunity.h"

@interface NDBaseTabVC ()

@end

@implementation NDBaseTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)setup{
    
    NDRoomVC *roomVC = [NDRoomVC new];
    NDPersonalVC *personalVC = [NDPersonalVC new];
    UINavigationController *communityVC = [UMCommunity getFeedsModalViewController];
    
    NDBaseNavVC *roomNav = [NDBaseNavVC new];
    roomNav.viewControllers = @[roomVC];
    
    NDBaseNavVC *personalNav = [NDBaseNavVC new];
    personalNav.viewControllers = @[personalVC];
    
    
    [self setViewControllers:@[roomNav,personalNav,communityVC]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
