//
//  NCNetManager.m
//  newdoc
//
//  Created by zzc on 15/10/9.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NCNetManager.h"

@implementation NCNetManager

+ (instancetype)sharedNetManager {
    static NCNetManager *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[self alloc] initWithBaseURL:[NSURL URLWithString:@""]];

        NSMutableSet *set = [NSMutableSet setWithSet:instance.responseSerializer.acceptableContentTypes];
        [set addObject:@"text/html"];
        instance.responseSerializer.acceptableContentTypes = set;
        
    });
    return instance;
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    return [super POST:URLString parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            success(task, responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            failure(task, error);
        }];
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    return [super GET:URLString parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task, error);
    }];
}

- (NSURLSessionDataTask *)DELETE:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    return [super DELETE:URLString parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task, error);
    }];
}

- (NSURLSessionDataTask *)PUT:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    return [super PUT:URLString parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task, error);
    }];
}
@end
