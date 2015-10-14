//
//  UMComSession.h
//  UMCommunity
//
//  Created by Gavin Ye on 9/11/14.
//  Copyright (c) 2014 Umeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMComUser.h"
#import "UMComEditViewModel.h"

#define NSUserDefaultAppKey @"UMCommunityAppKey"
#define NSUserDefaultLoginKey @"UMCommunityLoginUid"
#define NSUserDefaultLoginToken @"UMCommunityLoginToken"
#define NSUserDefaultMaxFeedLength @"UMCommunityMaxFeedLength"

#define kNSAliasKey @"UM_COMMUNITY"

#define kUnreadSystemNoticeCountKey @"notice"
#define kUnreadTotalNoticeCountKey @"total"
#define kUnreadCommentNoticeCountKey @"comment"
#define kUnreadAtMeNoticeCountKey @"at"
#define kUnreadLikeNoticeCountKey @"like"

@class UMComUserAccount;
@class UMComFeedEntity, UMComUnReadNoticeModel;

@interface UMComSession : NSObject

@property (nonatomic, copy) NSString *token;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *appkey;

@property (nonatomic, strong) NSDictionary *baseHeader;//含当前uid

@property (nonatomic, strong) UMComUser *loginUser;

@property (nonatomic, strong) UMComUserAccount *currentUserAccount;

@property (nonatomic, strong) UIViewController *beforeLoginViewController;  //登录前的viewController

@property (nonatomic, assign) BOOL isShowTopicName;

@property (nonatomic, strong) UMComFeedEntity *draftFeed;

@property (nonatomic, strong) UMComEditViewModel *editViewModel;

@property (nonatomic, strong) NSError *loginError;          //登录用户名错误

@property (nonatomic, strong) UMComUnReadNoticeModel *unReadNoticeModel;

@property (nonatomic, strong) NSNumber * maxFeedLength;

- (NSMutableDictionary *)basePathDictionary;

+ (UMComSession *)sharedInstance;

//用户注销
- (void)userLogout;

- (void)saveLoginObject:(UMComUser *)loginUser;

@end
