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
- (void)startSendVerifyCodeWithPhoneNumber:(NSString *)phoneNumber success:(void(^)(NSObject *resultDic))success failure:(void(^)(NSString *error_message))failure{

    NSDictionary *param = @{@"mobile":SafeString(phoneNumber),
                            @"f":@"reg"};
    

    [[NDNetManager sharedNetManager] post:@"/Common/1/sms" parameters:param success:^(NSDictionary *result) {
        success(result);
    } failure:^(NSString *error_message) {
        failure(error_message);
    }];
}

//得到附近的诊室
- (void)startGetRoomListWithLocation:(CLLocationCoordinate2D)coordinate andCityName:(NSString *)city andAreaName:(NSString *)area success:(void(^)(NSArray *rooms))success failure:(void(^)(NSString *error_message))failure{
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

    } failure:^(NSString *error_message) {
        failure(error_message);
    }];
}

//得到省份列表
- (void)startGetProvinceListAndSuccess:(void(^)(NSArray *provinces))success failure:(void(^)(NSString *error_message))failure{
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
        
    } failure:^(NSString *error_message) {
        failure(error_message);
    }];

}

//得到城市列表
- (void)startGetCityListWithProvince:(NSString *)provinceName success:(void(^)(NSArray *citys))success failure:(void(^)(NSString *error_message))failure{
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
        
    } failure:^(NSString *error_message) {
        failure(error_message);
    }];
;

}

//得到区县列表
- (void)startGetCountyListWithCity:(NSString *)cityName success:(void(^)(NSArray *countys))success failure:(void(^)(NSString *error_message))failure{
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
    } failure:^(NSString *error_message) {
        failure(error_message);
    }];

}

//得到诊室详情
- (void)startGetRoomWithRoomId:(NSString *)roomId success:(void(^)(NDRoom *room))success failure:(void(^)(NSString *error_message))failure{
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
        
    } failure:^(NSString *error_message) {
        failure(error_message);
    }];

}

//关注医生
- (void)startAttentionDoctorWithDocId:(NSString *)docId success:(void(^)())success failure:(void(^)(NSString *error_message))failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [param setObject:SafeString(docId) forKey:@"doctorid"];
    
    [[NDNetManager sharedNetManager] post:@"app/1/Focus" parameters:param success:^(NSDictionary *result) {
        success();
        
    } failure:^(NSString *error_message) {
        failure(error_message);
    }];


}

//取消关注医生
- (void)startCancelAttentionDoctorWithDocId:(NSString *)docId success:(void(^)())success failure:(void(^)(NSString *error_message))failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [param setObject:SafeString(docId) forKey:@"doctorid"];
    [param setObject:@"del" forKey:@"action"];
    
    [[NDNetManager sharedNetManager] post:@"app/1/Focus" parameters:param success:^(NSDictionary *result) {
        success();
        
    } failure:^(NSString *error_message) {
        failure(error_message);
    }];

}

//得到医生简介
- (void)startGetDoctorIntroWithDocId:(NSString *)docId success:(void(^)( NDDoctorIntro *intro))success failure:(void(^)(NSString *error_message))failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [[NDNetManager sharedNetManager] get:[NSString stringWithFormat:@"/app/1/Doctors/%@?action=intro",SafeString(docId)] parameters:param success:^(NSDictionary *result) {
        //        NSMutableArray *subRooms = [NSMutableArray array];
        
        FLog(@"%@", result);
        
        if([[result allKeys] containsObject:@"data"]){
            NDDoctorIntro *intro = [NDDoctorIntro objectWithKeyValues:result[@"data"]];
            success(intro);
        }
        
    } failure:^(NSString *error_message) {
        failure(error_message);
    }];

}


//得到医生的所有评论
- (void)startGetDoctorCommentsWithDocId:(NSString *)docId success:(void(^)( NSArray *docComments))success failure:(void(^)(NSString *error_message))failure{
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
        
    } failure:^(NSString *error_message) {
        failure(error_message);
    }];

}

//得到医生详情(预约内使用的医生数据模型)
- (void)startGetDoctorDetailWithDocId:(NSString *)docId andRoomId:(NSString *)roomId success:(void(^)( NDDoctorMorePreserveWindow *doctorMorePreserveWindow))success failure:(void(^)(NSString *error_message))failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [param setObject:SafeString(roomId) forKey:@"roomid"];
    
    [[NDNetManager sharedNetManager] get:[NSString stringWithFormat:@"/app/1/Doctors/%@?action=index",SafeString(docId)] parameters:param success:^(NSDictionary *result) {
        
        FLog(@"%@", result);
        
        if([[result allKeys] containsObject:@"data"]){
            NDDoctorMorePreserveWindow *doctor =[NDDoctorMorePreserveWindow objectWithKeyValues:result[@"data"]];
            
            success(doctor);
        }
        
        
    } failure:^(NSString *error_message) {
        failure(error_message);
    }];

}

