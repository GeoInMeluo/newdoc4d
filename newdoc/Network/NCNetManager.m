//
//  NCNetManager.m
//  newdoc
//
//  Created by zzc on 15/10/9.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NCNetManager.h"

@implementation NCNetManager

+ (instancetype)sharedNetManager {
    static NCNetManager *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[self alloc] initWithBaseURL:[NSURL URLWithString:@""]];

        NSMutableSet *set = [NSMutableSet setWithSet:instance.responseSerializer.acceptableContentTypes];
        [set addObject:@"text/html"];
        instance.responseSerializer.acceptableContentTypes = set;
        
    });
    return instance;
}
@end
