//
//  NDDoctorMorePreserveWindow.m
//  newdoc
//
//  Created by zzc on 15/10/30.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDDoctorMorePreserveWindow.h"

@implementation NDDoctorMorePreserveWindow
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}

+ (NSDictionary *)objectClassInArray{
    return @{@"catalog" : @"NDSubroom",@"preserve_window":@"NDPreserveWindow"};
}
@end
