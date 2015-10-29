//
//  NSObject+Protalcals.m
//  newdoc
//
//  Created by zzc on 15/10/22.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NSObject+Protalcals.h"

@implementation NSObject (Protalcals)
//获取验证码
- (void)startSendVerifyCodeWithPhoneNumber:(NSString *)phoneNumber success:(void(^)(NSObject *resultDic))success failure:(void(^)(NSDictionary *result,NSError *error))failure{

    NSDictionary *param = @{@"mobile":SafeString(phoneNumber),
                            @"f":@"reg"};
    

    [[NDNetManager sharedNetManager] post:@"/Common/1/sms" parameters:param success:^(NSDictionary *result) {
        success(result);
    } failure:^(NSDictionary *result, NSString *errorMessage, NSError *error) {
        failure(result, error);
    }];
}

//登录
- (void)startLoginWithUsername:(NSString *)username andPassword:(NSString *)password success:(void(^)(NSObject *resultDic))success failure:(void(^)(NSDictionary *result,NSError *error))failure{
    NSDictionary *param = @{@"newdocid":SafeString(username),
                            @"passwd":SafeString(password)};
    
    
    [[NDNetManager sharedNetManager] post:@"Common/1/login?" parameters:param success:^(NSDictionary *result) {
        success(result);
    } failure:^(NSDictionary *result, NSString *errorMessage, NSError *error) {
        failure(result, error);
    }];
}

//得到附近的诊室
- (void)startGetRoomListWithLocation:(CLLocationCoordinate2D)coordinate andCityName:(NSString *)city andAreaName:(NSString *)area success:(void(^)(NSArray *rooms))success failure:(void(^)(NSDictionary *result,NSError *error))failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    if(coordinate.longitude && coordinate.latitude){
        [param setObject:SafeNumber([NSNumber numberWithDouble:coordinate.longitude]) forKey:@"longitude"];
        [param setObject:SafeNumber([NSNumber numberWithDouble:coordinate.latitude]) forKey:@"latitude"];
    }else if(area){
        [param setObject:SafeString(city) forKey:@"area"];
    }else if (city){
        [param setObject:SafeString(city) forKey:@"city"];
    }
    
    [[NDNetManager sharedNetManager] get:@"/app/1/Rooms?action=near" parameters:param success:^(NSDictionary *result) {
        NSMutableArray *rooms = [NSMutableArray array];
        
        if([[result allKeys] containsObject:@"data"]){
            if([[result[@"data"] allKeys] containsObject:@"subs"]){
                NSArray *dics = result[@"data"][@"subs"];
                for(id obj in dics){
                    NDRoom *room = [NDRoom objectWithKeyValues:obj];
                    [rooms addObject:room];
                }
            }
        }
        
        success(rooms);

    } failure:^(NSDictionary *result, NSString *errorMessage, NSError *error) {
        failure(result, error);
    }];
}

//得到省份列表
- (void)startGetProvinceListAndSuccess:(void(^)(NSArray *provinces))success failure:(void(^)(NSDictionary *result,NSError *error))failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [[NDNetManager sharedNetManager] get:@"/app/1/loctree?action=index" parameters:param success:^(NSDictionary *result) {
        NSMutableArray *provinces = [NSMutableArray array];
        
        if([[result allKeys] containsObject:@"data"]){
            if([[result[@"data"] allKeys] containsObject:@"subs"]){
                NSArray *dics = result[@"data"][@"subs"];
                for(id obj in dics){
                    NSString *provinceName = obj;
                    [provinces addObject:provinceName];
                }
            }
        }
        
        success(provinces);
        
    } failure:^(NSDictionary *result, NSString *errorMessage, NSError *error) {
        failure(result, error);
    }];

}

//得到城市列表
- (void)startGetCityListWithProvince:(NSString *)provinceName success:(void(^)(NSArray *citys))success failure:(void(^)(NSDictionary *result,NSError *error))failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [param setObject:SafeString(provinceName) forKey:@"province"];
    
    [[NDNetManager sharedNetManager] get:@"/app/1/loctree?action=index" parameters:param success:^(NSDictionary *result) {
        NSMutableArray *provinces = [NSMutableArray array];
        
        if([[result allKeys] containsObject:@"data"]){
            if([[result[@"data"] allKeys] containsObject:@"subs"]){
                NSArray *dics = result[@"data"][@"subs"];
                for(id obj in dics){
                    NSString *provinceName = obj;
                    [provinces addObject:provinceName];
                }
            }
        }
        
        success(provinces);
        
    } failure:^(NSDictionary *result, NSString *errorMessage, NSError *error) {
        failure(result, error);
    }];

}

//得到区县列表
- (void)startGetCountyListWithCity:(NSString *)cityName success:(void(^)(NSArray *countys))success failure:(void(^)(NSDictionary *result,NSError *error))failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [param setObject:SafeString(cityName) forKey:@"city"];
    
    [[NDNetManager sharedNetManager] get:@"/app/1/loctree?action=index" parameters:param success:^(NSDictionary *result) {
        NSMutableArray *provinces = [NSMutableArray array];
        
        if([[result allKeys] containsObject:@"data"]){
            if([[result[@"data"] allKeys] containsObject:@"subs"]){
                NSArray *dics = result[@"data"][@"subs"];
                for(id obj in dics){
                    NSString *provinceName = obj;
                    [provinces addObject:provinceName];
                }
            }
        }
        
        success(provinces);
        
    } failure:^(NSDictionary *result, NSString *errorMessage, NSError *error) {
        failure(result, error);
    }];
}

//得到诊室详情
- (void)startGetSubroomListWithRoomId:(NSString *)roomId success:(void(^)(NDRoom *room))success failure:(void(^)(NSDictionary *result,NSError *error))failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [[NDNetManager sharedNetManager] get:[NSString stringWithFormat:@"/app/1/Rooms/%@?action=index",SafeString(roomId)] parameters:param success:^(NSDictionary *result) {
//        NSMutableArray *subRooms = [NSMutableArray array];
        
        if([[result allKeys] containsObject:@"data"]){
            if([[result[@"data"] allKeys] containsObject:@"catalogs"]){
                NDRoom *room = [NDRoom objectWithKeyValues:result[@"data"]];
                
                success(room);
            }

//            if([[result[@"data"] allKeys] containsObject:@"catalogs"]){
//                NSArray *dics = result[@"data"][@"catalogs"];
//
//                for(id obj in dics){
//                    NDSubroom *subroom = [NDSubroom objectWithKeyValues:obj];
//                    [subRooms addObject:subroom];
//                }
//            }
        }
        
    } failure:^(NSDictionary *result, NSString *errorMessage, NSError *error) {
        failure(result, error);
    }];
}
@end
