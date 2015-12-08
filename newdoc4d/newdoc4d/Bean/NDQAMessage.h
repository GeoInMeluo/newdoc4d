//
//  NDQAMessage.h
//  newdoc
//
//  Created by zzc on 15/11/18.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NDQAMessage : NSObject
/*
 "id": "2",
 "clientid": "newdocid00weixin000000001",
 "doctorid": "",
 "catalogid": "4",
 "sex": "1",
 "age": "45",
 "content": "content2",
 "status": 1,
 "start_date": "2015-10-11 10:00:00",
 "close_date": "0000-00-00 00:00:00",
 "doctor_rating": null,
 "doctor_comment": null
 */

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *clientid;
@property (nonatomic, copy) NSString *doctorid;
@property (nonatomic, copy) NSString *catalogid;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) NSInteger *status;
@property (nonatomic, copy) NSString *start_date;
@property (nonatomic, copy) NSString *close_date;
@property (nonatomic, copy) NSString *doctor_rating;
@property (nonatomic, copy) NSString *doctor_comment;
@end
