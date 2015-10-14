//
//  MyFoundation_Util.m
//  NewChinaHealthy
//
//  Created by zzc on 15/8/4.
//  Copyright (c) 2015年 NCH. All rights reserved.
//

#import "MyFoundation_Util.h"

@implementation MyFoundation_Util
NSString * SafeString(NSString * s)
{
    if(s == nil)
        return @"";
    return s;
}
@end
