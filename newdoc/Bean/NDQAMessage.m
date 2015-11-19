//
//  NDQAMessage.m
//  newdoc
//
//  Created by zzc on 15/11/18.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDQAMessage.h"

@implementation NDQAMessage
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID" : @"id",@"start_date":[NSString stringWithFormat:@"\"start_date\""]};
}
@end