//用户预约挂号
- (void)startOrderWithSlot:(NDSlot *)slot success:(void(^)())success failure:(void(^)(NSString *error_message))failure{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [param setObject:SafeString(slot.ID) forKey:@"timeslotid"];
    [param setObject:SafeString(slot.actual_date) forKey:@"actual_date"];
    
    [[NDNetManager sharedNetManager] post:@"/app/1/Appointments" parameters:param success:^(NSDictionary *result) {
        
        FLog(@"%@", result);
        
//        if([[result allKeys] containsObject:@"data"]){
//            NDDoctorMorePreserveWindow *doctor =[NDDoctorMorePreserveWindow objectWithKeyValues:result[@"data"]];
//            
//            success(doctor);
//        }
        
        
        
    } failure:^(NSString *error_message) {
        failure(error_message);
    }];
    
}

//主动注册
- (void)startRegistWithUsername:(NSString *)username andPassWord:(NSString *)pwd andVerifyCode:(NSString *)verifyCode andPhoneNumber:(NSString *)phoneNumber success:(void(^)())success failure:(void(^)(NSString *error_message))failure{
    WEAK_SELF;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [param setObject:SafeString(username) forKey:@"newdocid"];
    [param setObject:MD5_NSString(pwd) forKey:@"passwdMd5"];
    [param setObject:SafeString(phoneNumber) forKey:@"mobile"];
    [param setObject:SafeString(verifyCode) forKey:@"smstoken"];
    
    [[NDNetManager sharedNetManager] post:@"/Common/1/reg" parameters:param success:^(NSDictionary *result) {
        
        FLog(@"%@", result);
        //注册成功后直接登陆
        if([[result allKeys] containsObject:@"retcode"]){
            if([result[@"retcode"] isEqualToString:@"0"]){
                [weakself startLoginWithUsername:username andPassWord:pwd success:^{
                    
                    success();
                    
                } failure:^(NSString *error_message) {
                    failure(error_message);
                }];
            }
        }
        
    } failure:^(NSString *error_message) {
        failure(error_message);
    }];

}


//主动登陆
- (void)startLoginWithUsername:(NSString *)username andPassWord:(NSString *)pwd success:(void(^)())success failure:(void(^)(NSString *error_message))failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [param setObject:SafeString(username) forKey:@"newdocid"];
    NSString *md5String = MD5_NSString([NSString stringWithFormat:@"%@:%@",username,pwd]);
    FLog(@"%@", md5String);
    NSString *finalString = [NSString stringWithFormat:@"Basic %@",md5String];
    
    [[NDNetManager sharedNetManager].requestSerializer setValue:finalString forHTTPHeaderField:@"Authorization"];
    
    [[NDNetManager sharedNetManager] post:@"/Common/1/login" parameters:param success:^(NSDictionary *result) {
        
        FLog(@"%@", result);
        
        success();
        
        
        
    } failure:^(NSString *error_message) {
        failure(error_message);
    }];
}

//绑定诊室
- (void)startBindRoomWithRoomId:(NSString *)roomId success:(void(^)())success failure:(void(^)(NSString *error_message))failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [param setObject:SafeString(roomId) forKey:@"roomid"];
    
    [[NDNetManager sharedNetManager] post:@"/app/1/Binding" parameters:param success:^(NSDictionary *result) {
        
        FLog(@"%@", result);
        
        
        
        success();
        
    } failure:^(NSString *error_message) {
        failure(error_message);
    }];
}

//取消绑定诊室
- (void)startCancelBindRoomWithRoomId:(NSString *)roomId success:(void(^)())success failure:(void(^)(NSString *error_message))failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [param setObject:SafeString(roomId) forKey:@"roomid"];
    [param setObject:@"del" forKey:@"action"];
    
    [[NDNetManager sharedNetManager] post:@"/app/1/Binding?action=del" parameters:param success:^(NSDictionary *result) {
        
        FLog(@"%@", result);
        
        
        
        success();
        
    } failure:^(NSString *error_message) {
        failure(error_message);
    }];
}

