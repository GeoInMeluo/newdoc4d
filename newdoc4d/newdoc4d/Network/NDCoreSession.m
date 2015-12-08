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
    self.authKey = [[NSUserDefaults standardUserDefaults] objectForKey:@"authkey"];
    self.isWxLogin = [[NSUserDefaults standardUserDefaults] objectForKey:@"iswxlogin"];
    self.nduid = [[NSUserDefaults standardUserDefaults] objectForKey:@"nduid"];
    
}

- (instancetype)copyWithZone:(NSZone *)zone
{
    return sharedInstance;
}

- (void)logout{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"openid"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"authkey"];
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"iswxlogin"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"nduid"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"pwd"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"username"];
    
    NSString *tempPath =  NSTemporaryDirectory();
    
    NSString *filePath =  [tempPath stringByAppendingPathComponent:@"user.data"];
    
    NDUser *user = [NDUser new];
    
    [NSKeyedArchiver archiveRootObject:user toFile:filePath];
    
    [NDCoreSession coreSession].user = nil;
    [NDCoreSession coreSession].openId = nil;
    [NDCoreSession coreSession].authKey = nil;
    [NDCoreSession coreSession].nduid = nil;
    
    //清空cookie
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    
    for(int i= 0; i < cookies.count ; i++){
        NSHTTPCookie *cookie = cookies[i];
        
        FLog(@"%@",cookie);
        
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
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
