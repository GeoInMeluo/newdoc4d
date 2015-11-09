//
//  NDCoreSession.m
//  newdoc
//
//  Created by zzc on 15/11/4.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDCoreSession.h"
#import "NDLoginVC.h"

static NDCoreSession * sharedInstance;

@implementation NDCoreSession
+(NDCoreSession *)coreSession
{
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [super allocWithZone:zone];
        
        [sharedInstance setup];
    });
    
    return sharedInstance;
}

- (void)setup{
    NSString *tempPath =  NSTemporaryDirectory();
    
    NSString *filePath =  [tempPath stringByAppendingPathComponent:@"user.data"];
    NDUser *user = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    if(user == nil){
        _user = [NDUser new];
    }else{
        _user = user;
    }
    
    self.openId = [[NSUserDefaults standardUserDefaults] objectForKey:@"openid"];

}

- (instancetype)copyWithZone:(NSZone *)zone
{
    return sharedInstance;
}

//- (BOOL)isLogin{
////    return self.user.name != nil;
//    if(self.user.name != nil){
//        return YES;
//    }else{
//        FLog(@"%@", [self getCurrentRootViewController].navigationController);
//        
//        [[self getCurrentRootViewController].navigationController pushViewController:[NDLoginVC new] animated:YES];
//        
//        return NO;
//    }
//}
@end
