//
//  NDRealNameAuth.h
//  newdoc
//
//  Created by zzc on 15/11/9.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import <Foundation/Foundation.h>
//实名认证
@interface NDRealNameAuth : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *newdocid;
@property (nonatomic, copy) NSString *real_name;
@property (nonatomic, copy) NSString *citizenid;
@property (nonatomic, copy) NSString *insuranceid;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *operatorid;
@property (nonatomic, copy) NSString *submit_date;
@property (nonatomic, copy) NSString *update_date;
@end
