//
//  NDDocInfo.h
//  newdoc4d
//
//  Created by zzc on 15/12/2.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NDDocInfo : NSObject
/*
    id			医生的i d
	newdocid		id
	birth			生日
	picture_url		头像
	graduate_college	毕业院校
	graduate_year 	毕业时间
	work_experience	工作经历
	research 		研究经历
	goodat			擅长
	detail			毕业院校
	status			状态，保留中
	title 			职位，主任医师或者
	start_year 		从医开始时间
 
	signed_rooms		已经签约的诊室
 "name": "南宁诊室1",
 "id": "5",
 "address": "Z街道01号"
	appli_rooms		申请签约的诊室
 "name": "南宁诊室1",
 "id": "5",
 "address": "Z街道01号"
 
	catalogs		科室列表
 "id": "5",
 "name": "妇科"
 */
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *birth;
@property (nonatomic, copy) NSString *picture_url;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *signed_rooms;
@property (nonatomic, strong) NSArray *appli_rooms;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *goodat;
@property (nonatomic, copy) NSString *detail;

@end
