//
//  NDPersonalIntroVC.h
//  newdoc4d
//
//  Created by zzc on 15/11/28.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDBaseVC.h"

typedef void(^IntroCallBack)(NSString* intro);

@interface NDPersonalIntroVC : NDBaseVC
@property (nonatomic, copy) IntroCallBack callBack;
@end
