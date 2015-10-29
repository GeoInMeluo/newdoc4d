//
//  NDPreserveWindow.h
//  newdoc
//
//  Created by zzc on 15/10/28.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import <Foundation/Foundation.h>
//预约窗口
@interface NDPreserveWindow : NSObject
@property (nonatomic, copy) NSString *ID;
//实际日期
@property (nonatomic, copy) NSString *actual_date;
//开放的时间段
@property (nonatomic, copy) NSString *timescope;
//开始时间的ts
@property (nonatomic, copy) NSString *ts;
//是否可预约
@property (nonatomic, assign) BOOL status;
@end
