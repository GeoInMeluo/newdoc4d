//
//  NDPersonalChangeAccountVC.h
//  newdoc
//
//  Created by zzc on 15/10/19.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDBaseTableVC.h"
typedef void(^Callback)(NSString* name);

@interface NDPersonalChangeAccountVC : NDBaseTableVC
@property (nonatomic, copy) Callback nameCallBack;
@end
