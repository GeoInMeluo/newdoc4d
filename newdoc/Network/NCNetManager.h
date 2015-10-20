//
//  NCNetManager.h
//  newdoc
//
//  Created by zzc on 15/10/9.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "AFNetworking.h"

@interface NCNetManager : AFHTTPRequestOperationManager

+ (instancetype)sharedNetManager;

@end
