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
    }
    else if(area){
        [param setObject:SafeString(city) forKey:@"area"];
    }
    else if (city){
        [param setObject:SafeString(city) forKey:@"city"];
    }
    
    [param setObject:SafeString(@"5000") forKey:@"scope"];
    
    
    
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
- (void)startGetRoomWithRoomId:(NSString *)roomId success:(void(^)(NDRoom *room))success failure:(void(^)(NSDictionary *result,NSError *error))failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [[NDNetManager sharedNetManager] get:[NSString stringWithFormat:@"/app/1/Rooms/%@?action=index",SafeString(roomId)] parameters:param success:^(NSDictionary *result) {
    
//        NSMutableArray *subRooms = [NSMutableArray array];
        
        FLog(@"%@", result);
        
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

//关注医生
- (void)startAttentionDoctorWithDocId:(NSString *)docId success:(void(^)())success failure:(void(^)(NSDictionary *result,NSError *error))failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [param setObject:SafeString(docId) forKey:@"doctorid"];
    
    [[NDNetManager sharedNetManager] post:@"app/1/Focus" parameters:param success:^(NSDictionary *result) {
        success();
        
    } failure:^(NSDictionary *result, NSString *errorMessage, NSError *error) {
        failure(result, error);
    }];

}

//取消关注医生
- (void)startCancelAttentionDoctorWithDocId:(NSString *)docId success:(void(^)())success failure:(void(^)(NSDictionary *result,NSError *error))failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [param setObject:SafeString(docId) forKey:@"doctorid"];
    [param setObject:@"del" forKey:@"action"];
    
    [[NDNetManager sharedNetManager] post:@"app/1/Focus" parameters:param success:^(NSDictionary *result) {
        success();
        
    } failure:^(NSDictionary *result, NSString *errorMessage, NSError *error) {
        failure(result, error);
    }];
}

//得到医生简介
- (void)startGetDoctorIntroWithDocId:(NSString *)docId success:(void(^)( NDDoctorIntro *intro))success failure:(void(^)(NSDictionary *result,NSError *error))failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [[NDNetManager sharedNetManager] get:[NSString stringWithFormat:@"/app/1/Doctors/%@?action=intro",SafeString(docId)] parameters:param success:^(NSDictionary *result) {
        //        NSMutableArray *subRooms = [NSMutableArray array];
        
        FLog(@"%@", result);
        
        if([[result allKeys] containsObject:@"data"]){
            NDDoctorIntro *intro = [NDDoctorIntro objectWithKeyValues:result[@"data"]];
            success(intro);
        }
        
    } failure:^(NSDictionary *result, NSString *errorMessage, NSError *error) {
        failure(result, error);
    }];

}


//得到医生的所有评论
- (void)startGetDoctorCommentsWithDocId:(NSString *)docId success:(void(^)( NSArray *docComments))success failure:(void(^)(NSDictionary *result,NSError *error))failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [[NDNetManager sharedNetManager] get:[NSString stringWithFormat:@"/app/1/Doctors/%@?action=comments",SafeString(docId)] parameters:param success:^(NSDictionary *result) {
        NSMutableArray *comments = [NSMutableArray array];
        
        if([[result allKeys] containsObject:@"data"]){
            if([[result[@"data"] allKeys] containsObject:@"subs"]){
                NSArray *dics = result[@"data"][@"subs"];
                for(id obj in dics){
                    NDDoctorComment *comment = [NDDoctorComment objectWithKeyValues:obj];
                    [comments addObject:comment];
                }
            }
        }
        
        success(comments);
        
    } failure:^(NSDictionary *result, NSString *errorMessage, NSError *error) {
        failure(result, error);
    }];

}

//得到医生详情(预约内使用的医生数据模型)
- (void)startGetDoctorDetailWithDocId:(NSString *)docId andRoomId:(NSString *)roomId success:(void(^)( NDDoctorMorePreserveWindow *doctorMorePreserveWindow))success failure:(void(^)(NSDictionary *result,NSError *error))failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [param setObject:SafeString(roomId) forKey:@"roomid"];
    
    [[NDNetManager sharedNetManager] get:[NSString stringWithFormat:@"/app/1/Doctors/%@?action=index",SafeString(docId)] parameters:param success:^(NSDictionary *result) {
        
        FLog(@"%@", result);
        
        if([[result allKeys] containsObject:@"data"]){
            NDDoctorMorePreserveWindow *doctor =[NDDoctorMorePreserveWindow objectWithKeyValues:result[@"data"]];
            
            success(doctor);
        }
        
        
        
    } failure:^(NSDictionary *result, NSString *errorMessage, NSError *error) {
        failure(result, error);
    }];

}

//用户预约挂号
- (void)startOrderWithSlot:(NDSlot *)slot success:(void(^)())success failure:(void(^)(NSDictionary *result,NSError *error))failure{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [param setObject:SafeString(slot.ID) forKey:@"timeslotid"];
    [param setObject:SafeString(slot.actual_date) forKey:@"actual_date"];
    
    [[NDNetManager sharedNetManager] post:@"/app/1/Appointments" parameters:param success:^(NSDictionary *result) {
        
        FLog(@"%@", result);
        
        if([[result allKeys] containsObject:@"data"]){
            NDDoctorMorePreserveWindow *doctor =[NDDoctorMorePreserveWindow objectWithKeyValues:result[@"data"]];
            
            success(doctor);
        }
        
        
        
    } failure:^(NSDictionary *result, NSString *errorMessage, NSError *error) {
        failure(result, error);
    }];
    
}

@end
