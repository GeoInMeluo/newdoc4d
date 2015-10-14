//
//  AppDelegate.h
//  newdoc
//
//  Created by zzc on 15/10/9.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI/BMapKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) BMKMapManager* mapManager;

@end

