//
//  NDCoreSession.h
//  newdoc
//
//  Created by zzc on 15/11/4.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NDUser.h"

@interface NDCoreSession : NSObject

@property (nonatomic, strong) NDUser *user;

@property (nonatomic, copy) NSString *openId;

+ (NDCoreSession *)coreSession;

//- (BOOL)isLogin;
@end
