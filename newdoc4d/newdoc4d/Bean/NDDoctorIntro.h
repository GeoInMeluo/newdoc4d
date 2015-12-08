//
//  NDDoctorIntro.h
//  newdoc
//
//  Created by zzc on 15/10/30.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NDDoctorIntro : NSObject
@property (nonatomic, copy) NSString *ID;
//照片url
@property (nonatomic, copy) NSString *picture_url;
//擅长
@property (nonatomic, copy) NSString *goodat;
//头衔
@property (nonatomic, copy) NSString *title;
//从业年
@property (nonatomic, copy) NSString *start_year;
//当前的从业年限
@property (nonatomic, copy) NSString *years;
//当前医生的评分
@property (nonatomic, copy) NSString *rating;
//工作经历和简介
@property (nonatomic, copy) NSString *detail;
//性别
@property (nonatomic, assign) BOOL sex;
//出生年月
@property (nonatomic, copy) NSString *birth;
//毕业学校
@property (nonatomic, copy) NSString *graduate_college;
//毕业时间
@property (nonatomic, copy) NSString *graduate_year;
//工作经历
@property (nonatomic, copy) NSString *work_experience;
//研究成果
@property (nonatomic, copy) NSString *research;
//医生所属科室
@property (nonatomic, strong) NSArray *catalogs;

@end
