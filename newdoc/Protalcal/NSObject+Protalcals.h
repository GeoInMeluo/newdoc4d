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
#import "NDDoctorIntro.h"
#import "NDDoctorComment.h"
#import "NDDoctorMorePreserveWindow.h"
#import "NDSlot.h"

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
- (void)startGetRoomWithRoomId:(NSString *)roomId success:(void(^)(NDRoom *room))success failure:(void(^)(NSDictionary *result,NSError *error))failure;

//关注医生
- (void)startAttentionDoctorWithDocId:(NSString *)docId success:(void(^)())success failure:(void(^)(NSDictionary *result,NSError *error))failure;

//取消关注医生
- (void)startCancelAttentionDoctorWithDocId:(NSString *)docId success:(void(^)())success failure:(void(^)(NSDictionary *result,NSError *error))failure;

//得到医生简介
- (void)startGetDoctorIntroWithDocId:(NSString *)docId success:(void(^)( NDDoctorIntro *intro))success failure:(void(^)(NSDictionary *result,NSError *error))failure;

//得到医生的所有评论
- (void)startGetDoctorCommentsWithDocId:(NSString *)docId success:(void(^)( NSArray *docComments))success failure:(void(^)(NSDictionary *result,NSError *error))failure;

//得到医生详情(预约内使用的医生数据模型)
- (void)startGetDoctorDetailWithDocId:(NSString *)docId andRoomId:(NSString *)roomId success:(void(^)( NDDoctorMorePreserveWindow *doctorMorePreserveWindow))success failure:(void(^)(NSDictionary *result,NSError *error))failure;

//用户预约挂号
- (void)startOrderWithSlot:(NDSlot *)slot success:(void(^)())success failure:(void(^)(NSDictionary *result,NSError *error))failure;

//主动注册
- (void)startRegistWithUsername:(NSString *)username andPassWord:(NSString *)pwd andVerifyCode:(NSString *)verifyCode  success:(void(^)())success failure:(void(^)(NSDictionary *result,NSError *error))failure;
@end