//用户信息
- (void)startGetUserInfoAndSuccess:(void(^)(NDUser *user))success failure:(void(^)(NSString *error_message))failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [[NDNetManager sharedNetManager] get:@"/app/1/Clients?action=index" parameters:param success:^(NSDictionary *result) {
        
        FLog(@"%@", result);
        
        if([[result allKeys] containsObject:@"data"]){
            NDUser *user = [NDUser objectWithKeyValues:result[@"data"]];
            
            FLog(@"%@", user);
            FLog(@"%@", result[@"data"]);
            
            success(user);
        }
        
    } failure:^(NSString *error_message) {
        failure(error_message);
    }];
}

//编辑用户信息（先不写）
- (void)startEditUserInfo:(NDUser *)user success:(void(^)(NDUser *user))success failure:(void(^)(NSString *error_message))failure{
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
////    [param setValue:user.name forKey:@""];
//    [param setValue:user.name forKey:@""];
//    
//    
//    [[NDNetManager sharedNetManager] post:@"/app/1/Clients" parameters:param success:^(NSDictionary *result) {
//        
//        FLog(@"%@", result);
//        
//        if([[result allKeys] containsObject:@"data"]){
//            NDUser *user = [NDUser objectWithKeyValues:result[@"data"]];
//            
//            FLog(@"%@", user);
//            FLog(@"%@", result[@"data"]);
//            
//            success(user);
//        }
//        
//    } failure:^(NSString *error_message) {
//        failure(error_message);
//    }];

}

//发送信息更新验证码
- (void)startSendVerifyCodeForUpdatePasswordWithPhoneNumber:(NSString *)phoneNumber success:(void(^)(NSObject *resultDic))success failure:(void(^)(NSString *error_message))failure{
    NSDictionary *param = @{@"mobile":SafeString(phoneNumber),
                            @"f":@"secure"};
    
    
    [[NDNetManager sharedNetManager] post:@"/Common/1/sms" parameters:param success:^(NSDictionary *result) {
        success(result);
    } failure:^(NSString *error_message) {
        failure(error_message);
    }];
}


//忘记密码，用手机号找回更新密码
- (void)startResetPasswordWithPhoneNumber:(NSString *)phoneNumber andVerifyCode:(NSString *)verifyCode andNewPassword:(NSString *)newPwd success:(void(^)(NSObject *resultDic))success failure:(void(^)(NSString *error_message))failure{
    NSDictionary *param = @{ @"mobile":SafeString(phoneNumber),
                             @"smstoken":SafeString(verifyCode),
                            @"new":MD5_NSString(newPwd)};
    
    
    [[NDNetManager sharedNetManager] post:@"/Common/1/forget" parameters:param success:^(NSDictionary *result) {
        success(result);
    } failure:^(NSString *error_message) {
        failure(error_message);
    }];

}

//微信注册接口
- (void)startRegistWithWXCode:(NSString *)code success:(void(^)(NSObject *resultDic))success failure:(void(^)(NSString *error_message))failure{
    NSDictionary *param = @{ @"type":@"app",
                             @"code":SafeString(code)};
    
    
    [[NDNetManager sharedNetManager] post:@"/Common/1/wxlogin" parameters:param success:^(NSDictionary *result) {
        success(result);
    } failure:^(NSString *error_message) {
        failure(error_message);
    }];
}

//实名认证
- (void)startRealNameAuthenticationWithName:(NSString *)name andIdCard:(NSString *)idCard andCitizenNumber:(NSString *)citizenNumber success:(void(^)(NSObject *resultDic))success failure:(void(^)(NSString *error_message))failure{
    
    NSDictionary *item = @{@"real_name":SafeString(name),
                            @"citizenid":SafeString(idCard),
                            @"insuranceid":SafeString(citizenNumber)};
    
    NSArray *items = @[item];
    
    FLog(@"%@", items);
    
    if(items == nil){
        return;
    }
    
    NSString *jsonStr = [items jsonString];
    
    FLog(@"%@", jsonStr);
    
    NSDictionary *param = @{ @"action":@"realname",
                             @"items":jsonStr};
    
    [[NDNetManager sharedNetManager] post:@"/app/1/Clients" parameters:param success:^(NSDictionary *result) {
        success(result);
    } failure:^(NSString *error_message) {
        failure(error_message);
    }];
}

//得到实名认证信息
//- (void)startGetRealNameAuthenticationWithNameAndSuccess:(void(^)(NDRealNameAuth *realNameAuth))success failure:(void(^)(NSString *error_message))failure{
//    NSDictionary *param = [NSDictionary dictionary];
//    
//    [[NDNetManager sharedNetManager] get:@"/Common/1/wxlogin" parameters:param success:^(NSDictionary *result) {
//        if([[result allKeys] containsObject:@"data"]){
//            NDRealNameAuth *auth = [NDRealNameAuth objectWithKeyValues:result[@"data"]];
//            
//            success(auth);
//        }
//    } failure:^(NSString *error_message) {
//        failure(error_message);
//    }];
//}

