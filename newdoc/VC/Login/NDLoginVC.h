//
//  NDLoginVC.h
//  newdoc
//
//  Created by zzc on 15/10/21.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDBaseTableVC.h"
#import "UMComLoginDelegate.h"
#import "WXApi.h"
#import "UMSocialControllerService.h"

@interface NDLoginVC : NDBaseTableVC<WXApiDelegate,UMComLoginDelegate,UMSocialUIDelegate>

@end
