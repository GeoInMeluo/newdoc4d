//
//  NDDoctorIntro.m
//  newdoc
//
//  Created by zzc on 15/10/30.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDDoctorIntro.h"

@implementation NDDoctorIntro
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}

+ (NSDictionary *)objectClassInArray{
    return @{@"catalogs" : @"NDSubroom"};
}
@end
