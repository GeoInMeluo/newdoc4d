//
//  NCNetManager.h
//  newdoc
//
//  Created by zzc on 15/10/9.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface NCNetManager : AFHTTPSessionManager

+ (instancetype)sharedNetManager;

- (NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

- (NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

- (NSURLSessionDataTask *)DELETE:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

- (NSURLSessionDataTask *)PUT:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;
@end
