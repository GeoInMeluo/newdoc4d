//
//  NDDoctorComment.h
//  newdoc
//
//  Created by zzc on 15/10/30.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NDDoctorComment : NSObject
/*
 actual_date		就诊日期，格式2015-10-05
	doctor_comment	对医生的评论，string(128)
	doctor_rating		评分，int
	picture_url		图片url
	name			用户名，打**加密，string，例如ab*****
 */
@property (nonatomic, copy) NSString *actual_date;
@property (nonatomic, copy) NSString *doctor_comment;
@property (nonatomic, copy) NSString *doctor_rating;
@property (nonatomic, copy) NSString *picture_url;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *doctor_response;
@end
