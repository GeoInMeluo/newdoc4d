//
//  NDManageRoomOrder.h
//  newdoc4d
//
//  Created by zzc on 15/12/3.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 {
     "actual_date" = "2015-12-05";
     address = "B\U8857\U905301\U53f7";
     id = 2;
     latitude = "24.300";
     longitude = "109.010";
     name = "\U67f3\U5dde\U8bca\U5ba42";
     reserved = 0;
     status = 1;
     timescope = "09:00-11:30";
     ts = 1449277200;
 }
 */

@interface NDManageRoomOrder : NSObject
@property (nonatomic, copy) NSString *actual_date;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *reserved;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *timescope;
@property (nonatomic, copy) NSString *ts;
@end
