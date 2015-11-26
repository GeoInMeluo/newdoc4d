//
//  NSDate+Util.h
//  qiba2
//
//  Created by zzc on 13-11-28.
//  Copyright (c) 2013年 zzc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Util)

@property(nonatomic,readonly) NSInteger year;
@property(nonatomic,readonly) NSInteger month;
@property(nonatomic,readonly) NSInteger day;
@property(nonatomic,readonly) NSInteger hour;
@property(nonatomic,readonly) NSInteger minute;
@property(nonatomic,readonly) NSString * displayPastTime;
@property(nonatomic,readonly) NSString * displayPastTimeForLocTeam;
@property(nonatomic,readonly) BOOL isDay;

//这个月有多少天
- (NSUInteger)numberOfDaysInCurrentMonth;

//这个月第一天的日期
- (NSDate *)firstDayOfCurrentMonth;

//这一天是星期几
- (NSUInteger)weeklyOrdinality;


-(NSDate*)floorDate;
-(NSDate*)ceilDate;
-(NSDate*)nextDate;
-(NSDate*)prevDate;
-(int64_t)timestamp;

-(BOOL)isRecent:(NSTimeInterval)ti;
-(BOOL)isExpired:(NSTimeInterval)ti;

+(int)dayCountFrom:(NSDate*)d1 to:(NSDate*)d2;
+(int)dayDiffCountFrom:(NSDate*)d1 to:(NSDate*)d2;
+(NSDate*)dateWithYmd:(NSDate*)d andHms:(NSDate*)t;

+(NSDate*)dateWithYear:(int)ayear
                month:(int)amonth
                  day:(int)aday
                 hour:(int)ahour
               minute:(int)aminute
               second:(int)asecond;
//+(void)test;
-(BOOL)isAfter:(NSDate*)d;
-(BOOL)isBefore:(NSDate*)d;

//判断两个日期是否是同一天
- (BOOL)isSame2Other:(NSDate *)other;

@end
NSCalendar * sharedCalendar();

NSDate * dateInterset(NSDate * d1,int cnt1 ,NSDate * d2,int cnt2,int * cntret);

NSString * datetime2FormatString(NSDate * date,NSString * sformat);
int64_t datetime2Timestamp(NSDate * date);
NSDate* timestamp2Datetime(int64_t timestamp);
NSString* timestamp2String_chinese(int64_t timestamp);
NSString* timestamp2String_chinese2(int64_t timestamp);
NSString * date2String(NSDate * date);
NSString * date2Simeple_String(NSDate * date);
NSDate * string2Date(NSString * s);
NSDate * string2Date2(NSString * s);
NSString * datetime2String(NSDate * date);
NSDate * string2Datetime(NSString * s);
NSString * date2StringShort(NSDate * date);
NSString* date2WeekString(NSDate * date);
NSString * date2StringShort_NoYear(NSDate * date);
NSString * date2StringLong(NSDate * date);
NSString * datetime2StringShort(NSDate * date);
NSString * time2String(NSDate * date);
NSString* timestamp2String_smart(int64_t timestamp);