//得到用户关注的医生
- (void)startGetAttetionDocsWithAndSuccess:(void(^)(NSArray *doc))success failure:(void(^)(NSString *error_message))failure{
    NSDictionary *param = @{ @"pageNum":@"0",
                             @"pageCnt":@"10"};
    
    
    [[NDNetManager sharedNetManager] get:@"/app/1/Focus?action=index" parameters:param success:^(NSDictionary *result) {
        FLog(@"%@",result);
        
        if([[result allKeys] containsObject:@"data"]){
#pragma 返回数据少参数
/*
 data =     {
 cnt = 1;
 hasNext = 0;
 pageCnt = 10;
 pageNum = 0;
 subs =         (
 {
 id = 1;
 name = "jone smith";
 "picture_url" = "";
 }
 );
 };
 */
        }
        
    } failure:^(NSString *error_message) {
        failure(error_message);
    }];
}

//得到咨询列表
- (void)startGetRefersWithAndSuccess:(void(^)(NSArray *refers))success failure:(void(^)(NSString *error_message))failure{
    NSDictionary *param = @{ @"pageNum":@"0",
                             @"pageCnt":@"10"};
    
    
    [[NDNetManager sharedNetManager] get:@"/app/1/Consults?action=index" parameters:param success:^(NSDictionary *result) {
        FLog(@"%@",result);
        
        if([[result allKeys] containsObject:@"data"]){
#pragma 返回数据少参数
            /*
             
             */
        }
        
    } failure:^(NSString *error_message) {
        failure(error_message);
    }];
}

// 得到用户的预约
- (void)startGetOrdersWithAndSuccess:(void(^)(NSArray *orders))success failure:(void(^)(NSString *error_message))failure{
    NSDictionary *param = @{ @"pageNum":@"0",
                             @"pageCnt":@"10"};
    
    
    [[NDNetManager sharedNetManager] get:@"/app/1/Appointments" parameters:param success:^(NSDictionary *result) {
        FLog(@"%@",result);
        
        NSMutableArray *orders = [NSMutableArray array];
        
        if([[result allKeys] containsObject:@"data"]){
            if([[result[@"data"] allKeys] containsObject:@"subs"]){
                for(id obj in result[@"data"][@"subs"]){
                    NDOrder *order = [NDOrder objectWithKeyValues:obj];
                    [orders addObject:order];
                }
                
                success(orders);
            }
        }
        
    } failure:^(NSString *error_message) {
        failure(error_message);
    }];
};

//得到用户的病历列表
- (void)startGetEhrsWithAndSuccess:(void(^)(NSArray *ehrs))success failure:(void(^)(NSString *error_message))failure{
    NSDictionary *param = @{ @"pageNum":@"0",
                             @"pageCnt":@"10"};
    
    
    [[NDNetManager sharedNetManager] get:@"/app/1/Medhistorys?action=index" parameters:param success:^(NSDictionary *result) {
        FLog(@"%@",result);
        
        NSMutableArray *ehrs = [NSMutableArray array];
        
        if([[result allKeys] containsObject:@"data"]){
            if([[result[@"data"] allKeys] containsObject:@"subs"]){
                for(id obj in result[@"data"][@"subs"]){
                    NDEhr *ehr = [NDEhr objectWithKeyValues:obj];
                    [ehrs addObject:ehr];
                }
                
                success(ehrs);
            }
        }
        
    } failure:^(NSString *error_message) {
        failure(error_message);
    }];

}


//得到用户的绑定的诊室
- (void)startGetBindRoomsWithAndSuccess:(void(^)(NSArray *roomNames))success failure:(void(^)(NSString *error_message))failure{
    NSDictionary *param = @{ @"pageNum":@"0",
                             @"pageCnt":@"10"};
    
    
    [[NDNetManager sharedNetManager] get:@"/app/1/Binding?action=index" parameters:param success:^(NSDictionary *result) {
        FLog(@"%@",result);
        
        if([[result allKeys] containsObject:@"data"]){
            if([[result[@"data"] allKeys] containsObject:@"subs"]){
                NSArray *roomNames = result[@"data"][@"subs"];
                success(roomNames);
            }
        }
        
    } failure:^(NSString *error_message) {
        failure(error_message);
    }];
}
@end
