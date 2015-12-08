//
//  NDPersonalGoodatVC.h
//  newdoc4d
//
//  Created by zzc on 15/11/28.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDBaseVC.h"
typedef void(^Callback)(NSString* name);

@interface NDPersonalGoodatVC : NDBaseVC
@property (nonatomic, copy) Callback goodatCallBack;
@end
