//
//  NCNetManager.h
//  newdoc
//
//  Created by zzc on 15/10/9.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "AFNetworking.h"

@interface NDNetManager : AFHTTPRequestOperationManager

+ (instancetype)sharedNetManager;

- (AFHTTPRequestOperation *)post:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSDictionary *result))success failure:(void (^)(NSDictionary *result, NSString *errorMessage, NSError *error))failure;

- (AFHTTPRequestOperation *)get:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSDictionary *result))success failure:(void (^)(NSDictionary *result, NSString *errorMessage, NSError *error))failure;
@end
