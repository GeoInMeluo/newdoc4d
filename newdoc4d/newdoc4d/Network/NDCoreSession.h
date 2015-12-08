//
//  NDCoreSession.h
//  newdoc
//
//  Created by zzc on 15/11/4.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NDUser.h"
#import "NDCookieBox.h"

@interface NDCoreSession : NSObject

@property (nonatomic, strong) NDUser *user;

@property (nonatomic, copy) NSString *openId;

@property (nonatomic, copy) NSString *isWxLogin;

@property (nonatomic, copy) NSString *authKey;

@property (nonatomic, copy) NSString *nduid;

+ (NDCoreSession *)coreSession;

- (void)logout;
//- (BOOL)isLogin;
@end
