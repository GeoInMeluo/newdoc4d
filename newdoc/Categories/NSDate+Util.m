//
//  NSDate+Util.m
//  qiba2
//
//  Created by zzc on 13-11-28.
//  Copyright (c) 2013年 zzc. All rights reserved.
//

#import "NSDate+Util.h"

NSCalendar * g_gregorian;
NSCalendar * sharedCalendar()
{
    if(g_gregorian == nil)
        g_gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    return g_gregorian;
}

@implementation NSDate (Util)

- (NSUInteger)numberOfDaysInCurrentMonth
{
    // 频繁调用 [NSCalendar currentCalendar] 可能存在性能问题
    return [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self].length;
}

- (NSDate *)firstDayOfCurrentMonth
{
    NSDate *startDate = nil;
    BOOL ok = [[NSCalendar currentCalendar] rangeOfUnit:NSMonthCalendarUnit startDate:&startDate interval:NULL forDate:self];
    NSAssert1(ok, @"Failed to calculate the first day of the month based on %@", self);
    return startDate;
}

- (NSUInteger)weeklyOrdinality
{
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSDayCalendarUnit inUnit:NSWeekCalendarUnit forDate:self];
}


-(NSDate*)floorDate
{
    NSDateComponents * tempComponents = [sharedCalendar() components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    NSDate * ret = [sharedCalendar() dateFromComponents:tempComponents];
    return ret;
}
-(NSDate*)ceilDate
{
    NSDate * temp = [NSDate dateWithTimeInterval:3600*24 sinceDate:self];
    return [temp floorDate];
}
-(NSDate*)nextDate
{
    return [NSDate dateWithTimeInterval:3600*24 sinceDate:self];
}
-(NSDate*)prevDate
{
    return [NSDate dateWithTimeInterval:-3600*24 sinceDate:self];
}
-(NSInteger)day
{
    NSDateComponents * tempComponents = [sharedCalendar() components:NSCalendarUnitDay fromDate:self];
    return tempComponents.day;
}
-(NSInteger)month
{
    NSDateComponents * tempComponents = [sharedCalendar() components:NSCalendarUnitMonth fromDate:self];
    return tempComponents.month;
}
-(NSInteger)year
{
    NSDateComponents * tempComponents = [sharedCalendar() components:NSCalendarUnitYear fromDate:self];
    return tempComponents.year;
}
-(NSInteger)minute
{
    NSDateComponents * tempComponents = [sharedCalendar() components:NSCalendarUnitMinute fromDate:self];
    return tempComponents.minute;
}
-(NSInteger)hour
{
    NSDateComponents * tempComponents = [sharedCalendar() components:NSCalendarUnitHour fromDate:self];
    return tempComponents.hour;
}
-(NSString *)displayPastTimeForLocTeam
{
    int seconds = -[self timeIntervalSinceNow];
    if(seconds<0)
        seconds = 0;
    if(seconds<120)
        return [NSString stringWithFormat:@"%d秒前",seconds];
    int minutes = seconds/60;
    if(minutes<60)
        return [NSString stringWithFormat:@"%d分钟前",minutes];
    int hours = minutes/60;
    if(hours<24)
        return [NSString stringWithFormat:@"%d小时前",hours];
    int days = hours/24;
    if(days<30)
        return [NSString stringWithFormat:@"%d天前",days];
    int months = days/30;
    if(months<12)
        return [NSString stringWithFormat:@"%d个月前",months];
    int years = months/12;
    return [NSString stringWithFormat:@"%d年前",years];
}
-(NSString *)displayPastTime
{
    int seconds = ABS([self timeIntervalSinceNow]);
    if(seconds<60)
        return [NSString stringWithFormat:@"刚刚"];
    int minutes = seconds/60;
    if(minutes<60)
        return [NSString stringWithFormat:@"%d分钟前",minutes];
    int hours = minutes/60;
    if(hours<24)
        return [NSString stringWithFormat:@"%d小时前",hours];
    int days = hours/24;
    if(days<30)
        return [NSString stringWithFormat:@"%d天前",days];
    int months = days/30;
    if(months<12)
        return [NSString stringWithFormat:@"%d个月前",months];
    int years = months/12;
    return [NSString stringWithFormat:@"%d年前",years];
}
-(int64_t)timestamp
{
	return [self timeIntervalSince1970] * 1000;
}
-(BOOL)isDay
{
    NSInteger hour = self.hour;
    if(hour>=6 && hour<18)
    {
        return YES;
    }
    return NO;
}
-(BOOL)isRecent:(NSTimeInterval)ti
{
    NSTimeInterval v = ABS([self timeIntervalSinceNow]);
    if(v<ti)
        return YES;
    return NO;
}
-(BOOL)isExpired:(NSTimeInterval)ti
{
    NSTimeInterval v = ABS([self timeIntervalSinceNow]);
    if(v<ti)
        return NO;
    return YES;
}

+(int)dayCountFrom:(NSDate*)d1 to:(NSDate*)d2
{
    if(!d1 && !d2)
        return 0;
    
    if(d1 && d2)
    {
        NSTimeInterval days = ABS([d1 timeIntervalSinceDate:d2]) / (3600*24) + 0.5;
        int dcnt = ceil(days);
        return dcnt;
    }
    return 1;
}
+(int)dayDiffCountFrom:(NSDate*)d1 to:(NSDate*)d2
{
    if(!d1 && !d2)
        return 0;
    
    if(d1 && d2)
    {
        if([d1 compare:d2] == NSOrderedDescending)
        {
            NSDate * t = d1;
            d1 = d2;
            d2 = t;
        }
        NSDate * temp1 = d1.floorDate;
        NSTimeInterval days = ABS([d2 timeIntervalSinceDate:temp1]) / (3600*24);
        int dcnt = floor(days);
        return dcnt;
    }
    return 0;
}
+(NSDate*)dateWithYmd:(NSDate*)d andHms:(NSDate*)t
{
	if(d == nil)
		return t;
	if(t == nil)
		return d;
	
	NSDateComponents * ymd = [sharedCalendar() components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:d];
	NSDateComponents * hms = [sharedCalendar() components:NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:t];
	
	NSDateComponents * ymdhms = [[NSDateComponents alloc] init];
	ymdhms.year = ymd.year;
	ymdhms.month = ymd.month;
	ymdhms.day = ymd.day;
	ymdhms.hour = hms.hour;
	ymdhms.minute = hms.minute;
	ymdhms.second = hms.second;

    NSDate * ret = [sharedCalendar() dateFromComponents:ymdhms];
    return ret;
}
+(NSDate*)dateWithYear:(int)ayear
                month:(int)amonth
                  day:(int)aday
                 hour:(int)ahour
               minute:(int)aminute
               second:(int)asecond
{
    NSDateComponents * c = [NSDateComponents new];
	
	c.year = ayear;
	c.month = amonth;
	c.day = aday;
	c.hour = ahour;
	c.minute = aminute;
	c.second = asecond;
    
    return [sharedCalendar() dateFromComponents:c];
}
-(BOOL)isAfter:(NSDate*)d
{
    if([self compare:d]==NSOrderedDescending)
    {
        return YES;
    }
    return NO;
}
-(BOOL)isBefore:(NSDate*)d
{
    if([self compare:d]==NSOrderedAscending)
    {
        return YES;
    }
    return NO;
}

- (BOOL)isSame2Other:(NSDate *)other;{
    if (other==nil) return NO;
    
//    NSCalendar *cal = [NSCalendar currentCalendar];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:self];
    NSDate *today = [cal dateFromComponents:components];
    components = [cal components:(NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:other];
    NSDate *otherDate = [cal dateFromComponents:components];
    if([today isEqualToDate:otherDate])
        return YES;
    
    return NO;
}

@end

NSDate * dateInterset(NSDate * d1,int cnt1 ,NSDate * d2,int cnt2,int * cntret)
{
    *cntret = 0;
    NSDate * d1x = d1.floorDate;
    NSDate * d2x = d2.floorDate;
    
    int daysub = [d2x timeIntervalSinceDate:d1x]/(3600*24);
    if(daysub < 0)
    {
        daysub = -daysub;
        if(cnt2<=daysub)
            return nil;
        else
        {
            if(cnt2<=daysub+cnt1)
                *cntret = cnt2 - daysub;
            else
                *cntret = cnt1;
            return d1;
        }
    }
    else if(daysub > 0)
    {
        if(daysub>=cnt1)
            return nil;
        else
        {
            if(daysub+cnt2>cnt1)
                *cntret = cnt1-daysub;
            else
                *cntret = cnt2;
            return d2;
        }
    }
    else
    {
        *cntret = MIN(cnt1, cnt2);
        return d1;
    }
//    NSDateComponents * d1Components = [sharedCalendar() components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:d1];
//    NSDateComponents * d2Components = [sharedCalendar() components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:d2];
//    
}
int64_t datetime2Timestamp(NSDate * date)
{
	return [date timeIntervalSince1970] * 1000;
}
NSDate* timestamp2Datetime(int64_t timestamp)
{
    if(timestamp > 0)
        return [NSDate dateWithTimeIntervalSince1970:timestamp/1000.0];
    return nil;
}



NSString* timestamp2String_chinese(int64_t timestamp){
    NSDate *date = timestamp2Datetime(timestamp);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    dateFormatter.locale =  [NSLocale localeWithLocaleIdentifier:@"zh"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}
NSString* timestamp2String_chinese2(int64_t timestamp){
    NSDate *date = timestamp2Datetime(timestamp);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}
NSString * datetime2FormatString(NSDate * date,NSString * sformat)
{
    if(date)
    {
        NSDateFormatter *dateFormat = [NSDateFormatter new];
        [dateFormat setDateFormat:sformat];
        return [dateFormat stringFromDate:date];
    }
    else
        return @"";
}
NSString * date2String(NSDate * date)
{
	NSDateFormatter *dateFormat = [NSDateFormatter new];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    return [dateFormat stringFromDate:date];
}
NSString * date2Simeple_String(NSDate * date)
{
    NSDateFormatter *dateFormat = [NSDateFormatter new];
    [dateFormat setDateFormat:@"yyyyMMdd"];
    return [dateFormat stringFromDate:date];
}

NSDate * string2Date(NSString * s)
{
	NSDateFormatter *dateFormat = [NSDateFormatter new];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    return [dateFormat dateFromString:s];
}

NSDate * string2Date2(NSString * s)
{
    NSDateFormatter *dateFormat = [NSDateFormatter new];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormat dateFromString:s];
}

NSString * datetime2String(NSDate * date)
{
    if(date)
    {
        NSDateFormatter *dateFormat = [NSDateFormatter new];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        return [dateFormat stringFromDate:date];
    }
    else
        return @"";
}
NSString * time2String(NSDate * date)
{
    if(date)
    {
        NSDateFormatter *dateFormat = [NSDateFormatter new];
        [dateFormat setDateFormat:@"HH:mm"];
        return [dateFormat stringFromDate:date];
    }
    else
        return @"";
}
NSString * date2StringShort(NSDate * date)
{
	NSDateFormatter *dateFormat = [NSDateFormatter new];
    [dateFormat setDateFormat:@"yy年M月d日"];
    return [dateFormat stringFromDate:date];
}
NSString* date2WeekString(NSDate * date)
{
    return datetime2FormatString(date, @"EEEE");
}
NSString * date2StringShort_NoYear(NSDate * date)
{
    NSDateFormatter *dateFormat = [NSDateFormatter new];
    [dateFormat setDateFormat:@"M月d日"];
    return [dateFormat stringFromDate:date];
}
NSString * date2StringLong(NSDate * date)
{
	NSDateFormatter *dateFormat = [NSDateFormatter new];
    [dateFormat setDateFormat:@"yyyy年M月d日"];
    return [dateFormat stringFromDate:date];
}

NSString * datetime2StringShort(NSDate * date)
{
	NSDateFormatter *dateFormat = [NSDateFormatter new];
    [dateFormat setDateFormat:@"yy年M月d日 HH:mm"];
    return [dateFormat stringFromDate:date];
}
//NSString * datetime2StringFilename(NSDate * date)
//{
//	NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
//    [dateFormat setDateFormat:@"MM_dd__HH_mm_ss"];
//    return [dateFormat stringFromDate:date];
//}
NSString* timestamp2String_smart(int64_t timestamp)
{
    NSDate * date = timestamp2Datetime(timestamp);
    return date.displayPastTime;
}
NSDate * string2Datetime(NSString * s)
{
	NSDateFormatter *dateFormat = [NSDateFormatter new];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormat dateFromString:s];
}