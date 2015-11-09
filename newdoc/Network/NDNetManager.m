//
//  NCNetManager.m
//  newdoc
//
//  Created by zzc on 15/10/9.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDNetManager.h"
#import "NDLoginVC.h"

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

- (AFHTTPRequestOperation *)post:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSDictionary *result))success failure:(void (^)(NSString *error_message))failure{
    AFHTTPRequestOperation *operation = [self POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUD];
        
        FLog(@"%@", responseObject);
        
        NSDictionary *result = responseObject;
        
        if([[result allKeys] containsObject:@"errmsg"]){
            [MBProgressHUD showError:result[@"errmsg"]];
            failure(result[@"errmsg"]);
        }else{
            if([[result allKeys] containsObject:@"retcode"]){
                if([result[@"retcode"] isEqualToString:@"0"]){
                    success(result);
                }else if([result[@"retcode"] isEqualToString:@"1"]){
                    [MBProgressHUD showError:@"GET 参数错误"];
                    failure(@"GET 参数错误");
                }else if([result[@"retcode"] isEqualToString:@"2"]){
                    [MBProgressHUD showError:@"POST参数错误"];
                    failure(@"POST参数错误");
                }else if([result[@"retcode"] isEqualToString:@"5"]){
                    [MBProgressHUD showError:@"空结果"];
                    failure(@"空结果");
                }else if([result[@"retcode"] isEqualToString:@"6"]){
                    [MBProgressHUD showError:@"授权问题"];
                    failure(@"授权问题");
                }else if([result[@"retcode"] isEqualToString:@"7"]){
                    [MBProgressHUD showError:@"列表为空"];
                    failure(@"列表为空");
                }else if([result[@"retcode"] isEqualToString:@"8"]){
                    [MBProgressHUD showError:@"登陆失败"];
                    failure(@"登陆失败");
                }else if([result[@"retcode"] isEqualToString:@"9"]){
                    [MBProgressHUD showError:@"用户未注册"];
                    failure(@"用户未注册");
                }
                else if([result[@"retcode"] isEqualToString:@"10"]){
                    [MBProgressHUD showError:@"用户权限不够"];
                    failure(@"用户权限不够");
                }
            }
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(@"网络请求失败？？？？？？？？？？？？？？？？？");
    }];
    
    return operation;
}

- (AFHTTPRequestOperation *)get:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSDictionary *result))success failure:(void (^)(NSString *error_message))failure{
    AFHTTPRequestOperation *operation = [self GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        WEAK_SELF;
        
        [MBProgressHUD hideHUD];
        
        FLog(@"%@", responseObject);
        
        NSDictionary *result = responseObject;
        
        if([[result allKeys] containsObject:@"errmsg"]){
            [MBProgressHUD showError:result[@"errmsg"]];
            failure(result[@"errmsg"]);
        }else{
            if([[result allKeys] containsObject:@"retcode"]){
                if([result[@"retcode"] isEqualToString:@"0"]){
                    success(result);
                }else if([result[@"retcode"] isEqualToString:@"1"]){
                    [MBProgressHUD showError:@"GET 参数错误"];
                    failure(@"GET 参数错误");
                }else if([result[@"retcode"] isEqualToString:@"2"]){
                    [MBProgressHUD showError:@"POST参数错误"];
                    failure(@"POST参数错误");
                }else if([result[@"retcode"] isEqualToString:@"5"]){
                    [MBProgressHUD showError:@"空结果"];
                    failure(@"空结果");
                }else if([result[@"retcode"] isEqualToString:@"6"]){
                    [MBProgressHUD showError:@"授权问题"];
                    failure(@"授权问题");
                }else if([result[@"retcode"] isEqualToString:@"7"]){
                    [MBProgressHUD showError:@"列表为空"];
                    failure(@"列表为空");
                }else if([result[@"retcode"] isEqualToString:@"8"]){
                    [MBProgressHUD showError:@"登陆失败"];
                    failure(@"登陆失败");
                    
                    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:[NDLoginVC new] animated:YES completion:nil];
                }else if([result[@"retcode"] isEqualToString:@"9"]){
                    
                    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:[NDLoginVC new] animated:YES completion:nil];
                    
                    [MBProgressHUD showError:@"用户未注册"];
                    failure(@"用户未注册");
                }
                else if([result[@"retcode"] isEqualToString:@"10"]){
                    [MBProgressHUD showError:@"用户权限不够"];
                    failure(@"用户权限不够");
                }
                else if([result[@"retcode"] isEqualToString:@"11"]){
                    [MBProgressHUD showError:@"非法请求"];
                    failure(@"非法请求");
                }
                else if([result[@"retcode"] isEqualToString:@"12"]){
                    [MBProgressHUD showError:@"请求失败"];
                    failure(@"请求失败");
                }
            }
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(@"网络请求失败？？？？？？？？？？？？？？？？？");
    }];
    
    return operation;
}
@end
