//
//  NDRoom.h
//  newdoc
//
//  Created by zzc on 15/10/27.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import <Foundation/Foundation.h>
//诊室
@interface NDRoom : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *city_code;
@property (nonatomic, copy) NSString *area_code;
@property (nonatomic, copy) NSString *rating;
@property (nonatomic, assign) BOOL isBound;
@property (nonatomic, strong) NSArray *catalogs;
@property (nonatomic, strong) NSArray *doctors;

@end
