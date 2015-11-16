//
//  NSObject+Util.m
//  newdoc
//
//  Created by zzc on 15/11/7.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NSObject+Util.h"
#import "NDLoginVC.h"

@implementation NSObject (Util)
- (BOOL)checkLoginWithNav:(UINavigationController *)nav{
    if(![NDCoreSession coreSession].user.name.length != 0){
        [nav pushViewController:[NDLoginVC new] animated:YES];
        return NO;
    }
    return YES;
}
@end
