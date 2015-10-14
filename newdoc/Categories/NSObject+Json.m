//
//  NSObject+Json.m
//  NewChinaHealthy
//
//  Created by 换个名称 on 15-9-18.
//  Copyright (c) 2015年 NCH. All rights reserved.
//

#import "NSObject+Json.h"

@implementation NSObject (Json)
- (NSString *)jsonString{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}
@end
