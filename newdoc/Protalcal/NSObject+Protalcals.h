//
//  NSObject+Protalcals.h
//  newdoc
//
//  Created by zzc on 15/10/22.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "NDRoom.h"
#import "NDDoctor.h"
#import "NDSubroom.h"

@interface NSObject (Protalcals)
//获取验证码
- (void)startSendVerifyCodeWithPhoneNumber:(NSString *)phoneNumber success:(void(^)(NSObject *resultDic))success failure:(void(^)(NSDictionary *result,NSError *error))failure;

//登录
- (void)startLoginWithUsername:(NSString *)username andPassword:(NSString *)password success:(void(^)(NSObject *resultDic))success failure:(void(^)(NSDictionary *result,NSError *error))failure;

//得到附近的诊室
- (void)startGetRoomListWithLocation:(CLLocationCoordinate2D)coordinate andCityName:(NSString *)city andAreaName:(NSString *)area success:(void(^)(NSArray *rooms))success failure:(void(^)(NSDictionary *result,NSError *error))failure;

//得到省份列表
- (void)startGetProvinceListAndSuccess:(void(^)(NSArray *provinces))success failure:(void(^)(NSDictionary *result,NSError *error))failure;

//得到城市列表
- (void)startGetCityListWithProvince:(NSString *)provinceName success:(void(^)(NSArray *citys))success failure:(void(^)(NSDictionary *result,NSError *error))failure;

//得到区县列表
- (void)startGetCountyListWithCity:(NSString *)cityName success:(void(^)(NSArray *countys))success failure:(void(^)(NSDictionary *result,NSError *error))failure;

//得到诊室详情
- (void)startGetSubroomListWithRoomId:(NSString *)roomId success:(void(^)(NDRoom *room))success failure:(void(^)(NSDictionary *result,NSError *error))failure;

//关注医生
- (void)startAttentionDoctorWithDocId:(NSString *)docId success:(void(^)())success failure:(void(^)(NSDictionary *result,NSError *error))failure;

//取消关注医生
- (void)startCancelAttentionDoctorWithDocId:(NSString *)docId success:(void(^)())success failure:(void(^)(NSDictionary *result,NSError *error))failure;

@end
