//
//  NDDoctor.m
//  newdoc
//
//  Created by zzc on 15/10/28.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDDoctor.h"
//医生
@implementation NDDoctor
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID" : @"id", @"slots" : @"preserve_window"};
}

//+ (NSDictionary *)objectClassInArray{
//    return @{@"catalog" : @"NDSubroom"};
//}

+ (NSDictionary *)objectClassInArray{
    return @{@"catalog" : @"NDSubroom",@"slots":@"NDSlot"};
}
@end
