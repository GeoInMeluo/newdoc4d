//
//  NDRoom.m
//  newdoc
//
//  Created by zzc on 15/10/27.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDRoom.h"

@implementation NDRoom
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID" : @"id",@"doctors":@"doctors.subs"};
}

+ (NSDictionary *)objectClassInArray{
    return @{@"catalogs" : @"NDSubroom",@"doctors":@"NDDoctor"};
}
@end
