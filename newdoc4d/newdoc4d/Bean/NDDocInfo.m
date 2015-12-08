//
//  NDDocInfo.m
//  newdoc4d
//
//  Created by zzc on 15/12/2.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDDocInfo.h"

@implementation NDDocInfo
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}

+ (NSDictionary *)objectClassInArray{
    return @{@"signed_rooms" : @"NDSampleRoom",@"appli_rooms":@"NDSampleRoom"};
}
@end
