//
//  NCNetManager.m
//  newdoc
//
//  Created by zzc on 15/10/9.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDNetManager.h"

@implementation NDNetManager

+ (instancetype)sharedNetManager {
    static NDNetManager *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[self alloc] initWithBaseURL:[NSURL URLWithString:kHostStr]];

        NSMutableSet *set = [NSMutableSet setWithSet:instance.responseSerializer.acceptableContentTypes];
        [set addObject:@"text/html"];
        instance.responseSerializer.acceptableContentTypes = set;
        
    });
    return instance;
}

- (AFHTTPRequestOperation *)post:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSDictionary *result))success failure:(void (^)(NSDictionary *result, NSString *errorMessage, NSError *error))failure{
    AFHTTPRequestOperation *operation = [self POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *result = responseObject;
        
        if([[result allKeys] containsObject:@"errmsg"]){
            failure(result, result[@"errmsg"], nil);
        }else{
            success(result);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error.userInfo, nil,error);
    }];
    
    return operation;
}

- (AFHTTPRequestOperation *)get:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSDictionary *result))success failure:(void (^)(NSDictionary *result, NSString *errorMessage, NSError *error))failure{
    AFHTTPRequestOperation *operation = [self GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *result = responseObject;
        
        if([[result allKeys] containsObject:@"errmsg"]){
            failure(result, result[@"errmsg"], nil);
        }else{
            success(result);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error.userInfo, nil,error);
    }];
    
    return operation;
}
@end
