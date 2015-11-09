//
//  NDPersonalApproveVC.h
//  newdoc
//
//  Created by zzc on 15/10/20.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDBaseTableVC.h"
typedef void(^vcCallback)(NSString* name, NSString *idCardNumber);
@interface NDPersonalApproveVC : NDBaseTableVC
@property (nonatomic, copy) vcCallback vcCallback;
@end
