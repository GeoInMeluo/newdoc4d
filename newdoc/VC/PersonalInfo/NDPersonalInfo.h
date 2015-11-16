//
//  NDPersonalInfo.h
//  newdoc
//
//  Created by zzc on 15/10/19.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDBaseTableVC.h"

typedef void(^VcCallBack)(NSString *str);

@interface NDPersonalInfo : NDBaseTableVC
@property (nonatomic, copy) VcCallBack callBack;
@end
