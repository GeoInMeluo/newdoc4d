//
//  MyFoundation.m
//  newdoc
//
//  Created by zzc on 15/10/22.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "MyFoundation.h"

void ShowAlert(NSString * text)
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:text delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
    [alert show];
}

NSString * SafeString(NSString * s)
{
    if(s == nil)
        return @"";
    return s;
}

NSValue * SafeValue(NSValue * value){
    if(value == nil){
        return [NSValue new];
    }
    return value;
}

NSNumber * SafeNumber(NSNumber * n){
    if(n == nil){
        return [NSNumber new];
    }
    return n;
}